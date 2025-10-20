
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