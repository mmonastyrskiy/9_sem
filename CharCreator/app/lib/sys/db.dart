
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../character.dart';

class HiveService {
  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    
    // Регистрируем все адаптеры
    Hive.registerAdapter(CharacterViewAdapter());
    // Добавьте другие адаптеры по мере создания
    
    await Hive.openBox<CharacterView>('characters');
  }
}
// В CharacterRepository добавьте:
class CharacterRepository {
  final Box<CharacterView> box;

  CharacterRepository(this.box);

  // Добавить нового персонажа
  void addCharacter(CharacterView character) {
    box.add(character); // Это добавит нового персонажа в конец списка
    //print("Персонаж добавлен ${character.name}");
  }

  // Обновить существующего персонажа
void safeUpdate(String key, CharacterView character) {
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
  
  void _fallbackSave(CharacterView character) {
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
  List<CharacterView> getAllCharacters() {
    return box.values.toList();
  }
}