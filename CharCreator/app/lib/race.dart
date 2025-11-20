// ignore_for_file: non_constant_identifier_names, constant_identifier_names

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

enum RaceName {
  Gnome, Dwarf, Dragonborn, HalfOrc, Halfing, HalfElf, Elf, Tiefling, Human,
  ForestGnome, RockGnome, MountainDwarf, HillDwarf, StockyHalfling, 
  LighFootedHalfling, HighElf, ForestElf
}

enum SubRaces {
  ForestGnome, RockGnome, MountainDwarf, HillDwarf, StockyHalfling,
  LighFootedHalfling, HighElf, ForestElf
}

// Конфигурация для рас
class RaceConfig {
  final String name;
  final Map<BasicStatNames, int> statBonuses;
  final Size size;
  final int speed;
  final Set<TraitNames> traits;
  final Set<String> languages;
  final Set<String> tools;
  final Set<ArmorType> armorProficiencies;
  final Set<WeaponType> weaponProficiencies;
  final int extraLanguageChoices;
  final int extraSkillChoices;
  final Set<Skills> availableSkills;
  final int extraStatChoices;

  const RaceConfig({
    required this.name,
    required this.statBonuses,
    required this.size,
    required this.speed,
    required this.traits,
    required this.languages,
    this.tools = const {},
    this.armorProficiencies = const {},
    this.weaponProficiencies = const {},
    this.extraLanguageChoices = 0,
    this.extraSkillChoices = 0,
    this.availableSkills = const {},
    this.extraStatChoices = 0,
  });
}

// Базовый класс для всех рас
abstract base class BaseRace implements Race {
  final RaceConfig config;

  @override
  String get racename => config.name;

  @override
  final List<MindSets> PossibleMindset = [MindSets.ALL];

  @override
  Set<Trait> traits = {};

  BaseRace(this.config);

  @override
  Future<void> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) async {
    // Применяем бонусы к характеристикам
    for (final entry in config.statBonuses.entries) {
      stats[entry.key]?.update(entry.value, {MetaFlags.AFFECTED_BY_RACE});
    }

    // Устанавливаем размер и скорость
    size = config.size;
    speed = config.speed;

    // Добавляем черты
    for (final traitName in config.traits) {
      traits.add(Trait(traitName, {MetaFlags.AFFECTED_BY_RACE}));
    }

    // Добавляем языки
    for (final language in config.languages) {
      langs.add(Langs(language, {MetaFlags.AFFECTED_BY_RACE, MetaFlags.IS_PICKED}));
    }

    // Добавляем инструменты
    for (final tool in config.tools) {
      tools.add(ToolSkill(tool, {MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    }

    // Добавляем владение броней
    for (final armorType in config.armorProficiencies) {
      canUseArmor.add(AbstractArmor(armorType, {
        MetaFlags.AFFECTED_BY_RACE,
        MetaFlags.IS_PICKED
      }));
    }

    // Добавляем владение оружием
    for (final weaponType in config.weaponProficiencies) {
      canUseWeapon.add(AbstractWeapon(weaponType, {
        MetaFlags.IS_PICKED_ON_RACE,
        MetaFlags.AFFECTED_BY_RACE
      }));
    }

    // Дополнительные выборы
    await _handleExtraChoices(stats, langs, skills, context);
  }

  Future<void> _handleExtraChoices(
    Map<BasicStatNames, BasicStat> stats,
    Set<Langs> langs,
    Map<StatNames, Skill> skills,
    BuildContext context,
  ) async {
    // Дополнительные языки
    if (config.extraLanguageChoices > 0) {
      await _addExtraLanguages(langs, context, config.extraLanguageChoices);
    }

    // Дополнительные навыки
    if (config.extraSkillChoices > 0) {
      await _addExtraSkills(skills, context, config.extraSkillChoices);
    }

    // Дополнительные характеристики
    if (config.extraStatChoices > 0) {
      await _addExtraStats(stats, context, config.extraStatChoices);
    }
  }

  Future<void> _addExtraLanguages(
    Set<Langs> langs,
    BuildContext context,
    int count,
  ) async {
    for (int i = 0; i < count; i++) {
      final chosen = Langs('').pick(context);
      if (chosen != null) {
        langs.add(Langs(chosen, {
          MetaFlags.IS_PICKED,
          MetaFlags.IS_PICKED_ON_RACE,
          MetaFlags.AFFECTED_BY_RACE
        }));
      }
    }
  }

  Future<void> _addExtraSkills(
    Map<StatNames, Skill> skills,
    BuildContext context,
    int count,
  ) async {
    final choices = await Skill('').pickmany(
      context,
      null,
      count,
      config.availableSkills,
    );

    for (final choice in choices) {
      final skillToAdd = Skill.string2skill()[choice]!;
      final statName = Skill.S2SN()[skillToAdd];
      skills[statName]!
        ..addMeta(MetaFlags.IS_PICKED_ON_RACE)
        ..addMeta(MetaFlags.IS_PICKED)
        ..addMeta(MetaFlags.AFFECTED_BY_RACE)
        ..hasprofbounus += 1;
    }
  }

  Future<void> _addExtraStats(
    Map<BasicStatNames, BasicStat> stats,
    BuildContext context,
    int count,
  ) async {
    final choices = await BasicStat().pickmany(context);
    for (final choice in choices.take(count)) {
      final statName = BasicStat.str2BasicStat()[choice];
      if (statName != null) {
        stats[statName]?.update(1, {
          MetaFlags.AFFECTED_BY_RACE,
          MetaFlags.IS_PICKED,
          MetaFlags.IS_PICKED_ON_RACE
        });
      }
    }
  }

  @override
  void delete(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    Set<AbstractWeapon> canUseWeapon,
  ) {
    // Удаляем бонусы характеристик
    for (final statName in config.statBonuses.keys) {
      stats[statName]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    }

    // Сбрасываем размер и скорость
    size = null;
    speed = null;

    // Удаляем черты, языки, инструменты, броню, оружие
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
    AbstractArmor.deletebyMeta(canUseArmor, MetaFlags.AFFECTED_BY_RACE);
    AbstractWeapon.deletebyMeta(canUseWeapon, MetaFlags.AFFECTED_BY_RACE);
    Skill.deletebyMeta(skills, MetaFlags.AFFECTED_BY_RACE);
  }
}

// Абстрактный интерфейс для рас
abstract interface class Race implements AffectsStatRace {
  String get racename;
  List<MindSets> get PossibleMindset;
  Set<Trait> get traits;
  
  factory Race(String chosen, Character c) {
    final constructor = _raceConstructors[chosen.toLowerCase()];
    if (constructor != null) {
      return constructor(
        c.getbasicstats(),
        c.size,
        c.speed,
        c.getLangs(),
        c.getToolingskills(),
        c.CanUseArmor,
        c.health,
        c.getskills(),
        c.UIContext,
        c.canUseWeapon,
      );
    }
    return Undefined(
      c.getbasicstats(),
      c.size,
      c.speed,
      c.getLangs(),
      c.getToolingskills(),
      c.CanUseArmor,
      c.health,
      c.getskills(),
      c.UIContext,
      c.canUseWeapon,
    );
  }
  
  static final _raceConstructors = <String, Race Function(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  )>{
    'лесной гном': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      ForestGnome(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'скальный гном': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      RockGnome(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'горный дварф': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      MountainDwarf(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'холмовой дварф': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      HillDwarf(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'коренастый полурослик': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      StockyHalfling(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'легконогий полурослик': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      LighFootedHalfling(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'высший эльф': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      HighElf(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'лесной эльф': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      ForestElf(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'драконорожденный': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      Dragonborn(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'полуорк': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      HalfOrc(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'полуэльф': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      HalfElf(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'тифлинг': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      Tiefling(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
    'человек': (stats, size, speed, langs, tools, armor, health, skills, context, weapons) => 
      Human(stats, size, speed, langs, tools, armor, health, skills, context, weapons),
  };
}

// Конфигурации для всех рас
class RaceConfigs {
  // Гномы
  static const forestGnome = RaceConfig(
    name: "Лесной гном",
    statBonuses: {BasicStatNames.INT: 2, BasicStatNames.DEX: 1},
    size: Size.SMALL,
    speed: 25,
    traits: {
      TraitNames.DarkVision,
      TraitNames.GnomesCunning,
      TraitNames.CommunicationWithSmallAnimals,
    },
    languages: {"общий", "гномий"},
  );

  static const rockGnome = RaceConfig(
    name: "Скальный гном",
    statBonuses: {BasicStatNames.INT: 2, BasicStatNames.CON: 1},
    size: Size.SMALL,
    speed: 25,
    traits: {
      TraitNames.DarkVision,
      TraitNames.GnomesCunning,
      TraitNames.CraftKnowledge,
      TraitNames.Tinker,
    },
    languages: {"общий", "гномий"},
    tools: {"инструменты ремесленников"},
  );

  // Дварфы
  static const mountainDwarf = RaceConfig(
    name: "Горный дварф",
    statBonuses: {BasicStatNames.CON: 2, BasicStatNames.STR: 1},
    size: Size.MEDIUM,
    speed: 25,
    traits: {
      TraitNames.DarkVision,
      TraitNames.DwarvenCombatTraining,
      TraitNames.DwarvenResilience,
    },
    languages: {"общий", "дварфийский"},
    tools: {"инструменты ремесленников"},
    armorProficiencies: {ArmorType.Light, ArmorType.Medium},
  );

  static const hillDwarf = RaceConfig(
    name: "Холмовой дварф",
    statBonuses: {BasicStatNames.CON: 2, BasicStatNames.WIS: 1},
    size: Size.MEDIUM,
    speed: 25,
    traits: {
      TraitNames.DarkVision,
      TraitNames.DwarvenCombatTraining,
      TraitNames.DwarvenResilience,
      TraitNames.DwarvenLodge,
    },
    languages: {"общий", "дварфийский"},
    tools: {"инструменты ремесленников"},
  );

  // Полурослики
  static const stockyHalfling = RaceConfig(
    name: "Коренастый полурослик",
    statBonuses: {BasicStatNames.DEX: 2, BasicStatNames.CON: 1},
    size: Size.SMALL,
    speed: 25,
    traits: {
      TraitNames.Lucky,
      TraitNames.Brave,
      TraitNames.AgilityOfHalflings,
      TraitNames.StabilityOfStocky,
    },
    languages: {"общий", "полуросликов"},
  );

  static const lighFootedHalfling = RaceConfig(
    name: "Легконогий полурослик",
    statBonuses: {BasicStatNames.DEX: 2, BasicStatNames.CHR: 1},
    size: Size.SMALL,
    speed: 25,
    traits: {
      TraitNames.Lucky,
      TraitNames.Brave,
      TraitNames.AgilityOfHalflings,
      TraitNames.NaturalStealth,
    },
    languages: {"общий", "полуросликов"},
  );

  // Эльфы
  static const highElf = RaceConfig(
    name: "Высший эльф",
    statBonuses: {BasicStatNames.DEX: 2, BasicStatNames.INT: 1},
    size: Size.MEDIUM,
    speed: 30,
    traits: {
      TraitNames.DarkVision,
      TraitNames.HeightenedSenses,
      TraitNames.FaerieLegacy,
      TraitNames.Trance,
    },
    languages: {"общий", "эльфийский"},
    weaponProficiencies: {
      WeaponType.LongSword,
      WeaponType.ShortSword,
      WeaponType.ShortBow,
      WeaponType.LongBow,
    },
    extraLanguageChoices: 1,
  );

  static const forestElf = RaceConfig(
    name: "Лесной эльф",
    statBonuses: {BasicStatNames.DEX: 2, BasicStatNames.WIS: 1},
    size: Size.MEDIUM,
    speed: 35,
    traits: {
      TraitNames.FastFeet,
      TraitNames.CamouflageInTheWilderness,
      TraitNames.DarkVision,
      TraitNames.HeightenedSenses,
      TraitNames.FaerieLegacy,
      TraitNames.Trance,
    },
    languages: {"общий", "эльфийский"},
    weaponProficiencies: {
      WeaponType.LongSword,
      WeaponType.ShortSword,
      WeaponType.ShortBow,
      WeaponType.LongBow,
    },
  );

  // Другие расы
  static const dragonborn = RaceConfig(
    name: "Драконорожденный",
    statBonuses: {BasicStatNames.STR: 2, BasicStatNames.CHR: 1},
    size: Size.MEDIUM,
    speed: 30,
    traits: {
      TraitNames.LegacyOfDragons,
      TraitNames.BreathWeapon,
      TraitNames.ChosenDamageResistance,
    },
    languages: {"общий", "драконий"},
  );

  static const halfOrc = RaceConfig(
    name: "Полуорк",
    statBonuses: {BasicStatNames.STR: 2, BasicStatNames.CON: 1},
    size: Size.MEDIUM,
    speed: 30,
    traits: {
      TraitNames.DarkVision,
      TraitNames.MenacingLook,
      TraitNames.UnwaveringResilience,
      TraitNames.FerociousAttacks,
    },
    languages: {"общий", "орочий"},
  );

  static const halfElf = RaceConfig(
    name: "Полуэльф",
    statBonuses: {BasicStatNames.STR: 2},
    size: Size.MEDIUM,
    speed: 30,
    traits: {
      TraitNames.DarkVision,
      TraitNames.FaerieLegacy,
    },
    languages: {"общий", "эльфийский"},
    extraStatChoices: 2,
    extraSkillChoices: 2,
    availableSkills: {
      Skills.Athletics,
      Skills.Perception,
      Skills.Survival,
      Skills.Intimidation,
      Skills.Animal_Handling,
    },
  );

  static const tiefling = RaceConfig(
    name: "Тифлинг",
    statBonuses: {BasicStatNames.CHR: 2, BasicStatNames.INT: 1},
    size: Size.MEDIUM,
    speed: 30,
    traits: {
      TraitNames.DarkVision,
      TraitNames.HellishResistance,
      TraitNames.DevilsLegacy,
    },
    languages: {"общий", "инфернальный"},
  );

  static const human = RaceConfig(
    name: "Человек",
    statBonuses: {
      BasicStatNames.STR: 1,
      BasicStatNames.DEX: 1,
      BasicStatNames.CON: 1,
      BasicStatNames.INT: 1,
      BasicStatNames.WIS: 1,
      BasicStatNames.CHR: 1,
    },
    size: Size.MEDIUM,
    speed: 30,
    traits: {},
    languages: {"общий"},
    extraLanguageChoices: 1,
  );
}

// Класс для неопределенной расы
final class Undefined extends BaseRace {
  Undefined(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(const RaceConfig(
    name: "Не определено",
    statBonuses: {},
    size: Size.MEDIUM,
    speed: 30,
    traits: {},
    languages: {},
  )) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }

  @override
  Future<void> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) async {
    // Не применяем никаких изменений
  }
}

// Конкретные классы рас
final class ForestGnome extends BaseRace {
  ForestGnome(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.forestGnome) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class RockGnome extends BaseRace {
  RockGnome(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.rockGnome) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class MountainDwarf extends BaseRace {
  MountainDwarf(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.mountainDwarf) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class HillDwarf extends BaseRace {
  HillDwarf(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.hillDwarf) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class StockyHalfling extends BaseRace {
  StockyHalfling(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.stockyHalfling) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class LighFootedHalfling extends BaseRace {
  LighFootedHalfling(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.lighFootedHalfling) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class HighElf extends BaseRace {
  HighElf(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.highElf) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class ForestElf extends BaseRace {
  ForestElf(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.forestElf) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class Dragonborn extends BaseRace {
  Dragonborn(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.dragonborn) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class HalfOrc extends BaseRace {
  HalfOrc(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.halfOrc) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class HalfElf extends BaseRace {
  HalfElf(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.halfElf) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class Tiefling extends BaseRace {
  Tiefling(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.tiefling) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}

final class Human extends BaseRace {
  Human(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    BuildContext context,
    Set<AbstractWeapon> canUseWeapon,
  ) : super(RaceConfigs.human) {
    apply(stats, size, speed, langs, tools, canUseArmor, health, skills, context, canUseWeapon);
  }
}