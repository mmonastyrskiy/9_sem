// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'meta.dart';
import 'tool.dart';
import 'stat.dart';
import 'character.dart';
import 'trait.dart';
import 'langs.dart';
import 'items/weapon.dart';
import 'items/armor.dart';
import 'items/item.dart';
import 'ui/modal_service.dart';

enum RaceName {
  Gnome, Dwarf, Dragonborn, HalfOrc, Halfing, HalfElf, Elf, Tiefling, Human,
  ForestGnome, RockGnome, MountainDwarf, HillDwarf, StockyHalfling, 
  LighFootedHalfling, HighElf, ForestElf
}

enum SubRaces {
  ForestGnome, RockGnome, MountainDwarf, HillDwarf, StockyHalfling,
  LighFootedHalfling, HighElf, ForestElf
}

// Результат применения расы
class RaceApplicationResult {
  final Set<String> selectedLanguages;
  final Set<String> selectedSkills;
  final Set<String> selectedStats;

  RaceApplicationResult({
    required this.selectedLanguages,
    required this.selectedSkills,
    required this.selectedStats,
  });
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
  final List<MindSets> possibleMindset = [MindSets.ALL];

  @override
  Set<Trait> traits = {};

  BaseRace(this.config);

  @override
  Future<RaceApplicationResult> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    ModalService modalService,
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
      langs.add(Langs(language,{
        MetaFlags.AFFECTED_BY_RACE,
        MetaFlags.IS_PICKED
      },modalService));
    }

    // Добавляем инструменты
    for (final tool in config.tools) {
      tools.add(ToolSkill(tool, modalService, {
        MetaFlags.IS_PICKED,
        MetaFlags.AFFECTED_BY_RACE
      }));
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
    final result = await _handleExtraChoices(
      stats, langs, skills, modalService
    );

    return result;
  }

  Future<RaceApplicationResult> _handleExtraChoices(
    Map<BasicStatNames, BasicStat> stats,
    Set<Langs> langs,
    Map<StatNames, Skill> skills,
    ModalService modalService,
  ) async {
    final selectedLanguages = <String>{};
    final selectedSkills = <String>{};
    final selectedStats = <String>{};

    // Дополнительные языки
    if (config.extraLanguageChoices > 0) {
      selectedLanguages.addAll(
        await _addExtraLanguages(langs, modalService, config.extraLanguageChoices)
      );
    }

    // Дополнительные навыки
    if (config.extraSkillChoices > 0) {
      selectedSkills.addAll(
        await _addExtraSkills(skills, modalService, config.extraSkillChoices)
      );
    }

    // Дополнительные характеристики
    if (config.extraStatChoices > 0) {
      selectedStats.addAll(
        await _addExtraStats(stats, modalService, config.extraStatChoices)
      );
    }

    return RaceApplicationResult(
      selectedLanguages: selectedLanguages,
      selectedSkills: selectedSkills,
      selectedStats: selectedStats,
    );
  }

  Future<Set<String>> _addExtraLanguages(
    Set<Langs> langs,
    ModalService modalService,
    int count,
  ) async {
    final selectedLanguages = <String>{};
    
    final availableLanguages = {
      "общий", "дварфийский", "эльфийский", "великаний", "гномий",
      "гоблинский", "полуросликов", "орочий", "бездны", "небесный",
      "драконий", "глубинная речь", "инферальный", "первичный", "силван", "подземный"
    };

    final chosen = await modalService.showMultiSelectListPicker(
      items: availableLanguages,
      initialSelections: null,
    );

    for (final language in chosen.take(count)) {
      langs.add(Langs(language, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_RACE,
        MetaFlags.AFFECTED_BY_RACE
      }, modalService));
      selectedLanguages.add(language);
    }

    return selectedLanguages;
  }

  Future<Set<String>> _addExtraSkills(
    Map<StatNames, Skill> skills,
    ModalService modalService,
    int count,
  ) async {
    final selectedSkills = <String>{};
    
    final skillNames = config.availableSkills.map((skill) => skill.displayName).toSet();
    final choices = await modalService.showMultiSelectListPicker(
      items: skillNames,
      initialSelections: null,
    );

    for (final choice in choices.take(count)) {
      final skillToAdd = Skills.values.firstWhere(
        (skill) => skill.displayName == choice,
        orElse: () => Skills.Acrobatics
      );
      final statName = skillToAdd.toStatName;
      skills[statName]!
        ..addMeta(MetaFlags.IS_PICKED_ON_RACE)
        ..addMeta(MetaFlags.IS_PICKED)
        ..addMeta(MetaFlags.AFFECTED_BY_RACE)
        ..hasprofbounus += 1;
      selectedSkills.add(choice);
    }

    return selectedSkills;
  }

  Future<Set<String>> _addExtraStats(
    Map<BasicStatNames, BasicStat> stats,
    ModalService modalService,
    int count,
  ) async {
    final selectedStats = <String>{};
    
    final statChoices = await BasicStat().pickmany(modalService);
    for (final choice in statChoices.take(count)) {
      final statName = BasicStat.str2BasicStat()[choice];
      if (statName != null) {
        stats[statName]?.update(1, {
          MetaFlags.AFFECTED_BY_RACE,
          MetaFlags.IS_PICKED,
          MetaFlags.IS_PICKED_ON_RACE
        });
        selectedStats.add(choice);
      }
    }

    return selectedStats;
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
  List<MindSets> get possibleMindset;
  Set<Trait> get traits;
  
  factory Race.create(String raceName, Character character) {
    final constructor = _raceConstructors[raceName.toLowerCase()];
    if (constructor != null) {
      return constructor(character);
    }
    return Undefined(character);
  }
  
  static final _raceConstructors = <String, Race Function(Character character)>{
    'лесной гном': (character) => ForestGnome(character),
    'скальный гном': (character) => RockGnome(character),
    'горный дварф': (character) => MountainDwarf(character),
    'холмовой дварф': (character) => HillDwarf(character),
    'коренастый полурослик': (character) => StockyHalfling(character),
    'легконогий полурослик': (character) => LighFootedHalfling(character),
    'высший эльф': (character) => HighElf(character),
    'лесной эльф': (character) => ForestElf(character),
    'драконорожденный': (character) => Dragonborn(character),
    'полуорк': (character) => HalfOrc(character),
    'полуэльф': (character) => HalfElf(character),
    'тифлинг': (character) => Tiefling(character),
    'человек': (character) => Human(character),
  };

  static Set<String> get availableRaces => _raceConstructors.keys.toSet();

  @override
  Future<RaceApplicationResult> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    ModalService modalService,
    Set<AbstractWeapon> canUseWeapon,
  );

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
  );
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
    statBonuses: {BasicStatNames.CHR: 2},
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

// Базовый конструктор для всех рас
base class CharacterRace extends BaseRace {
  CharacterRace(super.config);
}

// Класс для неопределенной расы
final class Undefined extends CharacterRace {
  Undefined(Character character) : super(const RaceConfig(
    name: "Не определено",
    statBonuses: {},
    size: Size.MEDIUM,
    speed: 30,
    traits: {},
    languages: {},
  ));

  @override
  Future<RaceApplicationResult> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    ModalService modalService,
    Set<AbstractWeapon> canUseWeapon,
  ) async {
    // Не применяем никаких изменений
    return RaceApplicationResult(
      selectedLanguages: {},
      selectedSkills: {},
      selectedStats: {},
    );
  }
}

// Конкретные классы рас
final class ForestGnome extends CharacterRace {
  ForestGnome(Character character) : super(RaceConfigs.forestGnome);
}

final class RockGnome extends CharacterRace {
  RockGnome(Character character) : super(RaceConfigs.rockGnome);
}

final class MountainDwarf extends CharacterRace {
  MountainDwarf(Character character) : super(RaceConfigs.mountainDwarf);
}

final class HillDwarf extends CharacterRace {
  HillDwarf(Character character) : super(RaceConfigs.hillDwarf);
}

final class StockyHalfling extends CharacterRace {
  StockyHalfling(Character character) : super(RaceConfigs.stockyHalfling);
}

final class LighFootedHalfling extends CharacterRace {
  LighFootedHalfling(Character character) : super(RaceConfigs.lighFootedHalfling);
}

final class HighElf extends CharacterRace {
  HighElf(Character character) : super(RaceConfigs.highElf);
}

final class ForestElf extends CharacterRace {
  ForestElf(Character character) : super(RaceConfigs.forestElf);
}

final class Dragonborn extends CharacterRace {
  Dragonborn(Character character) : super(RaceConfigs.dragonborn);
}

final class HalfOrc extends CharacterRace {
  HalfOrc(Character character) : super(RaceConfigs.halfOrc);
}

final class HalfElf extends CharacterRace {
  HalfElf(Character character) : super(RaceConfigs.halfElf);
}

final class Tiefling extends CharacterRace {
  Tiefling(Character character) : super(RaceConfigs.tiefling);
}

final class Human extends CharacterRace {
  Human(Character character) : super(RaceConfigs.human);
}