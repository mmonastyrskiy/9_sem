// Импорт библиотеки материала Flutter для отображения виджетов
import 'package:flutter/material.dart';

// Класс для управления показом модальных окон (модал-диспетчер)
class ModalDispatcher {
  // Статический метод для показа модального окна с выбором одного пункта из списка
  static showListPicker(BuildContext context, Map<String, dynamic> items) async {
    // Преобразуем ключи и значения карты в отдельные списки
    List<String> keys = items.keys.toList();       // Список ключей (наименований пунктов)
    List<dynamic> vals = items.values.toList();   // Список значений

    // Показываем модальное окно снизу экрана
    final selectedIndex = await showModalBottomSheet<int>(   
      context: context,                          // Контекст текущего экрана
      builder: (BuildContext context) {           // Функция построения содержимого окна
        return ListView.builder(                   // Создаем лист-вью с прокруткой
          itemCount: items.length,                 // Количество элементов равно количеству пунктов
          itemBuilder: (BuildContext context, int index) {    
            return ListTile(                       // Каждый пункт представляет собой плитку
              title: Text(keys[index]),            // Заголовком является ключ элемента
              onTap: () {                          // Обработчик нажатия на плитку
                Navigator.pop(context, index);     // Закрываем окно и передаем индекс выбранного элемента
              },
            );
          },
        );
      },
    );

    // Проверяем наличие и валидность полученного индекса
    if (selectedIndex != null &&
        selectedIndex >= 0 &&
        selectedIndex < vals.length) {
      return keys[selectedIndex];               // Возвращаем название выбранного элемента
    }

    return null;                                // Возвращаем null, если выбор не сделан
  }

  // Статический метод для показа модального окна с выбором множества пунктов из списка
  static showMultiSelectListPicker({
    required BuildContext context,              // Обязательный контекст экрана
    required Map<String, dynamic> items,        // Карта элементов (ключ-значение)
    List<String>? initialSelections,           // Начально выделенные элементы (необязательно)
  }) async {
    List<String> keys = items.keys.toList();    // Получаем список всех наименований пунктов
    List<bool> selectionState = List.filled(items.length, false); // Массив состояний выбора (false=не выбран)

    // Устанавливаем состояния выбора исходя из переданных начальных выборов
    if (initialSelections != null) {
      for (final key in initialSelections) {
        final index = keys.indexOf(key);         // Ищем позицию ключа среди именованных пунктов
        if (index >= 0) {
          selectionState[index] = true;          // Выбираем соответствующий пункт
        }
      }
    }

    // Показываем модальное окно внизу экрана
    final result = await showModalBottomSheet<List<String>>(  
      context: context,                         // Текущий контекст экрана
      isScrollControlled: true,                 // Контроль прокрутки
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), // Округлая форма сверху
      builder: (context) => StatefulBuilder(builder: (context, setState) { // Используем StatefulBuilder для изменения UI
        return SizedBox(                           // Ограничиваем высоту окна
          height: 300,
          child: Column(children: [
            Expanded(child: ListView.builder(      // Прокручиваемый список
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              physics: BouncingScrollPhysics(),   // Эффект упругости при скролле
              itemCount: items.length,
              itemBuilder: (_, i) {
                return CheckboxListTile(           // Чекбокс + текстовая метка
                  value: selectionState[i],        // Текущее состояние чекбокса
                  controlAffinity: ListTileControlAffinity.leading, // Расположение чекбокса слева
                  title: Text(keys[i]),            // Название пункта
                  onChanged: (value) {            // Изменение состояния чекбокса
                    setState(() {
                      selectionState[i] = !selectionState[i]; // Инвертируем состояние
                    });
                  },
                );
              },
            )),
            OverflowBar(alignment: MainAxisAlignment.spaceBetween, children: [
              OutlinedButton(                     // Кнопка отмены
                style: ButtonStyle(foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.red)), // Красный цвет текста
                child: const Text('Отмена'),      
                onPressed: () => Navigator.of(context).pop([]), // Закрытие окна без результата
              ),
              ElevatedButton(                     // Подтверждение выбора
                child: const Text('Выбрать'),
                onPressed: () {
                  final selections = [];          // Финальный массив выбранных пунктов
                  for (var i = 0; i < selectionState.length; i++) {
                    if (selectionState[i]) {      // Добавляем выбранные элементы
                      selections.add(keys[i]);
                    }
                  }
                  Navigator.of(context).pop(selections); // Возвращаем список выбранных элементов
                },
              ),
            ]),
          ]),
        );
      }),
    );

    return result ?? {};                         // Возвращаем результат (или пустой объект, если результат отсутствует)
  }
}