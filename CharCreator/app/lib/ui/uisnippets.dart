import 'package:flutter/material.dart';
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

}