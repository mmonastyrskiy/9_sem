// Импорт необходимых библиотек Flutter
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
    backgroundColor: const Color(0xFF2d1b00),
    isScrollControlled: true, // Позволяет окну занимать большую часть экрана
    // Настраиваем форму окна с закругленными углами сверху
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      side: BorderSide(color: Colors.amber, width: 2),
    ),
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      // Используем StatefulBuilder для управления состоянием внутри модального окна
      return Container(
        height: 400, // Фиксированная высота окна
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
            // Растягиваемый контейнер для списка
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, // Позволяет ListView занимать только необходимое пространство
                padding: const EdgeInsets.all(8), // Отступы вокруг списка
                physics: const BouncingScrollPhysics(), // Эффект отскока при прокрутке
                itemCount: items.length, // Количество элементов в списке
                itemBuilder: (_, i) {
                  // Создаем элемент списка с Checkbox
                  return Card(
                    color: const Color(0xFF1a1a1a),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: selectionState[i] ? Colors.amber : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: selectionState[i], // Текущее состояние выбора
                      controlAffinity: ListTileControlAffinity.leading, // Checkbox слева от текста
                      activeColor: Colors.amber,
                      checkColor: Colors.black,
                      title: Text(
                        keys[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        // При изменении состояния Checkbox обновляем состояние
                        setState(() {
                          selectionState[i] = !selectionState[i]; // Инвертируем текущее состояние
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // Панель кнопок внизу окна
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.amber, width: 1)),
              ),
              child: OverflowBar(
                alignment: MainAxisAlignment.spaceBetween, // Равномерное распределение кнопок
                children: [
                  // Кнопка отмены
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.amber),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Отмена'),
                    onPressed: () => Navigator.of(context).pop(<String>[]), // Закрываем окно с пустым списком
                  ),
                  // Кнопка подтверждения выбора
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Выбрать',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Собираем все выбранные элементы с правильным типом
                      final List<String> selections = [];
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
            ),
          ],
        ),
      );
    }),
  );

  // Возвращаем результат или пустой список если результат null
  return result ?? <String>[];
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