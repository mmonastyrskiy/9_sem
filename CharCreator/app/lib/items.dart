// ignore_for_file: constant_identifier_names

import 'character.dart';
import 'money.dart';
import 'stat.dart';
import 'spell.dart';
// === ОСНОВНЫЕ ПЕРЕЧИСЛЕНИЯ И ИНТЕРФЕЙСЫ ===
enum ItemRarity {
  Common,
  Uncommon,
  Rare,
  VeryRare,
  Legendary,
  Artifact;
  
  String get displayName => switch (this) {
    Common => "Обычный",
    Uncommon => "Необычный",
    Rare => "Редкий",
    VeryRare => "Очень редкий",
    Legendary => "Легендарный",
    Artifact => "Артефакт",
  };
}

enum ItemType {
  Weapon,
  Armor,
  Shield,
  Potion,
  Scroll,
  Wand,
  Rod,
  Staff,
  Ring,
  Amulet,
  Cloak,
  Boots,
  Gloves,
  Helmet,
  Belt,
  Gem,
  Jewelry,
  Book,
  Tool,
  Kit,
  Instrument,
  GamingSet,
  Container,
  Vehicle,
  Mount,
  Food,
  Drink,
  Clothing,
  Trinket,
  Material,
  Key,
  Other;
  
  String get displayName => switch (this) {
    Weapon => "Оружие",
    Armor => "Броня",
    Shield => "Щит",
    Potion => "Зелье",
    Scroll => "Свиток",
    Wand => "Жезл",
    Rod => "Прут",
    Staff => "Посох",
    Ring => "Кольцо",
    Amulet => "Амулет",
    Cloak => "Плащ",
    Boots => "Ботинки",
    Gloves => "Перчатки",
    Helmet => "Шлем",
    Belt => "Пояс",
    Gem => "Самоцвет",
    Jewelry => "Украшение",
    Book => "Книга",
    Tool => "Инструмент",
    Kit => "Набор",
    Instrument => "Музыкальный инструмент",
    GamingSet => "Игровой набор",
    Container => "Контейнер",
    Vehicle => "Транспорт",
    Mount => "Ездовое животное",
    Food => "Еда",
    Drink => "Напиток",
    Clothing => "Одежда",
    Trinket => "Безделушка",
    Material => "Материал",
    Key => "Ключ",
    Other => "Прочее",
  };
}

enum EquipmentSlot {
  Head,
  Neck,
  Shoulders,
  Chest,
  Back,
  Wrists,
  Hands,
  Waist,
  Feet,
  Finger,
  MainHand,
  OffHand,
  TwoHand,
  Ammunition,
  Tool,
  Mount,
  Vehicle;
  
  String get displayName => switch (this) {
    Head => "Голова",
    Neck => "Шея",
    Shoulders => "Плечи",
    Chest => "Грудь",
    Back => "Спина",
    Wrists => "Запястья",
    Hands => "Руки",
    Waist => "Талия",
    Feet => "Ноги",
    Finger => "Палец",
    MainHand => "Основная рука",
    OffHand => "Вторая рука",
    TwoHand => "Две руки",
    Ammunition => "Боеприпасы",
    Tool => "Инструмент",
    Mount => "Ездовое животное",
    Vehicle => "Транспорт",
  };
}

enum ItemProperty {
  Magical,
  Cursed,
  AttunementRequired,
  Consumable,
  Wondrous,
  Sentient,
  RequiresProficiency,
  TwoHanded,
  Versatile,
  Finesse,
  Thrown,
  Ammunition,
  Loading,
  Heavy,
  Light,
  Reach,
  Special,
  Silvered,
  Adamantine,
  Masterwork;
  
  String get displayName => switch (this) {
    Magical => "Магический",
    Cursed => "Проклятый",
    AttunementRequired => "Требует настройки",
    Consumable => "Расходуемый",
    Wondrous => "Диковинный",
    Sentient => "Разумный",
    RequiresProficiency => "Требует владения",
    TwoHanded => "Двуручное",
    Versatile => "Универсальное",
    Finesse => "Фехтовальное",
    Thrown => "Метательное",
    Ammunition => "Боеприпасы",
    Loading => "Заряжание",
    Heavy => "Тяжелое",
    Light => "Легкое",
    Reach => "Дальнобойное",
    Special => "Особое",
    Silvered => "Серебренное",
    Adamantine => "Адамантиновое",
    Masterwork => "Мастерское",
  };
}

// === БАЗОВЫЙ КЛАСС ПРЕДМЕТА ===

 class Item {
  final String id;
  final String name;
  final String description;
  final ItemRarity rarity;
  final ItemType type;
  final Set<ItemProperty> properties;
  final Set<EquipmentSlot> slots;
  final Price price;
  final double weight;
  final bool requiresAttunement;
  final List<String> tags;
  
  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.rarity,
    required this.type,
    this.properties = const {},
    this.slots = const {},
    required this.price,
    required this.weight,
    this.requiresAttunement = false,
    this.tags = const [],
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() => '$name ($rarity)';
  
  void onUnequip(Character character) {}
  
  bool canEquip(Character character) {return false;}
}

// === ИНТЕРФЕЙСЫ ДЛЯ СПЕЦИАЛИЗИРОВАННЫХ ПРЕДМЕТОВ ===

abstract interface class Equippable {
  bool canEquip(Character character);
  void onEquip(Character character);
  void onUnequip(Character character);
}

abstract interface class Usable {
  bool canUse(Character character);
  void use(Character character);
  int get charges;
  int get maxCharges;
}

abstract interface class Consumable {
  void consume(Character character);
  bool isConsumed();
}

abstract interface class Attunable {
  bool canAttune(Character character);
  void onAttune(Character character);
  void onUnattune(Character character);
}

// === КЛАСС БРОНИ (ПЕРЕРАБОТАННЫЙ) ===

class ArmorItem extends Item implements Equippable {
  final int baseArmorClass;
  final int? maxDexBonus;
  final int? strengthRequirement;
  final bool stealthDisadvantage;
  final int donTimeMinutes; // Время надевания в минутах
  final int doffTimeMinutes; // Время снятия в минутах
  
  ArmorItem({
    required super.id,
    required super.name,
    required super.description,
    required super.rarity,
    required this.baseArmorClass,
    this.maxDexBonus,
    this.strengthRequirement,
    this.stealthDisadvantage = false,
    required this.donTimeMinutes,
    required this.doffTimeMinutes,
    required super.price,
    required super.weight,
    Set<ItemProperty> properties = const {},
    super.requiresAttunement,
    List<String> tags = const [],
  }) : super(
    type: ItemType.Armor,
    properties: {...properties, if (requiresAttunement) ItemProperty.AttunementRequired},
    slots: {EquipmentSlot.Chest},
    tags: [...tags, 'armor'],
  );
  
  int calculateAC(int dexterityModifier) {
    final dexBonus = maxDexBonus != null 
        ? (dexterityModifier > maxDexBonus! ? maxDexBonus! : dexterityModifier)
        : dexterityModifier;
    return baseArmorClass + dexBonus;
  }
  
  @override
  bool canEquip(Character character) {
    // Проверка владения тяжелой броней, силы и т.д.
    if (strengthRequirement != null) {
      return character.getbasicstats()[BasicStatNames.STR]!.value >= strengthRequirement!;
    }
    return true;
  }
  
  @override
  void onEquip(Character character) {
    //character.equipment.equip(this);
    // Можно добавить эффекты при надевании
  }
  
  @override
  void onUnequip(Character character) {
    //character.equipment.unequip(this);
    // Можно добавить эффекты при снятии
  }
}

// === КЛАСС ОРУЖИЯ ===

enum DamageType {
  Bludgeoning,
  Piercing,
  Slashing,
  Fire,
  Cold,
  Lightning,
  Thunder,
  Poison,
  Acid,
  Psychic,
  Necrotic,
  Radiant,
  Force;
  
  String get displayName => switch (this) {
    Bludgeoning => "Дробящий",
    Piercing => "Колющий",
    Slashing => "Рубящий",
    Fire => "Огонь",
    Cold => "Холод",
    Lightning => "Молния",
    Thunder => "Звук",
    Poison => "Яд",
    Acid => "Кислота",
    Psychic => "Психический",
    Necrotic => "Некротический",
    Radiant => "Излучение",
    Force => "Силовой",
  };
}

class WeaponItem extends Item implements Equippable {
  final String damageDice; // Например: "1d6", "2d4"
  final DamageType damageType;
  final Set<String> weaponProperties; // "finesse", "light", "heavy", "two-handed", "versatile"
  final String? versatileDamage; // Урон при использовании двумя руками
  final int normalRange;
  final int longRange;
  
  WeaponItem({
    required super.id,
    required super.name,
    required super.description,
    required super.rarity,
    required this.damageDice,
    required this.damageType,
    this.weaponProperties = const {},
    this.versatileDamage,
    this.normalRange = 5,
    this.longRange = 5,
    required super.price,
    required super.weight,
    Set<ItemProperty> properties = const {},
    super.requiresAttunement,
    List<String> tags = const [],
  }) : super(
    type: ItemType.Weapon,
    properties: {...properties, if (requiresAttunement) ItemProperty.AttunementRequired},
    slots: weaponProperties.contains("two-handed") 
        ? {EquipmentSlot.TwoHand}
        : weaponProperties.contains("versatile")
          ? {EquipmentSlot.MainHand, EquipmentSlot.TwoHand}
          : {EquipmentSlot.MainHand},
    tags: [...tags, 'weapon'],
  );
  
  @override
  bool canEquip(Character character) {
    // Проверка владения оружием по классу/расе
    return true;
  }
  
  @override
  void onEquip(Character character) {
    //character.equipment.equip(this);
  }
  
  @override
  void onUnequip(Character character) {
    //character.equipment.unequip(this);
  }
}

// === КЛАСС МАГИЧЕСКИХ ПРЕДМЕТОВ ===

class MagicalItem extends Item implements Equippable, Usable, Attunable {
  final List<Spell> spells;
  @override
  final int charges;
  @override
  final int maxCharges;
  final int rechargeDice; // 1d4+1 и т.д.
  final bool chargesPerDay;
  
  MagicalItem({
    required super.id,
    required super.name,
    required super.description,
    required super.rarity,
    required super.type,
    required this.spells,
    required this.charges,
    required this.maxCharges,
    required this.rechargeDice,
    this.chargesPerDay = true,
    Set<ItemProperty> properties = const {},
    super.slots,
    required super.price,
    required super.weight,
    super.requiresAttunement = true,
    List<String> tags = const [],
  }) : super(
    properties: {...properties, ItemProperty.Magical, if (requiresAttunement) ItemProperty.AttunementRequired},
    tags: [...tags, 'magic'],
  );
  
  @override
 /* bool canEquip(Character character) {
    return !requiresAttunement || character.canAttuneItem(this);
  }
  */
  @override
  void onEquip(Character character) {
    //character.equipment.equip(this);
  }
  
  @override
  void onUnequip(Character character) {
    //character.equipment.unequip(this);
    if (requiresAttunement) {
      onUnattune(character);
    }
  }
  /*
  @override
  bool canUse(Character character) {
    return charges > 0 && 
           (character.equipment.isEquipped(this) || !requiresAttunement);
  }
  */
  @override
  void use(Character character) {
    if (charges > 0) {
      // Использование предмета
      // charges--;
    }
  }
  
  @override
  bool canAttune(Character character) {
    // TODO: implement canAttune
    throw UnimplementedError();
  }
  
  @override
  bool canEquip(Character character) {
    // TODO: implement canEquip
    throw UnimplementedError();
  }
  
  @override
  bool canUse(Character character) {
    // TODO: implement canUse
    throw UnimplementedError();
  }
  
  @override
  void onAttune(Character character) {
    // TODO: implement onAttune
  }
  
  @override
  void onUnattune(Character character) {
    // TODO: implement onUnattune
  }
  
 /* @override
  bool canAttune(Character character) {
    return character.getAttunedItems().length < 3; // Максимум 3 настроенных предмета
  }
  
  @override
  void onAttune(Character character) {
    character.attuneItem(this);
  }
  
  @override
  void onUnattune(Character character) {
    character.unattuneItem(this);
  }
  */
}


// === ЕДИНЫЙ КЛАСС ДЛЯ ВСЕХ ПРЕДМЕТОВ (АНАЛОГ Spells) ===

class Items {
  // === БРОНЯ ===
  static final Item paddedArmor = ArmorItem(
    id: 'padded_armor',
    name: 'Стеганый доспех',
    description: 'Простой доспех из стеганой ткани',
    rarity: ItemRarity.Common,
    baseArmorClass: 11,
    maxDexBonus: null,
    stealthDisadvantage: true,
    donTimeMinutes: 1,
    doffTimeMinutes: 1,
    price: Price(gold: 5),
    weight: 8.0,
    tags: ['light', 'armor'],
  );
  
  static final Item leatherArmor = ArmorItem(
    id: 'leather_armor',
    name: 'Кожаный доспех',
    description: 'Доспех из твердой, дубленой кожи',
    rarity: ItemRarity.Common,
    baseArmorClass: 11,
    maxDexBonus: null,
    stealthDisadvantage: false,
    donTimeMinutes: 1,
    doffTimeMinutes: 1,
    price: Price(gold: 10),
    weight: 10.0,
    tags: ['light', 'armor'],
  );
  
  static final Item chainMail = ArmorItem(
    id: 'chain_mail',
    name: 'Кольчуга',
    description: 'Тяжелая броня из металлических колец',
    rarity: ItemRarity.Common,
    baseArmorClass: 16,
    maxDexBonus: null,
    strengthRequirement: 13,
    stealthDisadvantage: true,
    donTimeMinutes: 10,
    doffTimeMinutes: 5,
    price: Price(gold: 75),
    weight: 55.0,
    tags: ['heavy', 'armor'],
  );
  
  static final Item plateArmor = ArmorItem(
    id: 'plate_armor',
    name: 'Латный доспех',
    description: 'Полный комплект металлических лат',
    rarity: ItemRarity.Common,
    baseArmorClass: 18,
    maxDexBonus: null,
    strengthRequirement: 15,
    stealthDisadvantage: true,
    donTimeMinutes: 10,
    doffTimeMinutes: 5,
    price: Price(gold: 1500),
    weight: 65.0,
    tags: ['heavy', 'armor'],
  );
  
  static final Item shield = Item(
    id: 'shield',
    name: 'Щит',
    description: 'Деревянный или металлический щит',
    rarity: ItemRarity.Common,
    type: ItemType.Shield,
    slots: {EquipmentSlot.OffHand},
    price: Price(gold: 10),
    weight: 6.0,
    tags: ['shield'],
  );
  
  // === ОРУЖИЕ ===
  static final Item dagger = WeaponItem(
    id: 'dagger',
    name: 'Кинжал',
    description: 'Короткое колющее оружие',
    rarity: ItemRarity.Common,
    damageDice: '1d4',
    damageType: DamageType.Piercing,
    weaponProperties: {'finesse', 'light', 'thrown'},
    normalRange: 20,
    longRange: 60,
    price: Price(gold: 2),
    weight: 1.0,
    tags: ['simple', 'melee', 'ranged'],
  );
  
  static final Item longsword = WeaponItem(
    id: 'longsword',
    name: 'Длинный меч',
    description: 'Одноручный или двуручный меч',
    rarity: ItemRarity.Common,
    damageDice: '1d8',
    damageType: DamageType.Slashing,
    weaponProperties: {'versatile'},
    versatileDamage: '1d10',
    price: Price(gold: 15),
    weight: 3.0,
    tags: ['martial', 'melee'],
  );
  
  static final Item greatsword = WeaponItem(
    id: 'greatsword',
    name: 'Двуручный меч',
    description: 'Большой тяжелый меч для двух рук',
    rarity: ItemRarity.Common,
    damageDice: '2d6',
    damageType: DamageType.Slashing,
    weaponProperties: {'heavy', 'two-handed'},
    price: Price(gold: 50),
    weight: 7.0,
    tags: ['martial', 'melee'],
  );
  
  static final Item longbow = WeaponItem(
    id: 'longbow',
    name: 'Длинный лук',
    description: 'Дальнобойное оружие',
    rarity: ItemRarity.Common,
    damageDice: '1d8',
    damageType: DamageType.Piercing,
    weaponProperties: {'heavy', 'two-handed', 'ammunition'},
    normalRange: 150,
    longRange: 600,
    price: Price(gold: 50),
    weight: 2.0,
    tags: ['martial', 'ranged'],
  );
  
  // === МАГИЧЕСКИЕ ПРЕДМЕТЫ ===
  static final Item potionOfHealing = MagicalItem(
    id: 'potion_of_healing',
    name: 'Зелье лечения',
    description: 'Восстанавливает 2d4+2 хитов',
    rarity: ItemRarity.Common,
    type: ItemType.Potion,
    spells: [Spells.cureWounds],
    charges: 1,
    maxCharges: 1,
    rechargeDice: 0,
    chargesPerDay: false,
    properties: {ItemProperty.Consumable},
    slots: {},
    price: Price(gold: 50),
    weight: 0.5,
    requiresAttunement: false,
    tags: ['potion', 'healing', 'consumable'],
  );
  
  static final Item cloakOfProtection = MagicalItem(
    id: 'cloak_of_protection',
    name: 'Плащ защиты',
    description: 'Дает +1 к КД и спасброскам',
    rarity: ItemRarity.Uncommon,
    type: ItemType.Cloak,
    spells: [],
    charges: 0,
    maxCharges: 0,
    rechargeDice: 0,
    properties: {},
    slots: {EquipmentSlot.Back},
    price: Price(gold: 500),
    weight: 0.5,
    requiresAttunement: true,
    tags: ['wondrous', 'defense'],
  );
  
  // === СПИСОК ВСЕХ ПРЕДМЕТОВ ===
  static final List<Item> all = [
    // Броня
    paddedArmor,
    leatherArmor,
    chainMail,
    plateArmor,
    shield,
    
    // Оружие
    dagger,
    longsword,
    greatsword,
    longbow,
    
    // Магические предметы
    potionOfHealing,
    cloakOfProtection,
  ];
  
  // === МЕТОДЫ ДЛЯ ФИЛЬТРАЦИИ ===
  
  static Item? getById(String id) {
    try {
      return all.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
  
  static Item? getByName(String name) {
    try {
      return all.firstWhere((item) => item.name == name);
    } catch (e) {
      return null;
    }
  }
  
  static List<Item> getByType(ItemType type) {
    return all.where((item) => item.type == type).toList();
  }
  
  static List<Item> getByRarity(ItemRarity rarity) {
    return all.where((item) => item.rarity == rarity).toList();
  }
  
  static List<Item> getBySlot(EquipmentSlot slot) {
    return all.where((item) => item.slots.contains(slot)).toList();
  }
  
  static List<Item> filterByProperties(Set<ItemProperty> properties) {
    return all.where((item) => item.properties.containsAll(properties)).toList();
  }
  
  static List<Item> search(String query) {
    final lowerQuery = query.toLowerCase();
    return all.where((item) =>
      item.name.toLowerCase().contains(lowerQuery) ||
      item.description.toLowerCase().contains(lowerQuery) ||
      item.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))
    ).toList();
  }
  
  // === УДОБНЫЕ ГЕТТЕРЫ ===
  
  static List<Item> get armor => getByType(ItemType.Armor);
  static List<Item> get weapons => getByType(ItemType.Weapon);
  static List<Item> get magicalItems => all.where((item) => 
      item.properties.contains(ItemProperty.Magical)).toList();
  static List<Item> get consumables => all.where((item) =>
      item.properties.contains(ItemProperty.Consumable)).toList();
  static List<Item> get commonItems => getByRarity(ItemRarity.Common);
  static List<Item> get uncommonItems => getByRarity(ItemRarity.Uncommon);
  static List<Item> get rareItems => getByRarity(ItemRarity.Rare);
}

// === КЛАСС ДЛЯ РАБОТЫ С ЭКИПИРОВКОЙ ПЕРСОНАЖА ===

class CharacterEquipment {
  final Character character;
  final Map<EquipmentSlot, Item?> equippedItems = {};
  final List<Item> inventory = [];
  final List<Item> attunedItems = [];
  
  CharacterEquipment(this.character);
  
  void equip(Item item) {
    if (item is Equippable && item.canEquip(character)) {
      for (final slot in item.slots) {
        // Проверяем, можно ли экипировать в этот слот
        if (!canEquipInSlot(slot, item)) {
          throw Exception('Нельзя экипировать $item в слот $slot');
        }
      }
      
      // Снимаем предметы из занятых слотов
      for (final slot in item.slots) {
        final currentItem = equippedItems[slot];
        if (currentItem != null) {
          unequip(currentItem);
        }
        equippedItems[slot] = item;
      }
      
      // Вызываем метод onEquip
      (item as Equippable).onEquip(character);
    }
  }
  
  void unequip(Item item) {
    if (isEquipped(item)) {
      for (final slot in item.slots) {
        if (equippedItems[slot] == item) {
          equippedItems.remove(slot);
        }
      }
      
      if (item is Equippable) {
        item.onUnequip(character);
      }
    }
  }
  
  bool isEquipped(Item item) {
    return equippedItems.values.any((equipped) => equipped == item);
  }
  
  bool canEquipInSlot(EquipmentSlot slot, Item newItem) {
    final currentItem = equippedItems[slot];
    
    // Проверяем ограничения по слотам
    if (slot == EquipmentSlot.Finger && 
        getItemsInSlot(EquipmentSlot.Finger).length >= 2) {
      return false;
    }
    
    // Проверяем совместимость предметов
    if (currentItem != null && 
        (newItem.type == ItemType.Shield || currentItem.type == ItemType.Shield) &&
        (newItem.type == ItemType.Weapon || currentItem.type == ItemType.Weapon) &&
        slot == EquipmentSlot.OffHand) {
      // Щит можно носить только с одноручным оружием
      final weapon = newItem.type == ItemType.Weapon ? newItem : currentItem;
      if (weapon is WeaponItem && 
          weapon.weaponProperties.contains('two-handed')) {
        return false;
      }
    }
    
    return true;
  }
  
  List<Item> getItemsInSlot(EquipmentSlot slot) {
    return equippedItems.entries
        .where((entry) => entry.key == slot && entry.value != null)
        .map((entry) => entry.value!)
        .toList();
  }
  
  int calculateTotalWeight() {
    final equippedWeight = equippedItems.values
        .whereType<Item>()
        .fold(0.0, (sum, item) => sum + item.weight);
    
    final inventoryWeight = inventory.fold(0.0, (sum, item) => sum + item.weight);
    
    return (equippedWeight + inventoryWeight).toInt();
  }
}