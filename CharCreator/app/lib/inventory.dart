// inventory.dart

// ignore_for_file: non_constant_identifier_names

import 'meta.dart';
import 'items/weapon.dart';
import 'items/armor.dart';
import 'items/item.dart';
import 'package:hive/hive.dart';

// Основной класс системы инвентаря
class InventorySystem {
  // Коллекции для разных типов предметов
  Set<AbstractWeapon> weapons = {};
  Set<AbstractArmor> armors = {};
  Set<SellableItem> miscItems = {};
  
  // Экипированные предметы
  AbstractWeapon? equippedWeapon;
  AbstractArmor? equippedArmor;
  AbstractArmor? equippedShield;
  
  // Максимальная грузоподъемность (в фунтах)
  double maxWeight = 150.0;


  // Получить общий вес инвентаря
  double get totalWeight {
    double weight = 0;
    
    // Вес оружия
    for (var weapon in weapons) {
      weight += _getWeaponWeight(weapon.type);
    }
    
    // Вес брони
    for (var armor in armors) {
      weight += _getArmorWeight(armor.type);
    }
    
    // Вес прочих предметов
    for (var item in miscItems) {
      weight += item.weight * item.qty;
    }
    
    // Вес денег (примерно 50 монет на 1 фунт)
    //weight += (money.totalValue() / 50.0);
    
    return weight;
  }

  // Получить процент загрузки
  double get weightPercentage {
    return (totalWeight / maxWeight).clamp(0.0, 1.0);
  }

  // Проверить, не перегружен ли инвентарь
  bool get isOverloaded {
    return totalWeight > maxWeight;
  }

  // Добавить оружие в инвентарь
  bool addWeapon(AbstractWeapon weapon) {
    if (totalWeight + _getWeaponWeight(weapon.type) > maxWeight) {
      return false; // Перегрузка
    }
    weapons.add(weapon);
    return true;
  }

  // Добавить броню в инвентарь
  bool addArmor(AbstractArmor armor) {
    if (totalWeight + _getArmorWeight(armor.type) > maxWeight) {
      return false; // Перегрузка
    }
    armors.add(armor);
    return true;
  }

  // Добавить прочий предмет в инвентарь
  bool addMiscItem(SellableItem item) {
    if (totalWeight + (item.weight * item.qty) > maxWeight) {
      return false; // Перегрузка
    }
    
    // Проверить, есть ли уже такой предмет (для стакающихся)
   // Проверить, есть ли уже такой предмет (для стакающихся)
SellableItem? existingItem = miscItems.where((i) => i.name == item.name).toList()[0];
if (_isStackable(item)) {
  existingItem.qty += item.qty; // Увеличиваем количество существующего предмета
} else {
  miscItems.add(item); // Добавляем новый предмет
}

return true;
  }

  // Экипировать оружие
  void equipWeapon(AbstractWeapon weapon) {
    if (weapons.contains(weapon)) {
      equippedWeapon = weapon;
    }
  }

  // Экипировать броню
  void equipArmor(AbstractArmor armor) {
    if (armors.contains(armor)) {
      if (armor.type == ArmorType.Shield) {
        equippedShield = armor;
      } else {
        equippedArmor = armor;
      }
    }
  }

  // Снять оружие
  void unequipWeapon() {
    equippedWeapon = null;
  }

  // Снять броню
  void unequipArmor() {
    equippedArmor = null;
  }

  // Снять щит
  void unequipShield() {
    equippedShield = null;
  }

  // Удалить оружие из инвентаря
  bool removeWeapon(AbstractWeapon weapon) {
    if (equippedWeapon == weapon) {
      equippedWeapon = null;
    }
    return weapons.remove(weapon);
  }

  // Удалить броню из инвентаря
  bool removeArmor(AbstractArmor armor) {
    if (equippedArmor == armor) {
      equippedArmor = null;
    }
    if (equippedShield == armor) {
      equippedShield = null;
    }
    return armors.remove(armor);
  }

  // Удалить прочий предмет из инвентаря
  bool removeMiscItem(SellableItem item, {int quantity = 1}) {
    if (miscItems.contains(item)) {
      if (item.qty > quantity && _isStackable(item)) {
        item.qty -= quantity;
      } else {
        miscItems.remove(item);
      }
      return true;
    }
    return false;
  }

  // Получить бонус к КД от экипированной брони
  int get armorClassBonus {
    int ac = 10; // Базовый КД
    
    if (equippedArmor != null) {
      switch (equippedArmor!.type) {
        case ArmorType.LeatherArmor:
          ac = 11;
          break;
        case ArmorType.ChainShirt:
          ac = 13;
          break;
        case ArmorType.ScaleMailArmor:
          ac = 14;
          break;
        case ArmorType.Breastplate:
          ac = 14;
          break;
        case ArmorType.HalfPlateArmor:
          ac = 15;
          break;
        case ArmorType.RingMailArmor:
          ac = 14;
          break;
        case ArmorType.ChainMail:
          ac = 16;
          break;
        case ArmorType.SplintArmor:
          ac = 17;
          break;
        case ArmorType.PlateArmor:
          ac = 18;
          break;
        default:
          ac = 10;
      }
    }
    
    // Бонус от щита
    if (equippedShield != null) {
      ac += 2;
    }
    
    return ac;
  }

  // Поиск предмета по имени
  dynamic findItemByName(String name) {
    // Искать в оружии
    for (var weapon in weapons) {
      if (_getWeaponName(weapon.type).toLowerCase().contains(name.toLowerCase())) {
        return weapon;
      }
    }
    
    // Искать в броне
    for (var armor in armors) {
      if (_getArmorName(armor.type).toLowerCase().contains(name.toLowerCase())) {
        return armor;
      }
    }
    
    // Искать в прочих предметах
    for (var item in miscItems) {
      if (item.name.toLowerCase().contains(name.toLowerCase())) {
        return item;
      }
    }
    
    return null;
  }

  // Получить список всех предметов
  List<dynamic> getAllItems() {
    return [
      ...weapons,
      ...armors,
      ...miscItems,
    ];
  }

  // Очистить инвентарь
  void clear() {
    weapons.clear();
    armors.clear();
    miscItems.clear();
    equippedWeapon = null;
    equippedArmor = null;
    equippedShield = null;
  }

  // Сериализация в Map для сохранения
  Map<String, dynamic> toJson() {
    return {
      'weapons': weapons.map((w) => _weaponToJson(w)).toList(),
      'armors': armors.map((a) => _armorToJson(a)).toList(),
      'miscItems': miscItems.map((i) => _miscItemToJson(i)).toList(),
      'equippedWeapon': equippedWeapon != null ? _weaponToJson(equippedWeapon!) : null,
      'equippedArmor': equippedArmor != null ? _armorToJson(equippedArmor!) : null,
      'equippedShield': equippedShield != null ? _armorToJson(equippedShield!) : null,
      //'money': money.toJson(),
      'maxWeight': maxWeight,
    };
  }

  // Десериализация из Map
  void fromJson(Map<String, dynamic> json) {
    weapons = (json['weapons'] as List).map((w) => _weaponFromJson(w)).toSet();
    armors = (json['armors'] as List).map((a) => _armorFromJson(a)).toSet();
    //miscItems = (json['miscItems'] as List).map((i) => _miscItemFromJson(i)).toSet();
    
    if (json['equippedWeapon'] != null) {
      equippedWeapon = _weaponFromJson(json['equippedWeapon']);
    }
    if (json['equippedArmor'] != null) {
      equippedArmor = _armorFromJson(json['equippedArmor']);
    }
    if (json['equippedShield'] != null) {
      equippedShield = _armorFromJson(json['equippedShield']);
    }
    
    //money.fromJson(json['money']);
    maxWeight = json['maxWeight'] ?? 150.0;
  }

  // Вспомогательные приватные методы

  bool _isStackable(SellableItem item) {
    // Предметы, которые могут стакаться
    const stackableTypes = [
      'Зелье', 'Свиток', 'Стрела', 'Патрон', 'Камни', 'Еда', 'Вода'
    ];
    return stackableTypes.any((type) => item.name.contains(type));
  }

  double _getWeaponWeight(WeaponType? type) {
    switch (type) {
      case WeaponType.Dagger:
        return 1.0;
      case WeaponType.ShortSword:
        return 2.0;
      case WeaponType.LongSword:
        return 3.0;
      case WeaponType.Greatsword:
        return 6.0;
      case WeaponType.ShortBow:
        return 2.0;
      case WeaponType.LongBow:
        return 2.0;
      case WeaponType.LightCrossBow:
        return 5.0;
      case WeaponType.HeavyCrossBow:
        return 18.0;
      case WeaponType.CombatStaff:
        return 4.0;
      case WeaponType.Spear:
        return 3.0;
      default:
        return 2.0;
    }
  }

  double _getArmorWeight(ArmorType? type) {
    switch (type) {
      case ArmorType.LeatherArmor:
        return 10.0;
      case ArmorType.ChainShirt:
        return 20.0;
      case ArmorType.ScaleMailArmor:
        return 45.0;
      case ArmorType.Breastplate:
        return 20.0;
      case ArmorType.HalfPlateArmor:
        return 40.0;
      case ArmorType.RingMailArmor:
        return 40.0;
      case ArmorType.ChainMail:
        return 55.0;
      case ArmorType.SplintArmor:
        return 60.0;
      case ArmorType.PlateArmor:
        return 65.0;
      case ArmorType.Shield:
        return 6.0;
      default:
        return 10.0;
    }
  }

  String _getWeaponName(WeaponType? type) {
    switch (type) {
      case WeaponType.Dagger:
        return "Кинжал";
      case WeaponType.ShortSword:
        return "Короткий меч";
      case WeaponType.LongSword:
        return "Длинный меч";
      case WeaponType.Greatsword:
        return "Двуручный меч";
      case WeaponType.ShortBow:
        return "Короткий лук";
      case WeaponType.LongBow:
        return "Длинный лук";
      case WeaponType.LightCrossBow:
        return "Арбалет легкий";
      case WeaponType.HeavyCrossBow:
        return "Арбалет тяжелый";
      case WeaponType.CombatStaff:
        return "Боевой посох";
      case WeaponType.Spear:
        return "Копье";
      default:
        return "Оружие";
    }
  }

  String _getArmorName(ArmorType? type) {
    switch (type) {
      case ArmorType.LeatherArmor:
        return "Кожаный доспех";
      case ArmorType.ChainShirt:
        return "Кольчуга";
      case ArmorType.ScaleMailArmor:
        return "Чешуйчатый доспех";
      case ArmorType.Breastplate:
        return "Кираса";
      case ArmorType.HalfPlateArmor:
        return "Полулаты";
      case ArmorType.RingMailArmor:
        return "Кольчатый доспех";
      case ArmorType.ChainMail:
        return "Кольчужный доспех";
      case ArmorType.SplintArmor:
        return "Пластинчатый доспех";
      case ArmorType.PlateArmor:
        return "Латный доспех";
      case ArmorType.Shield:
        return "Щит";
      default:
        return "Броня";
    }
  }

  // Методы сериализации
  Map<String, dynamic> _weaponToJson(AbstractWeapon weapon) {
    return {
      'type': weapon.type?.index,
      //'metadata': weapon.metadata.toJson(),
    };
  }

  AbstractWeapon _weaponFromJson(Map<String, dynamic> json) {
    return AbstractWeapon(
      WeaponType.values[json['type']],
      //Meta.fromJson(json['metadata']).MetaFlags_,
    );
  }

  Map<String, dynamic> _armorToJson(AbstractArmor armor) {
    return {
      'type': armor.type?.index,
      //'metadata': armor.metadata.toJson(),
    };
  }

  AbstractArmor _armorFromJson(Map<String, dynamic> json) {
    return AbstractArmor(
      ArmorType.values[json['type']],
      //Meta.fromJson(json['metadata']).MetaFlags_,
    );
  }

  Map<String, dynamic> _miscItemToJson(SellableItem item) {
    return {
      'name': item.name,
      'description': "",
      'weight': item.weight,
      //'price': item.price.toJson(),
      'qty': item.qty,
    };
  }


}

// Расширение для удобной работы с коллекциями
extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

// Класс для создания тестовых предметов
class ItemFactory {

  static AbstractWeapon createWeapon(WeaponType type, [Set<MetaFlags>? metadata]) {
    return AbstractWeapon(type, metadata);
  }

  static AbstractArmor createArmor(ArmorType type, [Set<MetaFlags>? metadata]) {
    return AbstractArmor(type, metadata);
  }

 

  // Создание стандартного набора стартового снаряжения
  static Map<String, dynamic>? createStarterPack(String className) {
    final inventory = InventorySystem();
    
    switch (className.toLowerCase()) {
      case 'воин':
      case 'паладин':
        inventory.addWeapon(createWeapon(WeaponType.LongSword));
        inventory.addArmor(createArmor(ArmorType.ChainMail));
        inventory.addArmor(createArmor(ArmorType.Shield));
        break;
      case 'плут':
      case 'бард':
        inventory.addWeapon(createWeapon(WeaponType.ShortSword));
        inventory.addWeapon(createWeapon(WeaponType.Dagger));
        inventory.addArmor(createArmor(ArmorType.LeatherArmor));
        break;
      case 'следопыт':
        inventory.addWeapon(createWeapon(WeaponType.LongBow));
        inventory.addWeapon(createWeapon(WeaponType.ShortSword));
        inventory.addArmor(createArmor(ArmorType.LeatherArmor));
        break;
      case 'жрец':
        inventory.addWeapon(createWeapon(WeaponType.CombatStaff));
        inventory.addArmor(createArmor(ArmorType.ChainShirt));
        inventory.addArmor(createArmor(ArmorType.Shield));
        break;
      case 'волшебник':
        inventory.addWeapon(createWeapon(WeaponType.CombatStaff));
      default:
      inventory.addWeapon(createWeapon(WeaponType.CombatStaff));
        /*
        inventory.addMiscItem(createMiscItem(
          name: "Магический фокус",
          weight: 0.5,
          price: Price()..gold = 10,
        ));
        break;
      default:
        inventory.addWeapon(createWeapon(WeaponType.ShortSword));
        inventory.addArmor(createArmor(ArmorType.LeatherArmor));
    }
    */
    
    // Добавляем базовые предметы
    /*inventory.addMiscItem(createMiscItem(
      name: "Рюкзак",
      description: "Стандартный рюкзак для хранения вещей",
      weight: 5.0,
      price: Price()..gold = 2,
    ));
    
    inventory.addMiscItem(createMiscItem(
      name: "Торба с припасами",
      description: "Еда и вода на 1 день",
      weight: 2.0,
      price: Price()..gold = 1,
    ));
    */
    
    // Стартовые деньги
    
  return null;
  }
    return null;
  }
}
@HiveType(typeId: 2)
class InventoryView{
List<String> weapons = [];
List<String> armor = [];
List<String> items = [];

String? eq_weapon = "";
String? eq_armor = "";
String? eq_shield = "";

InventoryView();
InventoryView.FromInventory(InventorySystem inventory){
  for(var w in inventory.weapons){
    weapons.add(w.name);
  }

    for(var a in inventory.armors){
    armor.add(a.name);
}
    for(var i in inventory.miscItems){
    items.add(i.name);
}
eq_armor = inventory.equippedArmor?.name;
eq_weapon = inventory.equippedWeapon?.name;
eq_shield = inventory.equippedShield?.name;
}
}
