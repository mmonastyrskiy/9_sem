// ignore_for_file: constant_identifier_names

// Импорт необходимых модулей
import '../meta.dart';
import '../money.dart';
import 'weapon.dart';
import 'armor.dart';



// Абстрактный интерфейс для представления любого предмета в игре
abstract interface class Item {
  // Базовый интерфейс, который могут реализовывать все предметы
  // Не содержит методов, служит только для маркировки объектов как предметов
}

// Абстрактный интерфейс для предметов, которые можно продавать/покупать
abstract interface class SellableItem {
  // Цена предмета - используется для торговли и экономики
  Price price = Price();
  double weight = 0;
}


// Перечисление типов брони в игре


// Перечисление типов оружия в игре


// Перечисление общих категорий оружия (для группировки)
enum OverallWeaponType {
  SimpleWeapon,   // Простое оружие - базовая категория
  MartialWearpon  // Воинское оружие - продвинутая категория
}

// Класс, представляющий броню в игре
class AbstractArmor implements Item {
  // Тип брони (легкая, средняя, тяжелая, щит)
  ArmorType? type; 
  // Метаданные брони - флаги, указывающие на происхождение, статус и т.д.
  Meta metadata = Meta();

  // Конструктор брони
  // Аргументы:
  // - armor: тип создаваемой брони
  // - metadata: необязательный набор флагов метаданных
  AbstractArmor(ArmorType armor, [Set<MetaFlags>? metadata]) {
    // Устанавливаем тип брони
    type = armor;
    // Устанавливаем метаданные (если переданы) или оставляем пустыми
    this.metadata.MetaFlags_ = metadata!;
  }

  // Статический метод для удаления брони из набора по определенному мета-флагу
  // Аргументы:
  // - armor: набор брони для фильтрации (может быть null)
  // - m: флаг метаданных для поиска и удаления
  static void deletebyMeta(Set<AbstractArmor> armor, MetaFlags m) {
    // Проходим по всем элементам брони в наборе
    if(armor.isEmpty){
      return;
    }
    armor.removeWhere((val)=>  val.metadata.MetaFlags_.contains(m));
  }
}

// Класс, представляющий оружие в игре
class AbstractWeapon implements Item {
  // Тип оружия (меч, лук, посох и т.д.)
  WeaponType? type;
  // Метаданные оружия - флаги для отслеживания статуса и происхождения
  Meta metadata = Meta();

  // Конструктор оружия
  // Аргументы:
  // - weapon: тип создаваемого оружия
  // - metadata: необязательный набор флагов метаданных
  AbstractWeapon(WeaponType weapon, [Set<MetaFlags>? metadata]) {
    // Устанавливаем метаданные (если переданы)
    this.metadata.MetaFlags_ = metadata!;
    // Устанавливаем тип оружия
    type = weapon;
  }

  // Статический метод для удаления оружия из набора по определенному мета-флагу
  // Аргументы:
  // - weapon: набор оружия для фильтрации (может быть null)
  // - m: флаг метаданных для поиска и удаления
  static void deletebyMeta(Set<AbstractWeapon> weapon, MetaFlags m) {
    if(weapon.isEmpty){
      return;
    }
    // Проходим по всем элементам оружия в наборе
    weapon.removeWhere((val)=> val.metadata.MetaFlags_.contains(m));
  }
}