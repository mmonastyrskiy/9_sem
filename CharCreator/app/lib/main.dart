// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'character.dart';
import 'sys/db.dart';
//import 'package:hive/hive.dart';
import 'sys/config.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CharacterSheetScreen(),
    );
  }
}

class ImageEditDialog extends StatefulWidget {
  final Character character;
  final Function(String) onImageChanged;

  const ImageEditDialog({
    super.key,
    required this.character,
    required this.onImageChanged,
  });

  @override
  ImageEditDialogState createState() => ImageEditDialogState();
}

class ImageEditDialogState extends State<ImageEditDialog> {
  late TextEditingController _urlController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.character.PortraitURL);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _saveImage() {
    if (_formKey.currentState!.validate()) {
      String newUrl = _urlController.text.trim();
      widget.onImageChanged(newUrl);
      Navigator.of(context).pop();
    }
  }

  void _clearImage() {
    setState(() {
      _urlController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.blue, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a1a), Color(0xFF003366)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.image, color: Colors.blue, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Изображение персонажа',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Введите URL изображения или оставьте пустым для стандартного',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              
              // Предпросмотр изображения
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.blue, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _buildImagePreview(_urlController.text),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _urlController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'URL изображения',
                        labelStyle: const TextStyle(color: Colors.blue),
                        hintText: 'https://example.com/image.jpg',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        prefixIcon: const Icon(Icons.link, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: _clearImage,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {}); // Обновляем предпросмотр
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (!Uri.tryParse(value)!.hasScheme) {
                            return 'Введите корректный URL';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Оставьте поле пустым для стандартного изображения',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Отмена'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _saveImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(String url) {
    if (url.isEmpty) {
      return Container(
        color: const Color(0xFF2d1b00),
        child: const Icon(
          Icons.person,
          color: Colors.blue,
          size: 50,
        ),
      );
    } else {
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFF2d1b00),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF2d1b00),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 40),
                SizedBox(height: 8),
                Text(
                  'Ошибка',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}




class CharacterSheetScreen extends StatefulWidget {
  const CharacterSheetScreen({super.key});
  @override
  CharacterSheetScreenState createState() => CharacterSheetScreenState();
}

class CharacterSheetScreenState extends State<CharacterSheetScreen> {
  late Character c;
  late CharacterRepository characterRepository;

  @override
  void initState() {
    super.initState();
    c = Character(context);
  //final characterBox = Hive.openBox<Character>('characters');
  // characterRepository = CharacterRepository(characterBox as Box<Character>);
  // FIXME: Hive does not build
  }

  Color _getAbilityColor(int value) {
    if (value >= 16) return Colors.blue;
    if (value >= 12) return Colors.green;
    if (value >= 8) return Colors.orange;
    return Colors.red;
  }

  // Метод для обновления персонажа после редактирования
  void _updateCharacter(String name, String characterClass, String race, String background) {
    setState(() {
      c.name = name;
      c.SetName(name);
      c.HandleClassChange(characterClass);
      c.HandleRaceChange(race);
      //c.HandleBgChange(background);
      if(FLAG_ENABLE_HIVE){
      characterRepository.safeUpdate(c.name,c);
      }
    });
  }
  void _updateCharacterImage(String imageUrl) {
  setState(() {
    c.setImageUrl(imageUrl); // Используем новый метод setImageUrl
    
    // Сохраняем изменения в Hive если включено
    if(FLAG_ENABLE_HIVE){
      characterRepository.safeUpdate(c.name, c);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "🏰"),
              Tab(text: "🎒"),
              Tab(text: "🔥"),
              Tab(text: "🧑")
            ],
          ),
          title: GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.psychology, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(
                  c.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => EditCharacterDialog(
                  character: c,
                  onCharacterChanged: (newName, newClass, newRace, newBackground) {
                    _updateCharacter(newName, newClass, newRace, newBackground);
                  },
                ),
              );
            },
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Стилизованная вкладка Домой
            _buildStyledHomeTab(c),
            
            // Остальные вкладки без изменений
            _buildStyledInventoryTab(),
            _buildStyledSpellsTab(),
            _buildStyledAboutTab(),
          ],
        ),
      ),
    );
  }


Widget _buildStyledSpellsTab() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1a1a1a),
          Color(0xFF2d1b00),
        ],
      ),
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Магическая иконка
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF2d1b00),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.purple, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: Colors.purple,
            size: 60,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Заголовок
        const Text(
          '🔥 Заклинания',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
            fontFamily: 'Fantasy',
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Описание
        const Text(
          'Магическая система готовится к запуску',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Карточка с информацией о заклинаниях
        Card(
          color: const Color(0xFF2d1b00),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.purple, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Книга заклинаний',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Скоро здесь появится:\n• Список известных заклинаний\n• Ячейки заклинаний\n• Описания и компоненты\n• Боевое применение',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Кнопка "Изучить заклинания"
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Добавить функционал
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.purple,
            side: const BorderSide(color: Colors.purple),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.menu_book),
          label: const Text(
            'Изучить заклинания',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}



Widget _buildStyledInventoryTab() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1a1a1a),
          Color(0xFF2d1b00),
        ],
      ),
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Иконка инвентаря
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF2d1b00),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.amber, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.backpack,
            color: Colors.amber,
            size: 60,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Заголовок
        const Text(
          '🎒 Инвентарь',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
            fontFamily: 'Fantasy',
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Описание
        const Text(
          'Система инвентаря находится в разработке',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Карточка с информацией
        Card(
          color: const Color(0xFF2d1b00),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.amber, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.construction,
                  color: Colors.amber,
                  size: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'В разработке',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Скоро здесь появится:\n• Управление предметами\n• Экипировка\n• Вес и ёмкость\n• Быстрый доступ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Прогресс бар
        Container(
          width: 200,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.amber, Colors.orange],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          '45% завершено',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    ),
  );
}


Widget _buildStyledAboutTab() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1a1a1a),
          Color(0xFF2d1b00),
        ],
      ),
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Кликабельная иконка персонажа
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ImageEditDialog(
                character: c,
                onImageChanged: (newUrl) {
                  setState(() {
                    c.setImageUrl(newUrl);
                    _updateCharacterImage(newUrl);
                    if (FLAG_ENABLE_HIVE) {
                      characterRepository.safeUpdate(c.name, c);
                    }
                  });
                },
              ),
            );
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.blue, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: _buildCharacterImage(c.PortraitURL),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Подсказка под изображением
        Text(
          'Нажмите на изображение для изменения',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Заголовок
        const Text(
          '🧑 О персонаже',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: 'Fantasy',
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Описание
        const Text(
          'Детальная информация о вашем герое',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Карточка с информацией
        Card(
          color: const Color(0xFF2d1b00),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.blue, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.history_edu,
                  color: Colors.blue,
                  size: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Биография и история',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Скоро здесь появится:\n• Подробная биография\n• История приключений\n• Черты характера\n• Идеалы, узы и недостатки',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Кнопка редактирования
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditCharacterDialog(
                character: c,
                onCharacterChanged: (newName, newClass, newRace, newBackground) {
                  _updateCharacter(newName, newClass, newRace, newBackground);
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.edit_note),
          label: const Text(
            'Редактировать биографию',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

// Вспомогательный метод для отображения изображения
Widget _buildCharacterImage(String imageUrl) {
  if (imageUrl.isEmpty) {
    // Локальное изображение по умолчанию
    return Container(
      color: const Color(0xFF2d1b00),
      child: const Icon(
        Icons.person,
        color: Colors.blue,
        size: 60,
      ),
    );
  } else {
    // Загрузка изображения по URL
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: const Color(0xFF2d1b00),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.blue,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // В случае ошибки загрузки показываем стандартное изображение
        return Container(
          color: const Color(0xFF2d1b00),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 40),
              SizedBox(height: 8),
              Text(
                'Ошибка\nзагрузки',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}


  Widget _buildStyledHomeTab(Character c) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1a1a1a),
            Color(0xFF2d1b00),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Карточка персонажа в стиле D&D
          Card(
            color: const Color(0xFF2d1b00),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.amber, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(Icons.person, color: Colors.black, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${c.currentclass()} • ${c.currentRace()} • Уровень ${c.lvl} ',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.amber),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditCharacterDialog(
                          character: c,
                          onCharacterChanged: (newName, newClass, newRace, newBackground) {
                            _updateCharacter(newName, newClass, newRace, newBackground);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Заголовок характеристик как отдельный виджет
          CharacteristicsHeader(
            onRerollAll: () {
              setState(() {
                c.Reroll();
                if (FLAG_ENABLE_HIVE){
                characterRepository.safeUpdate(c.name, c); // TODO: This is a hack if this shit is not working
                }
              });
            },
          ),

          const SizedBox(height: 16),

          // Список характеристик в стиле D&D (оставляем как было)
          Expanded(
            child: ListView(
              children: [
                // Основные характеристики (как было)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    String AbilityName = c.AbilityNames().elementAt(index);
                    int AbilityValue = c.getbasicstats().values.toList().elementAt(index).value;
                    int AbilityModifier = c.getbasicstats().values.toList().elementAt(index).mod;
                    int HasSavingThrow = c.getbasicstats().values.toList().elementAt(index).savingthrow;
                    int savingthrowvalue = 0;
                    HasSavingThrow >= 0 ? savingthrowvalue = AbilityModifier + c.ProfBonus: savingthrowvalue = AbilityModifier;
                    
                    
                    return Card(
                      color: const Color(0xFF2d1b00),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.amber, width: 1),
                      ),
                      child: GestureDetector(
                        onDoubleTap: () => setState(() {
                          c.Reroll();
                        }),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getAbilityColor(AbilityValue),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.amber, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                AbilityValue.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  AbilityName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Модификатор
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AbilityModifier >= 0 
                                      ? const Color(0xFF2d522d) 
                                      : const Color(0xFF522d2d),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AbilityModifier >= 0 
                                        ? Colors.green 
                                        : Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  AbilityModifier >= 0 ? '+$AbilityModifier' : '$AbilityModifier',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AbilityModifier >= 0 ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Спасбросок
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF522d2d),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: HasSavingThrow > 0 ? Colors.amber : const Color(0xFF522d2d),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  savingthrowvalue.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.casino,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Новый ExpansionTile для навыков
                Card(
                  color: const Color(0xFF2d1b00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.amber, width: 1),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(Icons.school, color: Colors.amber),
                    title: const Text(
                      'Навыки персонажа',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: const Text(
                      'Нажмите для просмотра всех навыков',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    collapsedIconColor: Colors.amber,
                    iconColor: Colors.amber,
                    backgroundColor: const Color(0xFF2d1b00),
                    collapsedBackgroundColor: const Color(0xFF2d1b00),
                    children: [
                      // Список навыков
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildSkillItem("Акробатика", c.Skill2modstr(c.Acrobatics!), c.Acrobatics!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Атлетика", c.Skill2modstr(c.Athletics!), c.Athletics!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Внимание", c.Skill2modstr(c.Perception!), c.Perception!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Выживание", c.Skill2modstr(c.Survival!), c.Survival!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Запугивание", c.Skill2modstr(c.Intimidation!), c.Intimidation!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Магия", c.Skill2modstr(c.Arcana!), c.Arcana!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Медицина", c.Skill2modstr(c.Medicine!), c.Medicine!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Обман", c.Skill2modstr(c.Deception!), c.Deception!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Природа", c.Skill2modstr(c.Nature!), c.Nature!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Проницательность", c.Skill2modstr(c.Insight!), c.Insight!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Расследование", c.Skill2modstr(c.Investigation!), c.Investigation!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Религия", c.Skill2modstr(c.Religion!), c.Religion!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Скрытность", c.Skill2modstr(c.Stealth!), c.Stealth!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("Убеждение", c.Skill2modstr(c.Persuasion!), c.Persuasion!.hasprofbounus > 0 ? true: false),
                            _buildSkillItem("История", c.Skill2modstr(c.History!), c.History!.hasprofbounus > 0 ? true: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),  
          ),

          // Подсказка
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.amber, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Долгое нажатие на имя для редактирования • Двойной тап на характеристику для переброса',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Вспомогательный метод для создания элементов навыков
  Widget _buildSkillItem(String skillName, String bonus, bool isProficient) {
    return Card(
      color: const Color(0xFF1a1a1a),
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.amber.withValues(alpha: 0.5), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isProficient ? Colors.amber : Colors.grey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Icon(
            isProficient ? Icons.check : Icons.circle_outlined,
            color: isProficient ? Colors.black : Colors.white,
            size: 16,
          ),
        ),
        title: Text(
          skillName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2d522d),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: Text(
            bonus,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

// Заголовок характеристик как отдельный Stateful Widget
class CharacteristicsHeader extends StatefulWidget {
  final VoidCallback onRerollAll;

  const CharacteristicsHeader({
    super.key,
    required this.onRerollAll,
  });

  @override
  CharacteristicsHeaderState createState() => CharacteristicsHeaderState();
}

class CharacteristicsHeaderState extends State<CharacteristicsHeader> {
  bool _isHighlighted = false;

  void _handleDoubleTap() {
    setState(() {
      _isHighlighted = true;
    });

    widget.onRerollAll();

    // Сбрасываем подсветку через короткое время
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isHighlighted = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isHighlighted ? Colors.amber.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: _isHighlighted 
              ? Border.all(color: Colors.amber, width: 2)
              : null,
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_stories, color: Colors.amber, size: 24),
            const SizedBox(width: 8),
            const Text(
              'Характеристики персонажа',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const Spacer(),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isHighlighted ? 0.7 : 1.0,
              child: const Text(
                'Двойной тап для\nпереброса всех',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Обновленный диалог редактирования персонажа
class EditCharacterDialog extends StatefulWidget {
  final Character character;
  final Function(String, String, String, String) onCharacterChanged;

  const EditCharacterDialog({
    super.key,
    required this.character,
    required this.onCharacterChanged,
  });

  @override
  EditCharacterDialogState createState() => EditCharacterDialogState();
}

class EditCharacterDialogState extends State<EditCharacterDialog> {
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  // Списки для выбора класса, расы и предыстории
  final List<String> classes = [
    'Варвар', 'Бард', 'Жрец', 'Друид', 'Воин', 'Паладин', 
    'Следопыт', 'Плут', 'Чародей', 'Колдун', 'Волшебник', 'Монах',"Тест2"
  ];

  final List<String> races = [
    "Лесной гном", "Скальный гном", "Горный дварф", "Холмовой дварф", "Драконорожденный",
    "Полуорк", "Коренастый полурослик", "Легконогий полурослик", "Полуэльф",
    "Высший эльф", "Лесной Эльф", "Тифлинг", "Человек","Тест1"
  ];

  final List<String> backgrounds = [
    'артист','беспризорник','гильдейский ремесленник','моряк','мудрец','народный герой',
    'отшельник','пират','преступник','прислужник','солдат','чужеземец','шарлатан',"Тест3"
  ];

  String? selectedClass;
  String? selectedRace;
  String? selectedBackground;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.character.name);
    
    // Получаем текущие значения через методы класса Character
    final currentClass = widget.character.currentclass();
    final currentRace = widget.character.currentRace();
    final currentBackground = widget.character.currentbg();
    
    // Устанавливаем значения, проверяя их наличие в списках
    selectedClass = classes.contains(currentClass) ? currentClass : classes.first;
    selectedRace = races.contains(currentRace) ? currentRace : races.first;
    selectedBackground = backgrounds.contains(currentBackground) ? currentBackground : backgrounds.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      String newName = _nameController.text.trim();
      
      // Вызываем колбэк с новыми данными
      widget.onCharacterChanged(
        newName, 
        selectedClass!, 
        selectedRace!, 
        selectedBackground!
      );
      
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.amber, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2d1b00), Color(0xFF1a1a1a)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_stories, color: Colors.amber, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Редактирование персонажа',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Измените основные параметры вашего персонажа',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Поле ввода имени
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Имя персонажа',
                        labelStyle: const TextStyle(color: Colors.amber),
                        hintText: 'Например: Арагорн, Гэндальф...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        prefixIcon: const Icon(Icons.person, color: Colors.amber),
                      ),
                      maxLength: 30,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Имя не может быть пустым';
                        }
                        if (value.trim().length < 2) {
                          return 'Слишком короткое имя';
                        }
                        if (value.trim().length > 25) {
                          return 'Слишком длинное имя';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_nameController.text.trim().length}/25 символов',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Выбор расы
                    DropdownButtonFormField<String>(
                      initialValue: selectedRace,
                      decoration: InputDecoration(
                        labelText: 'Раса персонажа',
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        prefixIcon: const Icon(Icons.people, color: Colors.amber),
                      ),
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white),
                      items: races.map((String raceItem) {
                        return DropdownMenuItem<String>(
                          value: raceItem,
                          child: Text(
                            raceItem,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedRace = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Выберите расу';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Выбор класса
                    DropdownButtonFormField<String>(
                      initialValue: selectedClass,
                      decoration: InputDecoration(
                        labelText: 'Класс персонажа',
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        prefixIcon: const Icon(Icons.security, color: Colors.amber),
                      ),
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white),
                      items: classes.map((String classItem) {
                        return DropdownMenuItem<String>(
                          value: classItem,
                          child: Text(
                            classItem,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedClass = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Выберите класс';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Выбор предыстории
                    DropdownButtonFormField<String>(
                      initialValue: selectedBackground,
                      decoration: InputDecoration(
                        labelText: 'Предыстория',
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.amber, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        prefixIcon: const Icon(Icons.history, color: Colors.amber),
                      ),
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white),
                      items: backgrounds.map((String backgroundItem) {
                        return DropdownMenuItem<String>(
                          value: backgroundItem,
                          child: Text(
                            backgroundItem,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedBackground = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Выберите предысторию';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.amber),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Отмена'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}