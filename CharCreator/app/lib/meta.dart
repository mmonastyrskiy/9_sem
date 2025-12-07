// ignore_for_file: non_constant_identifier_names, constant_identifier_names

// Перечисление флагов метаданных для отслеживания происхождения и статуса различных игровых объектов
// Эти флаги используются для определения источника бонусов, навыков, языков и других характеристик персонажа

enum MetaFlags {
  IS_PICKED_ON_BG(0),       // Флаг указывает, что объект был выбран/получен от предыстории (Background)
  IS_PICKED(1),             // Флаг указывает, что объект был выбран игроком (общий флаг выбора)
  IS_PICKED_ON_CLASS(2),    // Флаг указывает, что объект был выбран/получен от класса персонажа (Class)
  AFFECTED_BY_RACE(3),      // Флаг указывает, что объект был изменен или получен от расы персонажа (Race)
  IS_PICKED_ON_RACE(4);

  final int bitPosition;
    const MetaFlags(this.bitPosition);
  
  // Геттер для получения значения бита (2^bitPosition)
  int get value => 1 << bitPosition;
}

// Класс для хранения метаданных игровых объектов
// Используется для отслеживания происхождения и статуса характеристик персонажа
class Meta {
  // Набор флагов метаданных, описывающих свойства и происхождение объекта
  // Используется Set для обеспечения уникальности флагов
  Set<MetaFlags> MetaFlags_ = {};  // Инициализация пустым набором
  int ToInt() {
    int result = 0;
    

    for (var flag in MetaFlags_) {
      result |= flag.value;
    }
    
    return result;
  }
  
  // Конструктор по умолчанию создает объект с пустым набором флагов
  // Дополнительные методы могут быть добавлены для работы с флагами:
  // - addFlag(MetaFlags flag) - добавление флага
  // - removeFlag(MetaFlags flag) - удаление флага
  // - hasFlag(MetaFlags flag) - проверка наличия флага
  // - clearFlags() - очистка всех флагов
}
abstract interface class HasMeta{
  Meta meta = Meta();
}