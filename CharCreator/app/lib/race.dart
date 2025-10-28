// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

// Импорт необходимых модулей
import 'meta.dart';
import 'package:flutter/material.dart';
import 'tool.dart';
import 'stat.dart';
import 'character.dart';
import 'trait.dart';
import 'langs.dart';
import 'items/weapon.dart';
import 'items/armor.dart';
import 'items/item.dart';

// Перечисление названий рас в игре
enum RaceName {
  Gnome,        // Гном
  Dwarf,        // Дварф
  Dragonborn,    // Драконорожденный
  HalfOrc,       // Полуорк
  Halfing,      // Полурослик
  HalfElf,      // Полуэльф
  Elf,          // Эльф
  Tiefling,      // Тифлинг
  Human          // Человек
}

// Перечисление подрас в игре
enum SubRaces {
  ForestGnome,    // Лесной гном
  RockGnome,      // Скальный гном
  MountainDwarf,  // Горный дварф
  HillDwarf,       // Холмовой дварф
  StockyHalfling,      // Коренастый полурослик
  LighFootedHalfling,        // легконогий полурослик
  HighElf,                   // Высший эльф
  ForestElf                   // лесной эльф 

}

// Абстрактный интерфейс для рас, реализующий AffectsStatRace
// Определяет общую структуру для всех рас в игре
abstract interface class Race implements AffectsStatRace {
  String racename = "";
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
    Set<AbstractArmor> CanUseArmor = c.CanUseArmor;
    // Получаем здоровье персонажа
    Health health = c.health;
    Map<StatNames, Skill> skills = c.getskills();
    BuildContext context = c.UIContext;
    Set<AbstractWeapon> canUseWeapon = c.canUseWeapon;

    // Создаем конкретную расу based на переданном названии
    switch(chosen.toLowerCase()) {
      case 'лесной гном': return ForestGnome(stats, size, speed, langs, tools, CanUseArmor, health,skills,context,canUseWeapon);
      case 'скальный гном':return RockGnome(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'горный дварф':return MountainDwarf(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'холмовой дварф':return HillDwarf(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'коренастый полурослик': return StockyHalfling(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'легконогий полурослик':return LighFootedHalfling(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'высший эльф':return HighElf(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'лесной эльф': return ForestElf(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'драконорожденный':return Dragonborn(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'полуорк':return HalfOrc(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'полуэльф':return HalfElf(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'тифлинг':return Tiefling(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      case 'человек':return Human(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
      default: return Undefined(stats, size, speed, langs, tools, CanUseArmor, health, skills, context, canUseWeapon);
  }
  }
}


final class Undefined implements Race {

  Undefined(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }
  
  @override
  List<MindSets> PossibleMindset=[MindSets.ALL];

  @override
  String racename="Не определено";

  @override
  Set<Trait> traits={};

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, BuildContext context, Set<AbstractWeapon> canUseWeapon) {
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, Set<AbstractWeapon> canUseWeapon) {

  }
}


final class Tiefling implements Race {
  Tiefling(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }
  
  @override
  List<MindSets> PossibleMindset=[MindSets.ALL];
  
  @override
  Set<Trait> traits={};
  
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, BuildContext context,Set<AbstractWeapon> canUseWeapon) {
     // Бонус к силе +2 с меткой от расы
    stats[BasicStatNames.CHR]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к харизме +1 с меткой от расы
    stats[BasicStatNames.INT]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    speed = 30;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.HellishResistance, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DevilsLegacy, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('инфернальный', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  }
  
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename = "Тифлинг";
}


final class Human implements Race{
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];

  @override
  Set<Trait> traits={};


  Human(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.STR]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.DEX]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.INT]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.WIS]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.CHR]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    speed = 30;
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE});
    langs.add(ch);



  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.WIS]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    speed = null;
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);


  }

  @override
  String racename="Человек";

}

abstract class Elf implements Race {
  @override
  List<MindSets> PossibleMindset= [MindSets.ALL];

}

final class Dragonborn implements Race {

  Dragonborn(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];

  @override
  Set<Trait> traits={};

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
   // Бонус к силе +2 с меткой от расы
    stats[BasicStatNames.STR]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к харизме +1 с меткой от расы
    stats[BasicStatNames.CHR]?.update(1, {MetaFlags.AFFECTED_BY_RACE});

    size = Size.MEDIUM;
    speed = 30;
    traits.add(Trait(TraitNames.LegacyOfDragons, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.BreathWeapon, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.BreathWeapon, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.ChosenDamageResistance, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('драконий', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
   Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер
    size = null;
    // Сбрасываем скорость
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="Драконорожденный";

}


final class HalfElf implements Race{
  @override
  List<MindSets> PossibleMindset=[MindSets.ALL];

  @override
  Set<Trait> traits={};


  HalfElf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  Future<void> apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) async {
    stats[BasicStatNames.STR]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.FaerieLegacy, {MetaFlags.AFFECTED_BY_RACE}));
    Set<String>? chosen = await BasicStat().pickmany(context);
    for(String s in chosen){
      BasicStatNames? t = BasicStat.str2BasicStat()[s];
      stats[t]?.update(1, {MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_RACE});
    }
    size = Size.MEDIUM;
    speed = 30;
    // ignore: use_build_context_synchronously
    Set<String>? choise = Skill('').pickmany(context, null, null, {Skills.Athletics, Skills.Perception, Skills.Survival, Skills.Intimidation, Skills.Animal_Handling}) as Set<String>?;
    // Обрабатываем выбранные навыки
    for (String s in choise!) {
      Skills skilltoadd = Skill.string2skill()[s]!;
      StatNames? SN2add = Skill.S2SN()[skilltoadd];
      skills[SN2add]!.addMeta(MetaFlags.IS_PICKED_ON_RACE);
      skills[SN2add]!.addMeta(MetaFlags.IS_PICKED); 
      skills[SN2add]!.hasprofbounus += 1;
      // ignore: use_build_context_synchronously
      Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE});
    langs.add(ch);
    langs.add(Langs('общий',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    langs.add(Langs('эльфийский',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    }
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    size = null;
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    Skill.deletebyMeta(skills, MetaFlags.AFFECTED_BY_RACE);


    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.WIS]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="Полуэльф";

}


final class HalfOrc implements Race {

  HalfOrc(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];

  @override
  Set<Trait> traits={};

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill>skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
   // Бонус к силе +2 с меткой от расы
    stats[BasicStatNames.STR]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    // Бонус к харизме +1 с меткой от расы
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});

    size = Size.MEDIUM;
    speed = 30;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.MenacingLook, {MetaFlags.AFFECTED_BY_RACE}));
    skills[StatNames.Intimidation]?.hasprofbounus +=1;
    skills[StatNames.Intimidation]?.metadata.MetaFlags_.add(MetaFlags.AFFECTED_BY_RACE);
    traits.add(Trait(TraitNames.UnwaveringResilience, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.FerociousAttacks, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('орочий', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health,skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер
    size = null;
    // Сбрасываем скорость
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    Skill.deletebyMeta(skills, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="Полуорк";

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
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  // Применяет расовые бонусы лесного гнома к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    // Удаляем бонусы к характеристикам по метке расы
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    // Сбрасываем размер
    size = null;
    // Сбрасываем скорость
    speed = null;
    // Удаляем все черты с меткой расы
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    // Удаляем все языки с меткой расы
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="лесной гном";
}

// Конкретный класс для Скального Гнома
final class RockGnome extends Gnome {

  @override
  Set<Trait> traits = {};
  
  // Конструктор скального гнома
  RockGnome(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  // Применяет расовые бонусы скального гнома к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
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

  @override
  String racename="Скальный гном";
}

// Конкретный класс для Горного Дварфа
final class MountainDwarf extends Dwarf {

  @override
  Set<Trait> traits = {};

  // Конструктор горного дварфа
  MountainDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  // Применяет расовые бонусы горного дварфа к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
    canUseArmor.add(AbstractArmor(ArmorType.Light, {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    canUseArmor.add(AbstractArmor(ArmorType.Medium, {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
  }

  // Удаляет расовые бонусы горного дварфа
  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
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
    AbstractArmor.deletebyMeta(canUseArmor, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="Горный дварф";
}

// Конкретный класс для Холмового Дварфа
final class HillDwarf extends Dwarf {
 
  @override
  Set<Trait> traits = {};

  // Конструктор холмового дварфа
  HillDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  // Применяет расовые бонусы холмового дварфа к персонажу
  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
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

  @override
  String racename="Холмовой дварф";
}
final class StockyHalfling extends Halfing{
  @override
  Set<Trait> traits={};

StockyHalfling(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
   Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
   Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size=null;
    speed=null;

    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename="Коренастый полурослик";

}


final class LighFootedHalfling extends Halfing{
  @override
  Set<Trait> traits={};

LighFootedHalfling(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
   Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
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
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CHR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size=null;
    speed=null;

    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename = "Легконогий полурослик";

}
final class HighElf extends Elf{

  HighElf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  Set<Trait> traits={};

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.INT]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    // Скорость 25 футов
    speed = 30;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.HeightenedSenses, {MetaFlags.AFFECTED_BY_RACE}));
    skills[StatNames.Insight]?.hasprofbounus +=1;
    skills[StatNames.Insight]?.metadata.MetaFlags_.add(MetaFlags.AFFECTED_BY_RACE);
    traits.add(Trait(TraitNames.FaerieLegacy, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.Trance, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('эльфийский', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    //TODO: магия 
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE});
    langs.add(ch);
    canUseWeapon.add(AbstractWeapon(WeaponType.LongSword,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.ShortBow,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.LongBow,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));

  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    // Скорость 25 футов
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Skill.deletebyMeta(skills, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    AbstractWeapon.deletebyMeta(canUseWeapon, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename = "Высший эльф";

}



final class ForestElf extends Elf{

  ForestElf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<AbstractArmor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    apply(stats, size, speed, langs, tools, canUseArmor, health,skills,context,canUseWeapon);
  }

  @override
  Set<Trait> traits={};

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills, BuildContext context,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.WIS]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    // Скорость 25 футов
    speed = 35;
    traits.add(Trait(TraitNames.FastFeet, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.CamouflageInTheWilderness, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.HeightenedSenses, {MetaFlags.AFFECTED_BY_RACE}));
    skills[StatNames.Insight]?.hasprofbounus +=1;
    skills[StatNames.Insight]?.metadata.MetaFlags_.add(MetaFlags.AFFECTED_BY_RACE);
    traits.add(Trait(TraitNames.FaerieLegacy, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.Trance, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий', {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    langs.add(Langs('эльфийский', {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.LongSword,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.ShortBow,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));
    canUseWeapon.add(AbstractWeapon(WeaponType.LongBow,{MetaFlags.IS_PICKED_ON_RACE,MetaFlags.AFFECTED_BY_RACE}));

  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<AbstractArmor> canUseArmor, Health health, Map<StatNames, Skill> skills,Set<AbstractWeapon> canUseWeapon) {
    stats[BasicStatNames.DEX]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.WIS]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    // Скорость 25 футов
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Skill.deletebyMeta(skills, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    AbstractWeapon.deletebyMeta(canUseWeapon, MetaFlags.AFFECTED_BY_RACE);
  }

  @override
  String racename = "Лесной эльф";

}