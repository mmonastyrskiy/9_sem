import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
class ModalDispatcher{
  static showListPicker(BuildContext context, Map<String, dynamic> items) async {
  List<String> keys = items.keys.toList();
  List<dynamic> vals = items.values.toList();

  final selectedIndex = await showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(keys[index]),
            onTap: () {
              Navigator.pop(context, index); // Возврат индекса выбранного элемента
            },
          );
        },
      );
    },
  );

  if (selectedIndex != null && selectedIndex >= 0 && selectedIndex < vals.length) {
    return keys[selectedIndex]; // Возвращаем выбранный элемент
  }

  return null; // Или другое подходящее значение по умолчанию
}



static showMultiSelectListPicker({
  required BuildContext context,
  required Map<String, dynamic> items,
  List<String>? initialSelections, // Новый опциональный аргумент
}) async {
  List<String> keys = items.keys.toList();
  List<bool> selectionState = List.filled(items.length, false);

  // Если переданы начальные выборы, устанавливаем соответствующие пункты как выбранные
  if (initialSelections != null) {
    for (final key in initialSelections) {
      final index = keys.indexOf(key);
      if (index >= 0) {
        selectionState[index] = true;
      }
    }
  }

  final result = await showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                physics: BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  return CheckboxListTile(
                    value: selectionState[i],
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(keys[i]),
                    onChanged: (value) {
                      setState(() {
                        selectionState[i] = !selectionState[i];
                      });
                    },
                  );
                },
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.red)),
                  child: const Text('Отмена'),
                  onPressed: () => Navigator.of(context).pop([]),
                ),
                ElevatedButton(
                  child: const Text('Выбрать'),
                  onPressed: () {
                    final selections = [];
                    for (var i = 0; i < selectionState.length; i++) {
                      if (selectionState[i]) {
                        selections.add(keys[i]);
                      }
                    }
                    Navigator.of(context).pop(selections);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }),
  );

  return result ?? {};
}

}
class PopUpDispatcher{
  static void showErrorDialog(BuildContext context,String errorMessage)async {
    await Vibration.vibrate(duration: 500);

  // Показываем диалоговое окно
  final dialog = Dialog(
    child: Container(
      color: Colors.red,
      padding: const EdgeInsets.all(16),
      child: Text(errorMessage, style: const TextStyle(color: Colors.white)),
    ),
  );

  Future.delayed(const Duration(seconds: 5)).then((_) => Navigator.of(context).pop());

  showDialog(
    context: context,
    builder: (_) => dialog,
    

  );
}
}