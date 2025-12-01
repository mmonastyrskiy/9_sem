
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../character.dart';

class HiveService {
  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    
    // Регистрируем все адаптеры
    Hive.registerAdapter(CharacterAdapter());
    // Добавьте другие адаптеры по мере создания
    
    await Hive.openBox<Character>('characters');
  }
}
// В CharacterRepository добавьте:
class CharacterRepository {
  final Box<Character> box;

  CharacterRepository(this.box);

  // Добавить нового персонажа
  void addCharacter(Character character) {
    box.add(character); // Это добавит нового персонажа в конец списка
    //print("Персонаж добавлен ${character.name}");
  }

  // Обновить существующего персонажа
void safeUpdate(String key, Character character) {
    try {
      // Просто сохраняем персонажа - Hive сам разберется с индексами
      character.save(); // Если Character extends HiveObject
      // Или:
      // box.put(character.key, character); // Если используете ключи
      // Или просто добавляем:
      // box.add(character);
      
      //print('Персонаж "${character.name}" сохранен');
    } catch (e) {
      //print('Ошибка сохранения персонажа: $e');
      // Можно попробовать альтернативный способ сохранения
      _fallbackSave(character);
    }
  }
  
  void _fallbackSave(Character character) {
    try {
      // Альтернативный способ - всегда добавляем нового
      box.add(character);
      //print('Персонаж "${character.name}" сохранен через fallback');
    } catch (e) {
      //print('Критическая ошибка сохранения: $e');
      throw Exception('Не удалось сохранить персонажа');
    }
  }


  // Получить всех персонажей
  List<Character> getAllCharacters() {
    return box.values.toList();
  }
}