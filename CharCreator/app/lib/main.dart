// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'character.dart';
import 'sys/db.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'etc/pinterest.dart';
import 'items/armor.dart';
import 'items/weapon.dart';
import 'package:provider/provider.dart';
import 'ui/modal_service.dart';
//import 'inventory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(CharacterViewAdapter());
    //Hive.registerAdapter(InventoryAdapter());
    
    // Try to open box with error handling
    try {
      await Hive.openBox<CharacterView>('characters');
    } catch (e) {
      print('Error opening box, deleting corrupted data: $e');
      //await Hive.deleteBoxFromDisk('characters');
      await Hive.openBox<CharacterView>('characters');
    }
    
    runApp(const MyApp());
  } catch (e) {
    print('Fatal error initializing app: $e');
    // Handle error gracefully
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app: $e'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

   @override
     State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final ModalService modalService = ModalService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: modalService),
      ],
      child: Builder(
        builder: (context) {
          // Устанавливаем контекст для ModalService
          WidgetsBinding.instance.addPostFrameCallback((_) {
            modalService.setContext(context);
          });

          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                theme: ThemeData.light(useMaterial3: true).copyWith(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                ),
                darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
                ),
                themeMode: themeProvider.themeMode,
                home: CharacterSheetScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

// Провайдер для управления темой
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}

class CharacterSheetScreen extends StatefulWidget {
  const CharacterSheetScreen({super.key});
  @override
  CharacterSheetScreenState createState() => CharacterSheetScreenState();
}

class CharacterSheetScreenState extends State<CharacterSheetScreen> with SingleTickerProviderStateMixin {
  late Character c;
  late CharacterRepository characterRepository;
  late TabController _tabController;
  late Box<CharacterView> charactersBox;
  bool _characterLoaded = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    charactersBox = Hive.box<CharacterView>('characters');
    characterRepository = CharacterRepository(charactersBox);
    _tabController = TabController(length: 4, vsync: this);
    
    // Initialize character here
    _initializeCharacter();
  }

  void _initializeCharacter() {
    final modalService = Provider.of<ModalService>(context, listen: false);
    
    if (charactersBox.isNotEmpty ) {
      // Create character first, then load data
      c = Character.withContext(modalService);
      //c.FromView(charactersBox.getAt(0)!, modalService);
    } else {
      // Create new character
      c = Character.withContext(modalService);
      
      // Save without showing SnackBar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _saveCharacterSilently();
      });
    }
    
    _characterLoaded = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Only initialize if not already loaded
    if (!_characterLoaded && mounted) {
      _initializeCharacter();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    Hive.close();
    super.dispose();
  }

  // Метод для сохранения без UI уведомлений
  void _saveCharacterSilently() {
    try {
      characterRepository.safeUpdate(c.name, c.ToView());
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка сохранения: $e');
      }
    }
  }

  // Основной метод сохранения с проверками
void _saveCharacter() {
    if (!mounted) return;
    
    try {
      characterRepository.safeUpdate(c.name, c.ToView());
      _showSnackBar(
        'Персонаж "${c.name}" сохранен',
        Colors.green,
      );
    } catch (e) {
      _showSnackBar(
        'Ошибка сохранения: $e',
        Colors.red,
      );
    }
  }

  // Безопасный метод показа SnackBar
    void _showSnackBar(String message, Color backgroundColor) {
    if (!mounted) return;
    
    // Используем GlobalKey вместо context
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }


  // Метод для загрузки персонажа
  void _loadCharacter(int index) {
    print("Load Char");
     final modalService = Provider.of<ModalService>(context, listen: false);
    if (index < charactersBox.length) {
      setState(() {
        c.FromView(charactersBox.getAt(index)!,modalService);
      });
      _showSnackBar(
        'Загружен персонаж "${c.name}"',
        Colors.blue,
      );
    }
  }

  // Метод для создания нового персонажа
// Метод для создания нового персонажа
void _createNewCharacter() {
  // Get ModalService from Provider
  final modalService = Provider.of<ModalService>(context, listen: false);
  
  setState(() {
    // Create new character with ModalService
    c = Character.withContext(modalService);
  });
  _saveCharacter();
}

  // Обновленный метод для двойного тапа с безопасным сохранением
  void _handleDoubleTapReroll() {
    setState(() {
      c.Reroll();
    });
    // Сохраняем без показа SnackBar при перебросе
    _saveCharacterSilently();
  }

  Color _getAbilityColor(int value, bool isDarkMode) {
    if (value >= 16) return isDarkMode ? Colors.blue : Colors.blue.shade700;
    if (value >= 12) return isDarkMode ? Colors.green : Colors.green.shade700;
    if (value >= 8) return isDarkMode ? Colors.orange : Colors.orange.shade700;
    return isDarkMode ? Colors.red : Colors.red.shade700;
  }

  void _updateCharacter(String name, String characterClass, String race, String background) {
    final modalService = Provider.of<ModalService>(context, listen: false);
    setState(() {
      c.name = name;
      c.SetName(name);
      c.HandleClassChange(characterClass);
      c.HandleRaceChange(race);
      c.HandleBgChange(background,modalService);
      _saveCharacter(); // Сохраняем изменения
    });
  }

  void _updateCharacterImage(String imageUrl) {
    setState(() {
      c.setImageUrl(imageUrl);
      _saveCharacter(); // Сохраняем изменения
    });
  }

 void _toggleTheme() {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  themeProvider.setThemeMode(
    themeProvider.themeMode == ThemeMode.dark 
        ? ThemeMode.light 
        : ThemeMode.dark
  );
}
  // Метод для отображения диалога управления персонажами
void _showCharactersManagementDialog() {
  showDialog(
    context: context,
    builder: (context) => Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CharactersManagementDialog(
          charactersBox: charactersBox,
          onCharacterSelected: _loadCharacter,
          onCreateNewCharacter: _createNewCharacter,
          isDarkMode: themeProvider.isDarkMode,
        );
      },
    ),
  );
}


@override
Widget build(BuildContext context) {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      final isDarkMode = themeProvider.isDarkMode;
      
      return MaterialApp(
        theme: ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, 
            brightness: Brightness.dark
          ),
        ),
        themeMode: themeProvider.themeMode,
        home: ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditCharacterDialog(
                      character: c,
                      onCharacterChanged: (newName, newClass, newRace, newBackground) {
                        _updateCharacter(newName, newClass, newRace, newBackground);
                      },
                      isDarkMode: isDarkMode,
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.psychology, 
                      color: isDarkMode ? Colors.amber : Colors.blue.shade700, 
                      size: 20
                    ),
                    const SizedBox(width: 8),
                    Text(
                      c.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: isDarkMode ? Colors.green : Colors.green.shade700,
                  ),
                  onPressed: _saveCharacter,
                  tooltip: 'Сохранить персонажа',
                ),
                IconButton(
                  icon: Icon(
                    Icons.people,
                    color: isDarkMode ? Colors.blue : Colors.blue.shade700,
                  ),
                  onPressed: _showCharactersManagementDialog,
                  tooltip: 'Управление персонажами',
                ),
                IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: isDarkMode ? Colors.amber : Colors.grey.shade700,
                  ),
                  onPressed: _toggleTheme,
                  tooltip: isDarkMode ? 'Светлая тема' : 'Темная тема',
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "🏰"),
                  Tab(text: "🎒"),
                  Tab(text: "🔥"),
                  Tab(text: "🧑")
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildStyledHomeTab(c, isDarkMode),
                _buildStyledInventoryTab(isDarkMode),
                _buildStyledSpellsTab(isDarkMode),
                _buildStyledAboutTab(isDarkMode),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _saveCharacter,
              backgroundColor: isDarkMode ? Colors.green : Colors.green.shade700,
              tooltip: 'Быстрое сохранение',
              child: const Icon(Icons.save, color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}

  Widget _buildStyledHomeTab(Character c, bool isDarkMode) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode 
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF2d1b00),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: cardColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: accentColor, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: isDarkMode ? Colors.black : Colors.white, width: 2),
                    ),
                    child: Icon(Icons.person, color: isDarkMode ? Colors.black : Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${c.currentclass()} • ${c.currentRace()} • Уровень ${c.lvl} ',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: accentColor),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditCharacterDialog(
                          character: c,
                          onCharacterChanged: (newName, newClass, newRace, newBackground) {
                            _updateCharacter(newName, newClass, newRace, newBackground);
                          },
                          isDarkMode: isDarkMode,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
CharacteristicsHeader(
  onRerollAll: () {
    setState(() {
      c.Reroll();
      _saveCharacterSilently();
    });
  },
),

          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: [
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
                      color: cardColor,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: accentColor, width: 1),
                      ),
                      child: GestureDetector(
                        onDoubleTap: _handleDoubleTapReroll,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getAbilityColor(AbilityValue, isDarkMode),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: accentColor, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                AbilityValue.toString(),
                                style: TextStyle(
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AbilityModifier >= 0 
                                      ? (isDarkMode ? const Color(0xFF2d522d) : Colors.green.shade100)
                                      : (isDarkMode ? const Color(0xFF522d2d) : Colors.red.shade100),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AbilityModifier >= 0 
                                        ? (isDarkMode ? Colors.green : Colors.green.shade700)
                                        : (isDarkMode ? Colors.red : Colors.red.shade700),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  AbilityModifier >= 0 ? '+$AbilityModifier' : '$AbilityModifier',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AbilityModifier >= 0 
                                        ? (isDarkMode ? Colors.green : Colors.green.shade800)
                                        : (isDarkMode ? Colors.red : Colors.red.shade800),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? const Color(0xFF522d2d) : Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: HasSavingThrow > 0 ? accentColor : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  savingthrowvalue.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.casino,
                            color: accentColor,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Card(
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: accentColor, width: 1),
                  ),
                  child: ExpansionTile(
                    leading: Icon(Icons.school, color: accentColor),
                    title: Text(
                      'Навыки персонажа',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Нажмите для просмотра всех навыков',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    collapsedIconColor: accentColor,
                    iconColor: accentColor,
                    backgroundColor: cardColor,
                    collapsedBackgroundColor: cardColor,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildSkillItem("Акробатика", c.Skill2modstr(c.Acrobatics!), c.Acrobatics!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Атлетика", c.Skill2modstr(c.Athletics!), c.Athletics!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Внимание", c.Skill2modstr(c.Perception!), c.Perception!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Выживание", c.Skill2modstr(c.Survival!), c.Survival!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Запугивание", c.Skill2modstr(c.Intimidation!), c.Intimidation!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Магия", c.Skill2modstr(c.Arcana!), c.Arcana!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Медицина", c.Skill2modstr(c.Medicine!), c.Medicine!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Обман", c.Skill2modstr(c.Deception!), c.Deception!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Природа", c.Skill2modstr(c.Nature!), c.Nature!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Проницательность", c.Skill2modstr(c.Insight!), c.Insight!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Расследование", c.Skill2modstr(c.Investigation!), c.Investigation!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Религия", c.Skill2modstr(c.Religion!), c.Religion!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Скрытность", c.Skill2modstr(c.Stealth!), c.Stealth!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("Убеждение", c.Skill2modstr(c.Persuasion!), c.Persuasion!.hasprofbounus > 0 ? true: false, isDarkMode),
                            _buildSkillItem("История", c.Skill2modstr(c.History!), c.History!.hasprofbounus > 0 ? true: false, isDarkMode),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),  
          ),

          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accentColor.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: accentColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Долгое нажатие на имя для редактирования • Двойной тап на характеристику для переброса',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
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

  Widget _buildSkillItem(String skillName, String bonus, bool isProficient, bool isDarkMode) {
    final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;
    
    return Card(
      color: isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: accentColor.withValues(alpha: 0.5), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isProficient ? accentColor : Colors.grey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDarkMode ? Colors.white : Colors.black, width: 1),
          ),
          child: Icon(
            isProficient ? Icons.check : Icons.circle_outlined,
            color: isProficient ? (isDarkMode ? Colors.black : Colors.white) : (isDarkMode ? Colors.white : Colors.black),
            size: 16,
          ),
        ),
        title: Text(
          skillName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2d522d) : Colors.green.shade100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isDarkMode ? Colors.green : Colors.green.shade700, width: 1),
          ),
          child: Text(
            bonus,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isDarkMode ? Colors.green : Colors.green.shade800,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyledInventoryTab(bool isDarkMode) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode 
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF2d1b00),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: accentColor, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.backpack, color: accentColor, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          '🎒 Инвентарь',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            fontFamily: 'Fantasy',
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentColor.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCurrencyItem('ЗМ', c.wallet.gold, isDarkMode ? Colors.amber : Colors.orange, isDarkMode),
                          _buildCurrencyItem('СМ', c.wallet.silver, Colors.grey, isDarkMode),
                          _buildCurrencyItem('ММ', c.wallet.copper, isDarkMode ? Colors.orange : Colors.brown, isDarkMode),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Загрузка инвентаря',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                            Text(
                              '${c.inventory.totalWeight.toStringAsFixed(1)} / ${c.inventory.maxWeight} фунтов',
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: c.inventory.weightPercentage,
                          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            c.inventory.isOverloaded ? Colors.red : accentColor,
                          ),
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c.inventory.isOverloaded 
                              ? 'ПЕРЕГРУЗКА! Скорость уменьшена'
                              : '${(c.inventory.weightPercentage * 100).toStringAsFixed(0)}% загружено',
                          style: TextStyle(
                            fontSize: 12,
                            color: c.inventory.isOverloaded ? Colors.red : Colors.grey.shade600,
                            fontWeight: c.inventory.isOverloaded ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.green, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Экипировано',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (c.inventory.equippedWeapon != null)
                          _buildEquippedItem(
                            'Оружие',
                            _getWeaponName(c.inventory.equippedWeapon!.type),
                            Colors.blue,
                            isDarkMode,
                          ),
                        if (c.inventory.equippedArmor != null)
                          _buildEquippedItem(
                            'Броня',
                            _getArmorName(c.inventory.equippedArmor!.type),
                            Colors.green,
                            isDarkMode,
                          ),
                        if (c.inventory.equippedShield != null)
                          _buildEquippedItem(
                            'Щит',
                            _getArmorName(c.inventory.equippedShield!.type),
                            Colors.orange,
                            isDarkMode,
                          ),
                        if (c.inventory.equippedWeapon == null && 
                            c.inventory.equippedArmor == null && 
                            c.inventory.equippedShield == null)
                          Text(
                            'Нет экипированных предметов',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: _buildInventoryTabs(isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTabs(bool isDarkMode) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2d1b00) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? Colors.amber : Colors.blue.shade700, 
                width: 1
              ),
            ),
            child: TabBar(
              labelColor: isDarkMode ? Colors.black : Colors.white,
              unselectedLabelColor: isDarkMode ? Colors.amber : Colors.blue.shade700,
              indicator: BoxDecoration(
                color: isDarkMode ? Colors.amber : Colors.blue.shade700,
                borderRadius: BorderRadius.circular(6),
              ),
              tabs: const [
                Tab(text: 'Оружие'),
                Tab(text: 'Броня'),
                Tab(text: 'Прочее'),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          Expanded(
            child: TabBarView(
              children: [
                _buildWeaponsTab(isDarkMode),
                _buildArmorTab(isDarkMode),
                _buildMiscItemsTab(isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponsTab(bool isDarkMode) {
    final accentColor = isDarkMode ? Colors.blue : Colors.blue.shade700;
    
    return c.inventory.weapons.isEmpty
        ? _buildEmptyState('Оружие', 'Нет оружия в инвентаре', Icons.psychology, isDarkMode)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: c.inventory.weapons.length,
            itemBuilder: (context, index) {
              final weapon = c.inventory.weapons.elementAt(index);
              final isEquipped = c.inventory.equippedWeapon == weapon;
              
              return _buildInventoryItem(
                name: _getWeaponName(weapon.type),
                type: 'Оружие',
                weight: _getWeaponWeight(weapon.type),
                isEquipped: isEquipped,
                onEquip: () => setState(() {
                  c.inventory.equipWeapon(weapon);
                  _saveCharacterSilently();
                }),
                onUnequip: () => setState(() {
                  c.inventory.unequipWeapon();
                  _saveCharacterSilently();
                }),
                color: accentColor,
                isDarkMode: isDarkMode,
              );
            },
          );
  }

  Widget _buildArmorTab(bool isDarkMode) {
    final accentColor = isDarkMode ? Colors.green : Colors.green.shade700;
    final shieldColor = isDarkMode ? Colors.orange : Colors.orange.shade700;
    
    return c.inventory.armors.isEmpty
        ? _buildEmptyState('Броня', 'Нет брони в инвентаре', Icons.security, isDarkMode)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: c.inventory.armors.length,
            itemBuilder: (context, index) {
              final armor = c.inventory.armors.elementAt(index);
              final isEquipped = c.inventory.equippedArmor == armor || 
                                c.inventory.equippedShield == armor;
              final isShield = armor.type == ArmorType.Shield;
              
              return _buildInventoryItem(
                name: _getArmorName(armor.type),
                type: isShield ? 'Щит' : 'Броня',
                weight: _getArmorWeight(armor.type),
                isEquipped: isEquipped,
                onEquip: () => setState(() {
                  if (isShield) {
                    c.inventory.equipArmor(armor);
                  } else {
                    c.inventory.equipArmor(armor);
                  }
                  _saveCharacterSilently();
                }),
                onUnequip: () => setState(() {
                  if (isShield) {
                    c.inventory.unequipShield();
                  } else {
                    c.inventory.unequipArmor();
                  }
                  _saveCharacterSilently();
                }),
                color: isShield ? shieldColor : accentColor,
                isDarkMode: isDarkMode,
              );
            },
          );
  }

  Widget _buildMiscItemsTab(bool isDarkMode) {
    final miscColor = isDarkMode ? Colors.purple : Colors.purple.shade700;
    
    return c.inventory.miscItems.isEmpty
        ? _buildEmptyState('Предметы', 'Нет предметов в инвентаре', Icons.backpack, isDarkMode)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: c.inventory.miscItems.length,
            itemBuilder: (context, index) {
              final item = c.inventory.miscItems.elementAt(index);
              
              return _buildMiscInventoryItem(
                name: item.name,
                quantity: item.qty,
                weight: item.weight,
                color: miscColor,
                isDarkMode: isDarkMode,
              );
            },
          );
  }

  Widget _buildEmptyState(String title, String message, IconData icon, bool isDarkMode) {
    final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: accentColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: textColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyItem(String name, int amount, Color color, bool isDarkMode) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildEquippedItem(String type, String name, Color color, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDarkMode ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem({
    required String name,
    required String type,
    required double weight,
    required bool isEquipped,
    required VoidCallback onEquip,
    required VoidCallback onUnequip,
    required Color color,
    required bool isDarkMode,
  }) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    
    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isEquipped ? Colors.green : color,
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(
            _getItemIcon(type),
            color: color,
            size: 20,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isEquipped ? Colors.green : textColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
            Text(
              'Вес: ${weight.toStringAsFixed(1)} фунтов',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        trailing: isEquipped
            ? OutlinedButton.icon(
                onPressed: onUnequip,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                icon: const Icon(Icons.remove_circle, size: 16),
                label: const Text('Снять'),
              )
            : ElevatedButton.icon(
                onPressed: onEquip,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add_circle, size: 16),
                label: const Text('Надеть'),
              ),
      ),
    );
  }

  Widget _buildMiscInventoryItem({
    required String name,
    required int quantity,
    required double weight,
    required Color color,
    required bool isDarkMode,
  }) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    
    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
          ),
          child: const Icon(
            Icons.inventory_2,
            color: Colors.purple,
            size: 20,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Количество: $quantity',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'Вес: ${(weight * quantity).toStringAsFixed(1)} фунтов',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: Text(
            'x$quantity',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyledSpellsTab(bool isDarkMode) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final accentColor = isDarkMode ? Colors.purple : Colors.purple.shade700;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode 
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF2d1b00),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: accentColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome,
              color: accentColor,
              size: 60,
            ),
          ),
          
          const SizedBox(height: 32),
          
          Text(
            '🔥 Заклинания',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: accentColor,
              fontFamily: 'Fantasy',
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Магическая система готовится к запуску',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 24),
          
          Card(
            color: cardColor,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: accentColor, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Книга заклинаний',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Скоро здесь появится:\n• Список известных заклинаний\n• Ячейки заклинаний\n• Описания и компоненты\n• Боевое применение',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledAboutTab(bool isDarkMode) {
    final cardColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final accentColor = isDarkMode ? Colors.blue : Colors.blue.shade700;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode 
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF2d1b00),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    });
                  },
                  isDarkMode: isDarkMode,
                ),
              );
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: accentColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipOval(
                child: _buildCharacterImage(c.PortraitURL, isDarkMode),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Нажмите на изображение для изменения',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 32),
          
          Text(
            '🧑 О персонаже',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: accentColor,
              fontFamily: 'Fantasy',
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Детальная информация о вашем герое',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 24),
          
          Card(
            color: cardColor,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: accentColor, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.history_edu,
                    color: accentColor,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Биография и история',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Скоро здесь появится:\n• Подробная биография\n• История приключений\n• Черты характера\n• Идеалы, узы и недостатки',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Вспомогательные методы для получения названий и весов
  String _getWeaponName(WeaponType? type) {
    switch (type) {
      case WeaponType.Dagger:
        return "Кинжал";
      case WeaponType.ShortSword:
        return "Короткий меч";
      case WeaponType.LongSword:
        return "Длинный меч";
      case WeaponType.Greatsword:
        return "Двуручный меч";
      case WeaponType.ShortBow:
        return "Короткий лук";
      case WeaponType.LongBow:
        return "Длинный лук";
      case WeaponType.LightCrossBow:
        return "Арбалет легкий";
      case WeaponType.HeavyCrossBow:
        return "Арбалет тяжелый";
      case WeaponType.CombatStaff:
        return "Боевой посох";
      case WeaponType.Spear:
        return "Копье";
      default:
        return "Оружие";
    }
  }

  String _getArmorName(ArmorType? type) {
    switch (type) {
      case ArmorType.LeatherArmor:
        return "Кожаный доспех";
      case ArmorType.ChainShirt:
        return "Кольчуга";
      case ArmorType.ScaleMailArmor:
        return "Чешуйчатый доспех";
      case ArmorType.Breastplate:
        return "Кираса";
      case ArmorType.HalfPlateArmor:
        return "Полулаты";
      case ArmorType.RingMailArmor:
        return "Кольчатый доспех";
      case ArmorType.ChainMail:
        return "Кольчужный доспех";
      case ArmorType.SplintArmor:
        return "Пластинчатый доспех";
      case ArmorType.PlateArmor:
        return "Латный доспех";
      case ArmorType.Shield:
        return "Щит";
      default:
        return "Броня";
    }
  }

  double _getWeaponWeight(WeaponType? type) {
    switch (type) {
      case WeaponType.Dagger:
        return 1.0;
      case WeaponType.ShortSword:
        return 2.0;
      case WeaponType.LongSword:
        return 3.0;
      case WeaponType.Greatsword:
        return 6.0;
      case WeaponType.ShortBow:
        return 2.0;
      case WeaponType.LongBow:
        return 2.0;
      case WeaponType.LightCrossBow:
        return 5.0;
      case WeaponType.HeavyCrossBow:
        return 18.0;
      case WeaponType.CombatStaff:
        return 4.0;
      case WeaponType.Spear:
        return 3.0;
      default:
        return 2.0;
    }
  }

  double _getArmorWeight(ArmorType? type) {
    switch (type) {
      case ArmorType.LeatherArmor:
        return 10.0;
      case ArmorType.ChainShirt:
        return 20.0;
      case ArmorType.ScaleMailArmor:
        return 45.0;
      case ArmorType.Breastplate:
        return 20.0;
      case ArmorType.HalfPlateArmor:
        return 40.0;
      case ArmorType.RingMailArmor:
        return 40.0;
      case ArmorType.ChainMail:
        return 55.0;
      case ArmorType.SplintArmor:
        return 60.0;
      case ArmorType.PlateArmor:
        return 65.0;
      case ArmorType.Shield:
        return 6.0;
      default:
        return 10.0;
    }
  }

  IconData _getItemIcon(String type) {
    switch (type) {
      case 'Оружие':
        return Icons.psychology;
      case 'Броня':
        return Icons.security;
      case 'Щит':
        return Icons.shield;
      default:
        return Icons.backpack;
    }
  }

  Widget _buildCharacterImage(String imageUrl, bool isDarkMode) {
    final placeholderColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.grey.shade200;
    
    if (imageUrl.isEmpty) {
      return Container(
        color: placeholderColor,
        child: Icon(
          Icons.person,
          color: isDarkMode ? Colors.blue : Colors.blue.shade700,
          size: 60,
        ),
      );
    } else {
      if (imageUrl.contains("pin.it")) {
        return FutureBuilder<String>(
          future: Pinterest().parse(imageUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: placeholderColor,
                child: CircularProgressIndicator(
                  color: isDarkMode ? Colors.blue : Colors.blue.shade700,
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                color: placeholderColor,
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 60,
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            } else {
              return Container(
                color: placeholderColor,
                child: Icon(
                  Icons.person,
                  color: isDarkMode ? Colors.blue : Colors.blue.shade700,
                  size: 60,
                ),
              );
            }
          },
        );
      } else {
        return Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: placeholderColor,
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 60,
              ),
            );
          },
        );
      }
    }
  }
}

// Диалог для управления персонажами
class CharactersManagementDialog extends StatefulWidget {
  final Box<CharacterView> charactersBox;
  final Function(int) onCharacterSelected;
  final VoidCallback onCreateNewCharacter;
  final bool isDarkMode;

  const CharactersManagementDialog({
    super.key,
    required this.charactersBox,
    required this.onCharacterSelected,
    required this.onCreateNewCharacter,
    required this.isDarkMode,
  });

  @override
  State<CharactersManagementDialog> createState() => _CharactersManagementDialogState();
}

class _CharactersManagementDialogState extends State<CharactersManagementDialog> {
  @override
  Widget build(BuildContext context) {
    final accentColor = widget.isDarkMode ? Colors.amber : Colors.blue.shade700;

    return Dialog(
      backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Text(
              'Управление персонажами (${widget.charactersBox.length})',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Кнопка обновления
            ElevatedButton.icon(
              onPressed: () {
                setState(() {}); // Принудительно обновляем состояние
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Обновить список'),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: widget.charactersBox.isEmpty
                  ? _buildEmptyState()
                  : _buildCharactersList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                widget.onCreateNewCharacter();
                setState(() {}); // Обновляем после создания
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Создать нового персонажа'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor = widget.isDarkMode ? Colors.amber : Colors.blue.shade700;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: accentColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Нет сохраненных персонажей',
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersList() {
    final cardColor = widget.isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor = widget.isDarkMode ? Colors.amber : Colors.blue.shade700;

    return ListView.builder(
      itemCount: widget.charactersBox.length,
      itemBuilder: (context, index) {
        final character = widget.charactersBox.getAt(index);
        return Card(
          color: cardColor,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: accentColor,
              child: Text(
                character?.name.substring(0, 1) ?? '?',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              character?.name ?? 'Неизвестный',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            subtitle: Text(
              '${character?.class_} • ${character?.race} • Ур. ${character?.lvl}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCharacter(index, context),
                  tooltip: 'Удалить',
                ),
              ],
            ),
            onTap: () {
              widget.onCharacterSelected(index);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _deleteCharacter(int index, BuildContext context) {
    final character = widget.charactersBox.getAt(index);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить персонажа'),
        content: Text('Вы уверены, что хотите удалить персонажа "${character?.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              widget.charactersBox.deleteAt(index);
              setState(() {}); // Обновляем состояние после удаления
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Персонаж удален'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
// Обновленный CharacteristicsHeader для поддержки темы
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;
        final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;
        
        return GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHighlighted ? accentColor.withAlpha(30) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: _isHighlighted 
                  ? Border.all(color: accentColor, width: 2)
                  : null,
            ),
            child: Row(
              children: [
                Icon(Icons.auto_stories, color: accentColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Характеристики персонажа',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const Spacer(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHighlighted ? 0.7 : 1.0,
                  child: Text(
                    'Двойной тап для\nпереброса всех',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Обновленный ImageEditDialog для поддержки темы
class ImageEditDialog extends StatefulWidget {
  final Character character;
  final Function(String) onImageChanged;
  final bool isDarkMode;

  const ImageEditDialog({
    super.key,
    required this.character,
    required this.onImageChanged,
    required this.isDarkMode,
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
    final backgroundColor = widget.isDarkMode ? Colors.grey[900] : Colors.grey.shade100;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor = widget.isDarkMode ? Colors.blue : Colors.blue.shade700;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1a1a1a), Color(0xFF003366)],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade100, Colors.blue.shade50],
                ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.image, color: accentColor, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Изображение персонажа',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Введите URL изображения или оставьте пустым для стандартного',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: accentColor, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _buildImagePreview(_urlController.text, widget.isDarkMode),
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
                      style: TextStyle(color: textColor, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'URL изображения',
                        labelStyle: TextStyle(color: accentColor),
                        hintText: 'https://example.com/image.jpg',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        filled: true,
                        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                        prefixIcon: Icon(Icons.link, color: accentColor),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: _clearImage,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
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
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
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
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
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
                      backgroundColor: accentColor,
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

  Widget _buildImagePreview(String url, bool isDarkMode) {
    final placeholderColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.grey.shade200;
    
    if (url.isEmpty) {
      return Container(
        color: placeholderColor,
        child: Icon(
          Icons.person,
          color: isDarkMode ? Colors.blue : Colors.blue.shade700,
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
            color: placeholderColor,
            child: Center(
              child: CircularProgressIndicator(
                color: isDarkMode ? Colors.blue : Colors.blue.shade700,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: placeholderColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 8),
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

// Обновленный EditCharacterDialog для поддержки темы
class EditCharacterDialog extends StatefulWidget {
  final Character character;
  final Function(String, String, String, String) onCharacterChanged;
  final bool isDarkMode;

  const EditCharacterDialog({
    super.key,
    required this.character,
    required this.onCharacterChanged,
    required this.isDarkMode,
  });

  @override
  EditCharacterDialogState createState() => EditCharacterDialogState();
}

class EditCharacterDialogState extends State<EditCharacterDialog> {
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

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
    
    final currentClass = widget.character.currentclass();
    final currentRace = widget.character.currentRace();
    final currentBackground = widget.character.currentbg();
    
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
    final backgroundColor = widget.isDarkMode ? Colors.grey[900] : Colors.grey.shade100;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor = widget.isDarkMode ? Colors.amber : Colors.blue.shade700;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2d1b00), Color(0xFF1a1a1a)],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey.shade100],
                ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_stories, color: accentColor, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Редактирование персонажа',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Измените основные параметры вашего персонажа',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: textColor, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Имя персонажа',
                        labelStyle: TextStyle(color: accentColor),
                        hintText: 'Например: Арагорн, Гэндальф...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        filled: true,
                        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                        prefixIcon: Icon(Icons.person, color: accentColor),
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
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    DropdownButtonFormField<String>(
                      initialValue: selectedRace,
                      decoration: InputDecoration(
                        labelText: 'Раса персонажа',
                        labelStyle: TextStyle(color: accentColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        filled: true,
                        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                        prefixIcon: Icon(Icons.people, color: accentColor),
                      ),
                      dropdownColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                      style: TextStyle(color: textColor),
                      items: races.map((String raceItem) {
                        return DropdownMenuItem<String>(
                          value: raceItem,
                          child: Text(
                            raceItem,
                            style: TextStyle(color: textColor),
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
                    
                    DropdownButtonFormField<String>(
                      initialValue: selectedClass,
                      decoration: InputDecoration(
                        labelText: 'Класс персонажа',
                        labelStyle: TextStyle(color: accentColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        filled: true,
                        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                        prefixIcon: Icon(Icons.security, color: accentColor),
                      ),
                      dropdownColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                      style: TextStyle(color: textColor),
                      items: classes.map((String classItem) {
                        return DropdownMenuItem<String>(
                          value: classItem,
                          child: Text(
                            classItem,
                            style: TextStyle(color: textColor),
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
                    
                    DropdownButtonFormField<String>(
                      initialValue: selectedBackground,
                      decoration: InputDecoration(
                        labelText: 'Предыстория',
                        labelStyle: TextStyle(color: accentColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        filled: true,
                        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                        prefixIcon: Icon(Icons.history, color: accentColor),
                      ),
                      dropdownColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                      style: TextStyle(color: textColor),
                      items: backgrounds.map((String backgroundItem) {
                        return DropdownMenuItem<String>(
                          value: backgroundItem,
                          child: Text(
                            backgroundItem,
                            style: TextStyle(color: textColor),
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
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
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
                      backgroundColor: accentColor,
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
}