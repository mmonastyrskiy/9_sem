// Импорт необходимых библиотек Flutter
import 'dart:async';

import 'package:flutter/material.dart';
// Импорт библиотеки для работы с вибрацией

// Класс для управления модальными окнами выбора
class ModalDispatcher{
  // Статический метод для показа модального окна с выбором одного элемента из списка
  // Аргументы:
  // - context: контекст BuildContext для навигации
  // - items: Map где ключи - отображаемые строки, значения - связанные данные
  // Возвращает: Future<String?> - выбранный ключ или null
  static  showListPicker(BuildContext context, Map<String, dynamic> items) async {
  // Преобразуем ключи Map в List для доступа по индексу
  List<String> keys = items.keys.toList();
  // Преобразуем значения Map в List для доступа по индексу
  List<dynamic> vals = items.values.toList();

  // Показываем модальное окно снизу экрана и ждем результат
  final selectedIndex = await showModalBottomSheet<int>(
    context: context,
    backgroundColor: const Color(0xFF2d1b00),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      side: BorderSide(color: Colors.amber, width: 2),
    ),
    builder: (BuildContext context) {
      // Создаем ListView для отображения списка элементов
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2d1b00),
              Color(0xFF1a1a1a),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: items.length, // Устанавливаем количество элементов равным размеру Map
          itemBuilder: (BuildContext context, int index) {
            // Создаем элемент списка для каждого элемента Map
            return Card(
              color: const Color(0xFF1a1a1a),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.amber, width: 1),
              ),
              child: ListTile(
                leading: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
                title: Text(
                  keys[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // При тапе на элемент закрываем модальное окно и возвращаем индекс
                  Navigator.pop(context, index); // Возврат индекса выбранного элемента
                },
              ),
            );
          },
        ),
      );
    },
  );

  // Проверяем, что выбран валидный индекс
  if (selectedIndex != null && selectedIndex >= 0 && selectedIndex < vals.length) {
    return keys[selectedIndex]; // Возвращаем выбранный элемент (ключ из Map)
  }

  return null; // Или другое подходящее значение по умолчанию
}



// Статический метод для показа модального окна с множественным выбором
// Аргументы:
// - context: обязательный контекст BuildContext
// - items: обязательный Map элементов для выбора
// - initialSelections: необязательный список предварительно выбранных элементов
static Future<Set<String>> showMultiSelectListPicker({
  required BuildContext context,
  required Map<String, dynamic> items,
  List<String>? initialSelections,
}) {
  final List<String> keys = items.keys.toList();
  final List<bool> selectionState = List.generate(
    items.length,
    (index) => initialSelections?.contains(keys[index]) ?? false,
  );

  Completer<Set<String>> completer = Completer<Set<String>>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFF2d1b00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.amber, width: 2),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2d1b00),
                Color(0xFF1a1a1a),
              ],
            ),
          ),
          child: Column(
            children: [
              // Заголовок
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.amber, width: 1)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.checklist, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      'Множественный выбор',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Список
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: const Color(0xFF1a1a1a),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: selectionState[index] ? Colors.amber : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: CheckboxListTile(
                        value: selectionState[index],
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.amber,
                        checkColor: Colors.black,
                        title: Text(
                          keys[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          // Обновляем состояние
                          (context as Element).markNeedsBuild();
                          selectionState[index] = value ?? false;
                        },
                      ),
                    );
                  },
                ),
              ),
              // Кнопки
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.amber, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.amber,
                        side: const BorderSide(color: Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        completer.complete({});
                      },
                      child: const Text('Отмена'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        final Set<String> selections = {};
                        for (var i = 0; i < selectionState.length; i++) {
                          if (selectionState[i]) {
                            selections.add(keys[i]);
                          }
                        }
                        Navigator.of(context).pop();
                        completer.complete(selections);
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
    },
  );

  // Ждем завершения Completer
  return completer.future.then((result) => result).catchError((_) => {});
}
}

// Класс для управления всплывающими окнами и диалогами
class PopUpDispatcher{
  // Статический метод для показа диалога ошибки с вибрацией
  // Аргументы:
  // - context: контекст BuildContext для показа диалога
  // - errorMessage: текст сообщения об ошибке
  static void showErrorDialog(BuildContext context,String errorMessage)async {
    // Активируем вибрацию на 500 миллисекунд

  // Показываем диалоговое окно
  final dialog = Dialog(
    backgroundColor: const Color(0xFF2d1b00),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Colors.red, width: 2),
    ),
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF522d2d),
            Color(0xFF2d1b00),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок ошибки
          Row(
            children: [
              const Icon(Icons.error, color: Colors.red, size: 24),
              const SizedBox(width: 8),
              const Text(
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
          // Сообщение об ошибке
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Кнопка закрытия
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
  );

  // Показываем диалоговое окно
  showDialog(
    context: context,
    builder: (_) => dialog, // Используем созданный диалог
  );
}
}