// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

// Импорт необходимых модулей
import 'package:app/meta.dart';
import 'tool.dart';
import 'stat.dart';
import 'character.dart';
import 'trait.dart';
import 'langs.dart';
import 'items.dart';

// Перечисление названий рас в игре
enum RaceName {
  Gnome,        // Гном
  Dwarf,        // Дварф
  Halfing,      // Полурослик 
  HalfElf,      // Полуэльф
  Elf,          // Эльф
  Human,        // Человек
  Tiefling      // Тифлинг
}

// Перечисление подрас в игре
enum SubRaces {
  ForestGnome,    // Лесной гном
  RockGnome,      // Скальный гном
  MountainDwarf,  // Горный дварф
  HillDwarf,       // Холмовой дварф
  StockyHalfling,      // Коренастый полурослик
  LighFootedHalfling,        // легконогий полурослик

}

// Абстрактный интерфейс для рас, реализующий AffectsStatRace
// Определяет общую структуру для всех рас в игре
abstract interface class Race implements AffectsStatRace {
  // Набор черт (особенностей), которые предоставляет раса
  Set<Trait> traits = {};
  
  // Список возможных мировоззрений для этой расы
  List<MindSets> PossibleMindset = [];

  // Фабричный конструктор для создания объектов рас по названию
  // Аргументы: chosen - название расы, c - объект персонажа
  factory Race(String chosen, Character c) {
    // Получаем базовые характеристики персонажа
    Map<BasicStatNames, BasicStat> stats = c.getbasicstats();
    // Получаем размер персонажа
    Size? size = c.size;
    // Получаем скорость персонажа
    int? speed = c.speed;
    // Получаем языки персонажа
    Set<Langs> langs = c.getLangs();
    // Получаем инструменты персонажа
    Set<ToolSkill> tools = c.getToolingskills();
    // Получаем доступные типы брони
    Set<Armor> CanUseArmor = c.CanUseArmor;
    // Получаем здоровье персонажа
    Health health = c.health;

    // Создаем конкретную расу based на переданном названии
    switch(chosen) {
      case 'лесной гном': return ForestGnome(stats, size, speed, langs, tools, CanUseArmor, health);
      default: throw ArgumentError("Not implemented Race"); // TODO: добавить другие расы
    }
  }
}

// Абстрактный класс для расы Гномов
abstract class Gnome implements Race {
   @override
  List<MindSets> PossibleMindset = [MindSets.ALL];
  // Базовый класс для всех подрас гномов
  // Определяет общие характеристики для гномов
}

// Абстрактный класс для расы Дварфов
abstract class Dwarf implements Race {
   @override
  List<MindSets> PossibleMindset = [MindSets.ALL];
  // Базовый класс для всех подрас дварфов
  // Определяет общие характеристики для дварфов
}
abstract class Halfing implements Race{
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];
  // Базовый класс для всех подрас полуросликов
  // Определяет общие характеристики для полуросликов
}

// Конкретный класс для Лесного Гнома
final class ForestGnome extends Gnome {
  // Список возможных мировоззрений - ВСЕ (неограниченный выбор)

  
  // Набор черт лесного гнома
  @override
  Set<Trait> traits = {};
  
  // Конструктор лесного гнома - автоматически применяет расовые бонусы
  ForestGnome(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  // Применяет расовые бонусы лесного гнома к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    // Бонус к интеллекту +2 с меткой от расы
    stats[BasicStatNames.INT]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к ловкости +1 с меткой от расы
    stats[BasicStatNames.DEX]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    // Устанавливаем маленький размер
    size = Size.SMALL;
    // Устанавливаем скорость 25 футов
    speed = 25;
    // Добавляем черту "Темное зрение"
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    // Добавляем черту "Гномья смекалка"
    traits.add(Trait(TraitNames.GnomesCunning, {MetaFlags.AFFECTED_BY_RACE}));
    // Добавляем общий язык
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    // Добавляем гномий язык
    langs.add(Langs('гномий', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Добавляем черту "Общение с мелкими животными"
    traits.add(Trait(TraitNames.CommunicationWithSmallAnimals, {MetaFlags.AFFECTED_BY_RACE}));
  }

  // Удаляет расовые бонусы лесного гнома у персонажа
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor, Health health) {
    // Удаляем бонусы к характеристикам по метке расы
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер
    size = null;
    // Сбрасываем скорость
    speed = null;
    // Удаляем все черты с меткой расы
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    // Удаляем все языки с меткой расы
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }
}

// Конкретный класс для Скального Гнома
final class RockGnome extends Gnome {

  @override
  Set<Trait> traits = {};
  
  // Конструктор скального гнома
  RockGnome(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  // Применяет расовые бонусы скального гнома к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor, Health health) {
    // Бонус к интеллекту +2
    stats[BasicStatNames.INT]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к телосложению +1
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    // Маленький размер
    size = Size.SMALL;
    // Скорость 25 футов
    speed = 25;
    // Темное зрение
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    // Гномья смекалка
    traits.add(Trait(TraitNames.GnomesCunning, {MetaFlags.AFFECTED_BY_RACE}));
    // Общий язык
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    // Гномий язык
    langs.add(Langs('гномий', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Знание ремесел
    traits.add(Trait(TraitNames.CraftKnowledge, {MetaFlags.AFFECTED_BY_RACE}));
    // Изобретательство
    traits.add(Trait(TraitNames.Tinker, {MetaFlags.AFFECTED_BY_RACE}));
    // Инструменты ремесленников
    tools.add(ToolSkill("инструменты ремесленников", {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  }

  // Удаляет расовые бонусы скального гнома
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    // Удаляем бонусы к характеристикам
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер и скорость
    size = null;
    speed = null;
    // Удаляем черты, языки и инструменты с меткой расы
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
  }
}

// Конкретный класс для Горного Дварфа
final class MountainDwarf extends Dwarf {

  @override
  Set<Trait> traits = {};

  // Конструктор горного дварфа
  MountainDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  // Применяет расовые бонусы горного дварфа к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    // Бонус к телосложению +2
    stats[BasicStatNames.CON]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к силе +1
    stats[BasicStatNames.STR]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    // Средний размер
    size = Size.MEDIUM;
    // Скорость 25 футов (несмотря на броню)
    speed = 25;
    // Темное зрение
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    // Боевая подготовка дварфов
    traits.add(Trait(TraitNames.DwarvenCombatTraining, {MetaFlags.AFFECTED_BY_RACE}));
    // Стойкость дварфов
    traits.add(Trait(TraitNames.DwarvenResilience, {MetaFlags.AFFECTED_BY_RACE}));
    // Инструменты ремесленников
    tools.add(ToolSkill("инструменты ремесленников", {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Общий язык
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    // Дварфийский язык (опечатка: должно быть 'дварфийский')
    langs.add(Langs('дварфийский', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Доступ к легкой и средней броне
    canUseArmor.add(Armor(ArmorType.Light, {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium, {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
  }

  // Удаляет расовые бонусы горного дварфа
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    // Удаляем бонусы к характеристикам
    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер и скорость
    size = null;
    speed = null;
    // Удаляем черты, инструменты, языки и броню с меткой расы
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    Armor.deletebyMeta(canUseArmor, MetaFlags.AFFECTED_BY_RACE);
  }
}

// Конкретный класс для Холмового Дварфа
final class HillDwarf extends Dwarf {
 
  @override
  Set<Trait> traits = {};

  // Конструктор холмового дварфа
  HillDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  // Применяет расовые бонусы холмового дварфа к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor, Health health) {
    // Бонус к телосложению +2
    stats[BasicStatNames.CON]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к мудрости +1
    stats[BasicStatNames.WIS]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    // Средний размер
    size = Size.MEDIUM;
    // Скорость 25 футов
    speed = 25;
    // Темное зрение
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    // Боевая подготовка дварфов
    traits.add(Trait(TraitNames.DwarvenCombatTraining, {MetaFlags.AFFECTED_BY_RACE}));
    // Стойкость дварфов
    traits.add(Trait(TraitNames.DwarvenResilience, {MetaFlags.AFFECTED_BY_RACE}));
    // Инструменты ремесленников
    tools.add(ToolSkill("инструменты ремесленников", {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Общий язык
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    // Дварфийский язык (опечатка: должно быть 'дварфийский')
    langs.add(Langs('дварфийскмй', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    // Дварфская выучка
    traits.add(Trait(TraitNames.DwarvenLodge, {MetaFlags.AFFECTED_BY_RACE}));
    // Бонус к здоровью
    health.update(1, {MetaFlags.AFFECTED_BY_RACE});
  }

  // Удаляет расовые бонусы холмового дварфа
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor, Health health) {
    // Удаляем бонусы к характеристикам
    stats[BasicStatNames.WIS]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Удаляем бонус к здоровью
    health.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер и скорость
    size = null;
    speed = null;
    // Удаляем черты, инструменты и языки с меткой расы
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }
}
final class StockyHalfling extends Halfing{
  @override
  Set<Trait> traits={};

StockyHalfling(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health) {
    stats[BasicStatNames.DEX]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
        size = Size.SMALL;
    // Скорость 25 футов
    speed = 25;
     
     traits.add(Trait(TraitNames.Lucky, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.Brave, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.AgilityOfHalflings, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.StabilityOfStocky, {MetaFlags.AFFECTED_BY_RACE}));

      langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('полуросликов', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size=null;
    speed=null;

    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

}


final class LighFootedHalfling extends Halfing{
  @override
  Set<Trait> traits={};

LighFootedHalfling(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor, Health health) {
    apply(stats, size, speed, langs, tools, canUseArmor, health);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health) {
    stats[BasicStatNames.CHR]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
        size = Size.SMALL;
    // Скорость 25 футов
    speed = 25;
     
     traits.add(Trait(TraitNames.Lucky, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.Brave, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.AgilityOfHalflings, {MetaFlags.AFFECTED_BY_RACE}));
     traits.add(Trait(TraitNames.NaturalStealth, {MetaFlags.AFFECTED_BY_RACE}));

      langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('полуросликов', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size=null;
    speed=null;

    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

}