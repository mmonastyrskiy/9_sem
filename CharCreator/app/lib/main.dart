// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'character.dart';

void main() {
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

class CharacterSheetScreen extends StatefulWidget {
  const CharacterSheetScreen({super.key});

  @override
  _CharacterSheetScreenState createState() => _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  late Character c;

  @override
  void initState() {
    super.initState();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getAbilityColor(int value) {
    if (value >= 16) return Colors.green;
    if (value >= 12) return Colors.blue;
    if (value >= 8) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    c = Character(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Домой"),
              Tab(text: "Инвентарь"),
              Tab(text: "Заклинания"),
              Tab(text: "О персонаже")
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
                builder: (context) => EditCharacterNameDialog(
                  currentName: c.name,
                  onNameChanged: (newName) {
                    setState(() {
                      c.name = newName;
                    });
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
            const Center(child: Text("Инвентарь - в разработке")),
            const Center(child: Text("Заклинания - в разработке")),
            const Center(child: Text("О персонаже - в разработке")),
          ],
        ),
      ),
    );
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
                        const Text(
                          'Искатель приключений • Уровень 1',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.amber),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditCharacterNameDialog(
                          currentName: c.name,
                          onNameChanged: (newName) {
                            setState(() {
                              c.name = newName;
                            });
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

          // Заголовок характеристик
          const Row(
            children: [
              Icon(Icons.auto_stories, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Text(
                'Характеристики персонажа',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              Spacer(),
              Text(
                'Двойной тап для\nпереброса всех',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Список характеристик в стиле D&D
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                String AbilityName = c.AbilityNames().elementAt(index);
                int AbilityValue = c.getbasicstats().values.toList().elementAt(index).value;
                int AbilityModifier = c.getbasicstats().values.toList().elementAt(index).mod;
                
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
                          Container(
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
          ),

          // Подсказка
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withOpacity(0.5)),
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
}

// Диалог редактирования имени (оставляем как было)
class EditCharacterNameDialog extends StatefulWidget {
  final String currentName;
  final Function(String) onNameChanged;

  const EditCharacterNameDialog({
    Key? key,
    required this.currentName,
    required this.onNameChanged,
  }) : super(key: key);

  @override
  _EditCharacterNameDialogState createState() => _EditCharacterNameDialogState();
}

class _EditCharacterNameDialogState extends State<EditCharacterNameDialog> {
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    if (_formKey.currentState!.validate()) {
      final newName = _nameController.text.trim();
      widget.onNameChanged(newName);
      Navigator.of(context).pop(newName);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_stories, color: Colors.amber, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Имя персонажа',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Введите новое имя для вашего персонажа',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            Form(
              key: _formKey,
              child: TextFormField(
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
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _saveName(),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_nameController.text.length}/25 символов',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
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
                  onPressed: _saveName,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Сохранить имя',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}