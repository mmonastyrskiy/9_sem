// ignore_for_file: non_constant_identifier_names, collection_methods_unrelated_type

// Импорт необходимых модулей и библиотек
import 'meta.dart';
import 'stat.dart';
import 'dice.dart';
import 'character.dart';
import 'items.dart';
import 'tool.dart';
import 'package:flutter/material.dart';

// ignore_for_file: constant_identifier_names

// Перечисление названий классов персонажей на английском
enum CharClassNames {
  Bard,
  Barbarian,
  Fighter,
  Wizzard,
  Druid,
  Clerc,
  Artifier,
  Warlock,
  Monk,
  Paladin,
  Rouge,
  Ranger,
  Sorcerer
}

// Абстрактный интерфейс для классов персонажей, реализующий AffectsStatClass
// Использует фабричный конструктор для создания конкретных классов
abstract interface class CharClass implements AffectsStatClass {
  String classname="";
  // Фабричный конструктор для создания объектов классов по названию
  // Аргументы: chosen - название класса, c - объект персонажа
  factory CharClass(String chosen, Character c) {
    // Получаем здоровье персонажа
    Health charHeath = c.health;
    // Получаем доступные типы брони
    Set<Armor> CanUseArmor = c.CanUseArmor;
    // Получаем доступные типы оружия
    Set<Weapon> canUseWeapon = c.canUseWeapon;
    // Получаем контекст UI
    BuildContext context = c.UIContext;
    // Получаем навыки персонажа
    Map<StatNames, Skill> skills = c.getskills();
    // Получаем инструменты персонажа
    Set<ToolSkill> tools = c.getToolingskills();
    // Получаем базовые характеристики
    Map<BasicStatNames, BasicStat> stats = c.getbasicstats();
    
    // Создаем конкретный класс based на переданном названии
    switch (chosen.toLowerCase()) { 
      case 'бард': return Bard(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'варвар': return Barbarian(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'воин': return Fighter(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'волшебник': return Wizzard(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'друид': return Druid(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'жрец': return Clerc(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'изобретатель': return Artifier(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'колдун': return Warlock(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'монах': return Monk(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'паладин': return Paladin(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'плут': return Rouge(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'следопыт': return Ranger(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
      case 'чародей': return Sorcerer(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);

      // Если класс не найден, выбрасываем исключение
      default: return Undefined(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
    }
  }
}
final class Undefined implements CharClass{
  @override
  String classname= " Не выбрано";

  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
  }

  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
  }

 Undefined(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }


}
// Класс "Бард"
final class Bard implements CharClass {
  // Конструктор - автоматически применяет бонусы класса при создании
  Bard(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stat, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    // Устанавливаем тип кости хитов для Барда - D8
    charHeath.HitDice = DiceType.D8;

    // Добавляем легкую броню в доступные типы
    CanUseArmor.add(Armor(ArmorType.Light, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем простое оружие в доступные типы
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем короткий меч в доступные типы
    canUseWeapon.add(Weapon(WeaponType.ShortSword, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем длинный меч в доступные типы
    canUseWeapon.add(Weapon(WeaponType.LongSword, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем рапиру в доступные типы
    canUseWeapon.add(Weapon(WeaponType.Rapier, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем ручной арбалет в доступные типы
    canUseWeapon.add(Weapon(WeaponType.HandCrossBow, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем музыкальные инструменты в доступные инструменты
    tools.add(ToolSkill("музыкальные инструменты", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    
    // Получаем модификатор телосложения
    int CONmodifier = stat[BasicStatNames.CON]!.mod;
    // Устанавливаем максимальное здоровье как результат броска + модификатор телосложения
    charHeath.max_health = 8 + CONmodifier;
    // Устанавливаем текущее здоровье равным максимальному
    charHeath.current_health = charHeath.max_health;

    // Устанавливаем бонус спасброска для ловкости
    stat[BasicStatNames.DEX]!.savingthrow = 1;
    // Устанавливаем бонус спасброска для харизмы
    stat[BasicStatNames.CHR]!.savingthrow = 1;
    
    // Позволяем игроку выбрать 3 навыка через UI
    Set<String>? choise = await Skill('').pickmany(context, null, 3);
    // Обрабатываем выбранные навыки
    for (String s in choise) {
      // Преобразуем строку в enum навыка
      Skills skilltoadd = Skill.string2skill()[s]!;
      // Добавляем метку выбора на классе к навыку
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      // Добавляем общую метку выбора к навыку
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      // Увеличиваем бонус владения навыком
      skills[skilltoadd]!.hasprofbounus += 1;
    }
  }

  @override
  void delete(Health charHeath, stat, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    // Сбрасываем кость хитов
    charHeath.HitDice = null;
    // Сбрасываем максимальное здоровье
    charHeath.max_health = 0;
    // Сбрасываем текущее здоровье
    charHeath.current_health = 0;
    // Удаляем всю броню, помеченную как выбранная на классе
    Armor.deletebyMeta(CanUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    // Удаляем все оружие, помеченное как выбранное на классе
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    // Удаляем все инструменты, помеченные как выбранные на классе
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);
    // Сбрасываем бонус спасброска для ловкости
    stat[BasicStatNames.DEX]!.savingthrow = 0;
    // Сбрасываем бонус спасброска для харизмы
    stat[BasicStatNames.CHR]!.savingthrow = 0;
    // Удаляем все навыки, помеченные как выбранные на классе
    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Бард";
}

// Класс "Варвар"
final class Barbarian implements CharClass {
  // Конструктор
  Barbarian(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    // Устанавливаем кость хитов D12 для Варвара (самая большая)
    charHeath.HitDice = DiceType.D12;
    // Создаем объект для бросков

    // Получаем модификатор телосложения
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    // Устанавливаем максимальное здоровье
    charHeath.max_health = 12 + CONmodifier;
    // Устанавливаем текущее здоровье
    charHeath.current_health = charHeath.max_health;

    // Добавляем легкую броню
    canUseArmor.add(Armor(ArmorType.Light, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем среднюю броню
    canUseArmor.add(Armor(ArmorType.Medium, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем щиты
    canUseArmor.add(Armor(ArmorType.Shield, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем простое оружие
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем воинское оружие
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));

    // Устанавливаем бонус спасброска для силы
    stats[BasicStatNames.STR]!.savingthrow = 1;
    // Устанавливаем бонус спасброска для телосложения
    stats[BasicStatNames.CON]!.savingthrow = 1;

    // Позволяем выбрать навыки из ограниченного списка
    Set<String>? choise = await Skill('').pickmany(context, null, null, {Skills.Athletics, Skills.Perception, Skills.Survival, Skills.Intimidation, Skills.Animal_Handling});
    // Обрабатываем выбранные навыки
    for (String s in choise) {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus += 1;
    }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    // Сбрасываем кость хитов
    charHeath.HitDice = null;
    // Сбрасываем максимальное здоровье
    charHeath.max_health = 0;
    // Сбрасываем текущее здоровье
    charHeath.current_health = 0;
    // Удаляем броню класса
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    // Удаляем оружие класса
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    // Сбрасываем бонусы спасбросков
    stats[BasicStatNames.STR]!.savingthrow = 0;
    stats[BasicStatNames.CON]!.savingthrow = 0;
    // Удаляем навыки класса
    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Варвар";
}

// Класс "Воин"
final class Fighter implements CharClass {
  // Конструктор
  Fighter(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    // Устанавливаем кость хитов D10 для Воина
    charHeath.HitDice = DiceType.D10;

    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 10 + CONmodifier;
    charHeath.current_health = charHeath.max_health;

    // Добавляем все типы брони (легкую, среднюю, тяжелую и щиты)
    canUseArmor.add(Armor(ArmorType.Light, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Heavy, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    // Добавляем все типы оружия (простое и воинское)
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    
    // Устанавливаем бонусы спасбросков
    stats[BasicStatNames.STR]!.savingthrow = 1;
    stats[BasicStatNames.CON]!.savingthrow = 1;

    // Позволяем выбрать навыки из широкого списка боевых и тактических навыков
    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Acrobatics, Skills.Athletics, Skills.Perception, Skills.Survival, Skills.Intimidation, Skills.History, Skills.Insight, Skills.Animal_Handling});
    
    // Обрабатываем выбранные навыки
    for (String s in choise) {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus += 1;
    }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    // Сбрасываем здоровье
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    // Удаляем броню и оружие класса
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    // Удаляем навыки класса
    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
    // Сбрасываем бонусы спасбросков
    stats[BasicStatNames.STR]!.savingthrow = 0;
    stats[BasicStatNames.CON]!.savingthrow = 0;
  }

  @override
  String classname="Воин";
}

// Класс "Волшебник" (остальные классы имеют аналогичную структуру)
final class Wizzard implements CharClass {
  Wizzard(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    // У Волшебника самая маленькая кость хитов - D6
    charHeath.HitDice = DiceType.D6;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 6 + CONmodifier;
    charHeath.current_health = charHeath.max_health;

    // Волшебник может использовать только простое оружие
    canUseWeapon.add(Weapon(WeaponType.Dagger, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sling, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.CombatStaff, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LightCrossBow, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));

    // Бонусы спасбросков для интеллекта и мудрости
    stats[BasicStatNames.INT]!.savingthrow = 1;
    stats[BasicStatNames.WIS]!.savingthrow = 1;

    // Навыки связанные с знаниями и магией
    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.History, Skills.Arcana, Skills.Medicine, Skills.Perception, Skills.Investigation, Skills.Religion});
    
    for (String s in choise) {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus += 1;
    }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    // Удаляем оружие класса
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);

    // Сбрасываем бонусы спасбросков
    stats[BasicStatNames.INT]!.savingthrow = 0;
    stats[BasicStatNames.WIS]!.savingthrow = 0;

    // Удаляем навыки класса
    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Волшебник";
}

// Остальные классы (Druid, Clerc, Artifier, Warlock, Monk, Paladin, Rouge, Ranger, Sorcerer)
// имеют аналогичную структуру с различными комбинациями:
// - Кости хитов (D6, D8, D10, D12)
// - Доступные типы брони и оружия
// - Бонусы спасбросков
// - Навыки для выбора
// - Инструменты

// Класс "Друид"
final class Druid implements CharClass {
  Druid(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    apply(charHeath, stats, skills, CanUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D8;

    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 + CONmodifier;
    charHeath.current_health = charHeath.max_health;

    // Друид может использовать легкую, среднюю броню и щиты (но не металлические)
    canUseArmor.add(Armor(ArmorType.Light, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));

    // Характерное для друида оружие
    canUseWeapon.add(Weapon(WeaponType.CombatStaff, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Mace, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Club, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Javeline, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Scimitar, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sickle, {MetaFlags.IS_PICKED_ON_CLASS, MetaFlags.IS_PICKED}));

    // Набор травника - характерный инструмент друида
    tools.add(ToolSkill("набор травника", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.INT]!.savingthrow = 1;
    stats[BasicStatNames.WIS]!.savingthrow = 1;

    // Навыки связанные с природой и выживанием
    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Perception, Skills.Survival, Skills.Arcana, Skills.Medicine, Skills.Animal_Handling, Skills.Nature, Skills.Insight, Skills.Religion});
    
    for (String s in choise) {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus += 1;
    }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.INT]!.savingthrow = 0;
    stats[BasicStatNames.WIS]!.savingthrow = 0;

    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Друиид";
}

final class Clerc implements CharClass{
  Clerc(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    
    charHeath.HitDice = DiceType.D8;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    stats[BasicStatNames.CHR]!.savingthrow=1;
    stats[BasicStatNames.WIS]!.savingthrow=1;

    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.History,Skills.Medicine,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }

  
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.CHR]!.savingthrow=0;
    stats[BasicStatNames.WIS]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Жрец";
    
  }

  final class Artifier implements CharClass{
  Artifier(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D8;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    tools.add(ToolSkill("инструменты ремонтника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    tools.add(ToolSkill("инструменты ремесленника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.CON]!.savingthrow=1;
    stats[BasicStatNames.INT]!.savingthrow=1;


  
    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Perception,Skills.History,Skills.Sleight_of_Hand,Skills.Arcana,Skills.Medicine,Skills.Nature,Skills.Investigation});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;


    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);

  }

  @override
  String classname="Изобретатель";
  
}
final class Warlock implements CharClass{
  Warlock(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D8;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 +CONmodifier;
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.WIS]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;


    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Intimidation,Skills.History,Skills.Arcana,Skills.Deception,Skills.Nature,Skills.Investigation,Skills.Religion});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }

  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
     charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Колдун";
}
final class Monk implements CharClass{
  Monk(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D8;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 +CONmodifier;
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));


    String? chosen =ToolSkill('').pick(context,{ToolsNames.Artisans_Tools,ToolsNames.Musical_Instruments});
    tools.add(ToolSkill(chosen!,{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.STR]!.savingthrow=1;
    stats[BasicStatNames.DEX]!.savingthrow=1;

    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Acrobatics,Skills.Athletics,Skills.History,Skills.Insight,Skills.Religion,Skills.Stealth});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }

  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.STR]!.savingthrow=0;
    stats[BasicStatNames.DEX]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);

  }

  @override
  String classname="Монах";

  
}

final class Paladin implements CharClass{
  Paladin(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D10;

    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 10 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Heavy,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));



    stats[BasicStatNames.WIS]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;


    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Athletics,Skills.Intimidation,Skills.Medicine,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.WIS]!.savingthrow=0;
    stats[BasicStatNames.CHR]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Паладин";
}

final class Rouge implements CharClass{
  Rouge(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D8;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 8 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.HandCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LongSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Rapier,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
  
  stats[BasicStatNames.DEX]!.savingthrow=1;
  stats[BasicStatNames.INT]!.savingthrow=1;


    Set<String>? choise = await Skill('').pickmany(context, null, 4,
    {Skills.Athletics,Skills.Acrobatics,Skills.Perception,Skills.Performance,Skills.Intimidation,
    Skills.Sleight_of_Hand,Skills.Deception,Skills.Insight,Skills.Investigation,Skills.Stealth,Skills.Persuasion});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.DEX]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Плут";

}

final class Ranger implements CharClass{
  Ranger(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D10;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 10 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;


    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.DEX]!.savingthrow=1;
    stats[BasicStatNames.STR]!.savingthrow=1;


    Set<String>? choise = await Skill('').pickmany(context, null, 3,
    {Skills.Athletics,Skills.Perception,Skills.Survival,Skills.Nature,Skills.
    Insight,Skills.Investigation,Skills.Stealth,Skills.Animal_Handling});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
    
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.DEX]!.savingthrow=0;
    stats[BasicStatNames.STR]!.savingthrow=0;

     Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Следопыт";
  
}

final class Sorcerer implements CharClass{
  Sorcerer(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) async {
    charHeath.HitDice = DiceType.D6;
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = 6 +CONmodifier; 
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.CombatStaff,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dagger,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LightCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sling,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.CON]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;

    Set<String>? choise = await Skill('').pickmany(context, null, null,
    {Skills.Intimidation,Skills.Arcana,Skills.Deception,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.CHR]!.savingthrow=0;

    Skill.deletebyMeta(skills,MetaFlags.IS_PICKED_ON_CLASS);
  }

  @override
  String classname="Чародей";
}
