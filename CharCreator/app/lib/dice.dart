// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names
// Игнорируем предупреждения компилятора относительно стиля написания кода (такое иногда полезно, особенно при совместимости старого кода).

// Библиотека для работы с математическими функциями, включая генератор случайных чисел.
import 'dart:math';

// Перечисление типов игральных костей (игровых кубиков).
enum DieType {
  D4, // Кубик с четырьмя гранями
  D6, // Кубик с шестью гранями
  D8, // Кубик с восемью гранями
  D10, // Кубик с десятью гранями
  D12, // Кубик с двенадцатью гранями
  D100, // Процентный кубик (обычно используется пара десятигранных кубиков)
  DN // Неопределенный тип кости
}

// Класс для хранения результатов броска игральной кости.
class DieResult {
  DieType? type; // Тип используемого кубика
  int result = 0; // Результат броска

  // Вспомогательная функция преобразования числа граней в тип кубика.
  DieType dim2type(int dt) {
    switch (dt) {
      case 4:
        return DieType.D4;
      case 6:
        return DieType.D6;
      case 8:
        return DieType.D8;
      case 10:
        return DieType.D10;
      case 12:
        return DieType.D12;
      case 100:
        return DieType.D100;
      default:
        return DieType.DN;
    }
  }

  // Конструктор принимает количество граней и результат броска.
  DieResult(int dt, int rr) {
    type = dim2type(dt); // Определяем тип кубика
    result = rr; // Записываем результат
  }
}

// Фабричный класс для генерации бросков игральных костей.
class diceFactory {
  int dim = 0; // Количество граней кубика
  final Random rnd = Random(); // Генератор случайных чисел

  // Конструктор устанавливает количество граней кубика.
  diceFactory(int dt) {
    dim = dt;
  }

  // Генерирует бросок кубика и возвращает результат.
  DieResult throwdie() {
    int result = rnd.nextInt(dim-1) + 1; // Генерация случайного числа от 1 до количества граней
    return DieResult(dim, result); // Создание объекта результата броска
  }
}

// Специализированные классы-костыли для конкретных видов игральных костей (все наследуются от фабрики).
class D4 extends diceFactory {
  D4() : super(4); // Создает четырехгранный кубик
}

class D6 extends diceFactory {
  D6() : super(6); // Создает шестигранный кубик
}

class D8 extends diceFactory {
  D8() : super(8); // Создает восьмигранный кубик
}

class D10 extends diceFactory {
  D10() : super(10); // Создает десятигранный кубик
}

class D12 extends diceFactory {
  D12() : super(12); // Создает двеннадцатигранный кубик
}

class D100 extends diceFactory {
  D100() : super(100); // Создает процентный кубик (сотнегранный)
}

class DN extends diceFactory {
  DN(super.dt); // Поддержка нестандартных кубиков с произвольным числом граней
}

// Объект, ответственный за проведение серии бросков игральных костей.
class ThrowObject {
  List<DieResult> res = []; // Результаты предыдущих бросков
  List<diceFactory> tothrow = []; // Кубики, предназначенные для следующего броска

  // Сумма всех результатов бросков.
  int total() {
    int t = 0;
    for (DieResult r in res) {
      t += r.result;
    }
    return t;
  }

  // Добавляет указанное число кубиков определенного типа для последующего броска.
  void add(int dim, {int amount = 1}) {
    if (amount <= 0) {
      return;
    }
    for (int i = 0; i < amount; i++) {
      switch (dim) {
        case 4:
          tothrow.add(D4()); // Добавляем четырёхгранный кубик
        case 6:
          tothrow.add(D6()); // Добавляем шестигранный кубик
        case 8:
          tothrow.add(D8()); // Добавляем восьмигранный кубик
        case 10:
          tothrow.add(D10()); // Добавляем десятигранный кубик
        case 12:
          tothrow.add(D12()); // Добавляем двенадцатигранный кубик
        case 100:
          tothrow.add(D100()); // Добавляем сотнегранный кубик
        default:
          tothrow.add(DN(dim)); // Добавляем неопределённый кубик с заданным количеством граней
      }
    }
  }

  // Выполняет серию бросков и сохраняет результаты.
  void DoRoll(int size) {
    for (diceFactory d in tothrow) {
      res.add(d.throwdie()); // Бросаем кубик и добавляем результат
    }
    tothrow.clear(); // Очищаем очередь ожидающих броски кубиков
    res.sort((a, b) => a.result.compareTo(b.result)); // Сортируем результаты по возрастанию
  }

  // Удаляет первые `idx` результатов бросков.
  void strip(int idx) => res.removeRange(0, idx);

  // Полностью очищает очередь бросков и результаты.
  void clear() {
    tothrow.clear();
    res.clear();
  }

  // Формирование строки с результатами бросков.
  String tostr() {
    String s = '';
    for (var r in res) {
      s += ('${r.type} -> ${r.result}\n'); // Формируем вывод каждого броска
    }
    return s;
  }
}