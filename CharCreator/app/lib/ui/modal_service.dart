// modal_service.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Импортируйте ваш ThemeProvider
import 'theme_provider.dart'; // Создайте этот файл если его нет

class ModalService with ChangeNotifier {
  BuildContext? _context;

  // Метод для установки контекста (вызывается из корня приложения)
  void setContext(BuildContext context) {
    _context = context;
  }

  // Геттер для получения текущей темы
  bool get _isDarkMode {
    if (_context == null) return true; // fallback
    final themeProvider = Provider.of<ThemeProvider>(_context!, listen: false);
    return themeProvider.isDarkMode;
  }

  // Метод для безопасного получения контекста
  BuildContext? get _safeContext {
    try {
      return _context;
    } catch (e) {
      return null;
    }
  }

  Future<String?> showListPicker(Map<String, dynamic> items) async {
    final context = _safeContext;
    if (context == null) return null;

    final isDarkMode = _isDarkMode;
    List<String> keys = items.keys.toList();
    List<dynamic> vals = items.values.toList();

    final selectedIndex = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: isDarkMode ? const Color(0xFF2d1b00) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(
          color: isDarkMode ? Colors.amber : Colors.blue.shade700,
          width: 2,
        ),
      ),
      builder: (BuildContext context) {
        return _ListPickerContent(
          items: items,
          keys: keys,
          isDarkMode: isDarkMode,
        );
      },
    );

    if (selectedIndex != null && selectedIndex >= 0 && selectedIndex < vals.length) {
      return keys[selectedIndex];
    }
    return null;
  }

  Future<Set<String>> showMultiSelectListPicker({
    required Set<String> items,
    List<String>? initialSelections,
  }) async {
    final context = _safeContext;
    if (context == null) return {};

    final isDarkMode = _isDarkMode;
    final List<String> keys = items.toList();

    final List<bool>? result = await showDialog<List<bool>>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _MultiSelectDialog(
          items: keys,
          initialSelections: initialSelections,
          isDarkMode: isDarkMode,
        );
      },
    );

    if (result == null) return {};

    final Set<String> selections = {};
    for (var i = 0; i < result.length; i++) {
      if (result[i]) selections.add(keys[i]);
    }
    return selections;
  }

  void showErrorDialog(String errorMessage) {
    final context = _safeContext;
    if (context == null) return;

    final isDarkMode = _isDarkMode;
    final backgroundColor = isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF522d2d),
                      Color(0xFF2d1b00),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.shade50,
                      Colors.white,
                    ],
                  ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Ошибка',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Закрыть'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Вспомогательный виджет для ListPicker
class _ListPickerContent extends StatelessWidget {
  final Map<String, dynamic> items;
  final List<String> keys;
  final bool isDarkMode;

  const _ListPickerContent({
    required this.items,
    required this.keys,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isDarkMode ? Colors.amber : Colors.blue.shade700;
    final cardColor = isDarkMode ? const Color(0xFF1a1a1a) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2d1b00),
                  Color(0xFF1a1a1a),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                ],
              ),
      ),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: accentColor, width: 1),
            ),
            child: ListTile(
              leading: Icon(Icons.arrow_forward_ios, color: accentColor, size: 16),
              title: Text(
                keys[index],
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context, index);
              },
            ),
          );
        },
      ),
    );
  }
}

// MultiSelectDialog (можно вынести в отдельный файл если нужно)
class _MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String>? initialSelections;
  final bool isDarkMode;

  const _MultiSelectDialog({
    required this.items,
    this.initialSelections,
    required this.isDarkMode,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<bool> _selectionState;

  @override
  void initState() {
    super.initState();
    _selectionState = List.generate(
      widget.items.length,
      (index) => widget.initialSelections?.contains(widget.items[index]) ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.isDarkMode ? Colors.amber : Colors.blue.shade700;
    final backgroundColor = widget.isDarkMode ? const Color(0xFF2d1b00) : Colors.white;
    final cardColor = widget.isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey.shade100;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: accentColor, width: 2),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 500,
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2d1b00),
                    Color(0xFF1a1a1a),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey.shade100,
                  ],
                ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: accentColor, width: 1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.checklist, color: accentColor),
                  const SizedBox(width: 8),
                  Text(
                    'Множественный выбор',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.items.length,
                itemBuilder: (_, index) {
                  return Card(
                    color: cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selectionState[index] ? accentColor : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: _selectionState[index],
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: accentColor,
                      checkColor: widget.isDarkMode ? Colors.black : Colors.white,
                      title: Text(
                        widget.items[index],
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectionState[index] = value ?? false;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: accentColor, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    child: const Text('Отмена'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: widget.isDarkMode ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(_selectionState);
                    },
                    child: const Text('Выбрать'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}