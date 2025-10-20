
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
class CharacterRepository {
  final Box<Character> _characterBox;
  
  CharacterRepository(this._characterBox);
  
  // Обновление существующей записи
  Future<void> updateCharacter(String key, Character updatedCharacter) async {
    if (_characterBox.containsKey(key)) {
      await _characterBox.put(key, updatedCharacter);
    } else {
      throw Exception('Персонаж с ключом $key не найден');
    }
  }
  
  // Обновление с проверкой существования
  Future<bool> safeUpdate(String key, Character updatedCharacter) async {
    if (_characterBox.containsKey(key)) {
      await _characterBox.put(key, updatedCharacter);
      return true;
    }
    return false;
  }
  
  // Обновление или создание, если не существует
  Future<void> upsertCharacter(String key, Character character) async {
    await _characterBox.put(key, character);
  }
}