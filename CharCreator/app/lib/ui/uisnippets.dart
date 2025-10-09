// Импорт необходимых библиотек Flutter
import 'package:flutter/material.dart';
// Импорт библиотеки для работы с вибрацией
import 'package:vibration/vibration.dart';

// Класс для управления модальными окнами выбора
class ModalDispatcher{
  // Статический метод для показа модального окна с выбором одного элемента из списка
  // Аргументы:
  // - context: контекст BuildContext для навигации
  // - items: Map где ключи - отображаемые строки, значения - связанные данные
  // Возвращает: Future<String?> - выбранный ключ или null
  static showListPicker(BuildContext context, Map<String, dynamic> items) async {
  // Преобразуем ключи Map в List для доступа по индексу
  List<String> keys = items.keys.toList();
  // Преобразуем значения Map в List для доступа по индексу
  List<dynamic> vals = items.values.toList();

  // Показываем модальное окно снизу экрана и ждем результат
  final selectedIndex = await showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      // Создаем ListView для отображения списка элементов
      return ListView.builder(
        itemCount: items.length, // Устанавливаем количество элементов равным размеру Map
        itemBuilder: (BuildContext context, int index) {
          // Создаем элемент списка для каждого элемента Map
          return ListTile(
            title: Text(keys[index]), // Отображаем ключ как текст
            onTap: () {
              // При тапе на элемент закрываем модальное окно и возвращаем индекс
              Navigator.pop(context, index); // Возврат индекса выбранного элемента
            },
          );
        },
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
static showMultiSelectListPicker({
  required BuildContext context,
  required Map<String, dynamic> items,
  List<String>? initialSelections, // Новый опциональный аргумент
}) async {
  // Преобразуем ключи Map в List для удобного доступа по индексу
  List<String> keys = items.keys.toList();
  // Создаем список boolean значений для отслеживания состояния выбора каждого элемента
  List<bool> selectionState = List.filled(items.length, false);

  // Если переданы начальные выборы, устанавливаем соответствующие пункты как выбранные
  if (initialSelections != null) {
    // Проходим по всем элементам initialSelections
    for (final key in initialSelections) {
      // Находим индекс ключа в основном списке
      final index = keys.indexOf(key);
      // Если ключ найден в основном списке
      if (index >= 0) {
        // Устанавливаем состояние выбора в true
        selectionState[index] = true;
      }
    }
  }

  // Показываем модальное окно и ждем результат
  final result = await showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true, // Позволяет окну занимать большую часть экрана
    // Настраиваем форму окна с закругленными углами сверху
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      // Используем StatefulBuilder для управления состоянием внутри модального окна
      return SizedBox(
        height: 300, // Фиксированная высота окна
        child: Column(
          children: [
            // Растягиваемый контейнер для списка
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, // Позволяет ListView занимать только необходимое пространство
                padding: EdgeInsets.all(8), // Отступы вокруг списка
                physics: BouncingScrollPhysics(), // Эффект отскока при прокрутке
                itemCount: items.length, // Количество элементов в списке
                itemBuilder: (_, i) {
                  // Создаем элемент списка с Checkbox
                  return CheckboxListTile(
                    value: selectionState[i], // Текущее состояние выбора
                    controlAffinity: ListTileControlAffinity.leading, // Checkbox слева от текста
                    title: Text(keys[i]), // Отображаем ключ как текст
                    onChanged: (value) {
                      // При изменении состояния Checkbox обновляем состояние
                      setState(() {
                        selectionState[i] = !selectionState[i]; // Инвертируем текущее состояние
                      });
                    },
                  );
                },
              ),
            ),
            // Панель кнопок внизу окна
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween, // Равномерное распределение кнопок
              children: [
                // Кнопка отмены
                OutlinedButton(
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.red)),
                  child: const Text('Отмена'),
                  onPressed: () => Navigator.of(context).pop([]), // Закрываем окно с пустым результатом
                ),
                // Кнопка подтверждения выбора
                ElevatedButton(
                  child: const Text('Выбрать'),
                  onPressed: () {
                    // Собираем все выбранные элементы
                    final selections = [];
                    // Проходим по всем элементам состояния выбора
                    for (var i = 0; i < selectionState.length; i++) {
                      // Если элемент выбран, добавляем его ключ в результат
                      if (selectionState[i]) {
                        selections.add(keys[i]);
                      }
                    }
                    // Закрываем окно и возвращаем выбранные элементы
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

  // Возвращаем результат или пустой Set если результат null
  return result ?? {};
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
    await Vibration.vibrate(duration: 500);

  // Показываем диалоговое окно
  final dialog = Dialog(
    child: Container(
      color: Colors.red, // Красный фон для индикации ошибки
      padding: const EdgeInsets.all(16), // Внутренние отступы
      child: Text(errorMessage, style: const TextStyle(color: Colors.white)), // Белый текст сообщения
    ),
  );

  // Устанавливаем таймер для автоматического закрытия диалога через 5 секунд
  Future.delayed(const Duration(seconds: 5)).then((_) => Navigator.of(context).pop());

  // Показываем диалоговое окно
  showDialog(
    context: context,
    builder: (_) => dialog, // Используем созданный диалог
  );
}
}