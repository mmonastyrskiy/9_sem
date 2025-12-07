// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

import 'dart:math';

// Перечисление типов игральных костей
enum DiceType  {
D4,D6,D10,D12,D100,D8,D20,DN,None

}


extension DiceTypeExtension on DiceType {
  String get displayName {
    switch (this) {
      case DiceType.D4: return "d4";
      case DiceType.D6: return "d6";
      case DiceType.D8: return "d8";
      case DiceType.D10: return "d10";
      case DiceType.D12: return "d12";
      case DiceType.D20: return "d20";
      case DiceType.D100: return "d100";
      case DiceType.DN: return "dn";
      case DiceType.None: return "none";
    }
  }
}

// Класс для хранения результата броска кости
class DieResult
{
  DiceType? type;    // Тип кости
  int result=0;      // Результат броска
  

  // Преобразует количество граней в тип кости
  DiceType dim2type (int dt){

    switch(dt){
      case 4: return DiceType.D4;   // 4-гранная кость
      case 6: return DiceType.D6;   // 6-гранная кость (кубик)
      case 8: return DiceType.D8;   // 8-гранная кость
      case 10: return DiceType.D10; // 10-гранная кость
      case 12: return DiceType.D12; // 12-гранная кость
      case 100: return DiceType.D100; // 100-гранная кость (процентная)
      case 20: return DiceType.D20;
      default: return DiceType.DN;  // Произвольная кость с N гранями
    }
  }
  
  // Конструктор результата броска
  DieResult(int dt, int rr){
    // Определяем тип кости based на количестве граней
    type = dim2type(dt);
    // Сохраняем результат броска
    result = rr;
  }
}

// Фабрика для создания костей и выполнения бросков
class diceFactory{
  int dim=0;           // Количество граней кости
  final rnd =Random(); // Генератор случайных чисел

  // Конструктор фабрики
  diceFactory (int dt){
    // Устанавливаем количество граней для кости
    dim = dt;
  }
  
  // Выполняет бросок кости
  DieResult throwdie(){
    // Генерируем случайное число от 1 до dim (включительно)
    int result = rnd.nextInt(dim-1) + 1;
    // Создаем и возвращаем объект с результатом броска
    return DieResult(dim,result);
  }
}

// Специализированные классы для конкретных типов костей:

// Кость с 4 гранями
class D4 extends diceFactory{
  D4() :super(4); // Вызов конструктора родителя с параметром 4
}

// Кость с 6 гранями
class D6 extends diceFactory{
  D6() :super(6); // Вызов конструктора родителя с параметром 6
}

// Кость с 8 гранями
class D8 extends diceFactory{
  D8() :super(8); // Вызов конструктора родителя с параметром 8
}

// Кость с 10 гранями
class D10 extends diceFactory{
D10() :super(10); // Вызов конструктора родителя с параметром 10
}

// Кость с 12 гранями
class D12 extends diceFactory{
D12() :super(12); // Вызов конструктора родителя с параметром 12
}

// Кость с 100 гранями
class D100 extends diceFactory{
  D100() : super(100); // Вызов конструктора родителя с параметром 100
}
class D20 extends diceFactory{
  D20() : super(20);
}

// Произвольная кость с заданным количеством граней
class DN extends diceFactory{
  DN(super.dt); // Прямая передача параметра в конструктор родителя
}

// Класс для управления группой бросков костей
class ThrowObject{
List<DieResult> res = [];      // Список результатов бросков
List<diceFactory> tothrow = []; // Список костей для броска

// Вычисляет общую сумму результатов
int total({ bool clear_result = true}) {
  int t = 0; // Переменная для накопления суммы
  // Проходим по всем результатам бросков
  for (DieResult r in res){
    t += r.result; // Добавляем каждый результат к общей сумме
  }
  // Если установлен флаг очистки, очищаем результаты
 if(clear_result){clear();} 
  
  return t; // Возвращаем общую сумму
}

// Добавляет кости для броска по количеству граней
void add(int dim,{int ammount=1}) {
  // Проверка на недопустимое количество костей
  if(ammount <= 0){
    return; // Выход из функции если количество <= 0
  }

  // Цикл для добавления указанного количества костей
  for(int i=0; i<ammount;i++){
  // Выбор соответствующего типа кости based на количестве граней
  switch(dim){
    case 4: tothrow.add(D4()); break; // Добавляем D4 кость
    case 6: tothrow.add(D6()); break; // Добавляем D6 кость
    case 8: tothrow.add(D8()); break; // Добавляем D8 кость
    case 10: tothrow.add(D10()); break; // Добавляем D10 кость
    case 12: tothrow.add(D12()); break; // Добавляем D12 кость
    case 100: tothrow.add(D100()); break; // Добавляем D100 кость
    default: tothrow.add(DN(dim)); break; // Добавляем произвольную кость
  }
}
}

// Добавляет кость для броска по типу DiceType
void addDT(DiceType dt){
    // Выбор кости based на переданном типе
    switch(dt){
      case DiceType.D4: tothrow.add(D4()); break; // Добавляем D4 кость
      case DiceType.D6: tothrow.add(D6()); break; // Добавляем D6 кость
      case DiceType.D10: tothrow.add(D10()); break; // Добавляем D10 кость
      case DiceType.D12: tothrow.add(D12()); break; // Добавляем D12 кость
      default: tothrow.add(D100()); break; // По умолчанию добавляем D100 кость
    }
  }

// Выполняет все запланированные броски костей
void DoRoll(){
  // Проходим по всем костям, подготовленным для броска
  for(diceFactory d in tothrow){
    // Выполняем бросок каждой кости и добавляем результат в список
    res.add(d.throwdie());
  }
  tothrow.clear(); // Очищаем список костей для броска
  // Сортируем результаты по возрастанию
  res.sort((a, b) => a.result.compareTo(b.result));
}

// Удаляет указанное количество наименьших результатов
void strip(int idx) => res.removeRange(0, idx); // Удаляем элементы с 0 по idx-1

// Очищает все результаты и список костей для броска
void clear(){
  tothrow.clear(); // Очищаем список костей для броска
  res.clear();     // Очищаем список результатов
}

// Преобразует результаты в строковое представление
String tostr(){
  String s = ""; // Инициализируем пустую строку
  // Проходим по всем результатам
  for(var r in res) {
    // Добавляем информацию о типе кости и результате
    s += ("${r.type} -> ${r.result}");
    s+= "\n"; // Добавляем перевод строки
  }
  return s; // Возвращаем собранную строку
}
}