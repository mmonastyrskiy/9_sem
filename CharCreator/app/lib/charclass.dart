// ignore_for_file: non_constant_identifier_names, collection_methods_unrelated_type

// Импорт необходимых модулей и библиотек
import 'meta.dart';
import 'stat.dart';
import 'dice.dart';
import 'character.dart';
import 'items/item.dart';
import 'items/weapon.dart';
import 'items/armor.dart';
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

// Расширение для DiceType
extension DiceTypeExtension on DiceType {
  int get maxValue {
    switch (this) {
      case DiceType.D4: return 4;
      case DiceType.D6: return 6;
      case DiceType.D8: return 8;
      case DiceType.D10: return 10;
      case DiceType.D12: return 12;
      case DiceType.D20: return 20;
      default:
      return 100;
    }
  }
}

// Константы для часто используемых наборов владений
class ClassProficiencies {
  static const lightArmor = {ArmorType.Light};
  static const mediumArmor = {ArmorType.Light, ArmorType.Medium, ArmorType.Shield};
  static const allArmor = {ArmorType.Light, ArmorType.Medium, ArmorType.Heavy, ArmorType.Shield};
  static const simpleWeapons = {WeaponType.SimpleWeapon};
  static const martialWeapons = {WeaponType.SimpleWeapon, WeaponType.MartialWearpon};
  
  static const bardWeapons = {
    WeaponType.SimpleWeapon,
    WeaponType.ShortSword,
    WeaponType.LongSword,
    WeaponType.Rapier,
    WeaponType.HandCrossBow,
  };
  
  static const druidWeapons = {
    WeaponType.CombatStaff,
    WeaponType.Mace,
    WeaponType.Dart,
    WeaponType.Club,
    WeaponType.Javeline,
    WeaponType.Scimitar,
    WeaponType.Sickle,
  };
  
  static const wizardWeapons = {
    WeaponType.Dagger,
    WeaponType.Dart,
    WeaponType.Sling,
    WeaponType.CombatStaff,
    WeaponType.LightCrossBow,
  };
  
  static const sorcererWeapons = {
    WeaponType.CombatStaff,
    WeaponType.Dart,
    WeaponType.Dagger,
    WeaponType.LightCrossBow,
    WeaponType.Sling,
  };
  
  static const rogueWeapons = {
    WeaponType.SimpleWeapon,
    WeaponType.HandCrossBow,
    WeaponType.LongSword,
    WeaponType.ShortSword,
    WeaponType.Rapier,
  };
}

// Базовый абстрактный класс с общими методами
abstract base class BaseCharClass implements CharClass {
  final DiceType hitDice;
  final Set<ArmorType> armorProficiencies;
  final Set<WeaponType> weaponProficiencies;
  final Set<String> toolProficiencies;
  final Set<BasicStatNames> savingThrowProficiencies;
  final Set<Skills> availableSkills;
  final int skillChoices;
  
  @override
  final String classname;

  BaseCharClass({
    required this.classname,
    required this.hitDice,
    required this.armorProficiencies,
    required this.weaponProficiencies,
    required this.toolProficiencies,
    required this.savingThrowProficiencies,
    required this.availableSkills,
    required this.skillChoices,
  });

  @override
  Future<void> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) async {
    // Устанавливаем кость хитов
    charHeath.HitDice = hitDice;
    
    // Рассчитываем здоровье
    final CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = hitDice.maxValue + CONmodifier;
    charHeath.current_health = charHeath.max_health;

    // Добавляем владение броней
    for (final armorType in armorProficiencies) {
      canUseArmor.add(AbstractArmor(armorType, {
        MetaFlags.IS_PICKED_ON_CLASS,
        MetaFlags.IS_PICKED
      }));
    }

    // Добавляем владение оружием
    for (final weaponType in weaponProficiencies) {
      canUseWeapon.add(AbstractWeapon(weaponType, {
        MetaFlags.IS_PICKED_ON_CLASS,
        MetaFlags.IS_PICKED
      }));
    }

    // Добавляем инструменты
    for (final tool in toolProficiencies) {
      tools.add(ToolSkill(tool, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_CLASS
      }));
    }

    // Устанавливаем спасброски
    for (final stat in savingThrowProficiencies) {
      stats[stat]!.savingthrow = 1;
    }

    // Выбор навыков
    final choices = await Skill('').pickmany(
      context, 
      null, 
      skillChoices,
      availableSkills,
    );
    
    for (final choice in choices) {
      final skillToAdd = Skill.string2skill()[choice]!;
      skills[skillToAdd]!
        ..addMeta(MetaFlags.IS_PICKED_ON_CLASS)
        ..addMeta(MetaFlags.IS_PICKED)
        ..hasprofbounus += 1;
    }
  }

  @override
  void delete(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
  ) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    
    AbstractArmor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    AbstractWeapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);
    
    for (final stat in savingThrowProficiencies) {
      stats[stat]!.savingthrow = 0;
    }
    
    Skill.deletebyMeta(skills, MetaFlags.IS_PICKED_ON_CLASS);
  }
}
// Абстрактный интерфейс для классов персонажей
abstract interface class CharClass implements AffectsStatClass {
  String get classname;
  
  factory CharClass(String chosen, Character c) {
    final constructor = _classConstructors[chosen.toLowerCase()];
    if (constructor != null) {
      return constructor(
        c.health, 
        c.getbasicstats(), 
        c.getskills(), 
        c.CanUseArmor, 
        c.canUseWeapon, 
        c.getToolingskills(), 
        c.UIContext
      );
    }
    return Undefined(
      c.health, 
      c.getbasicstats(), 
      c.getskills(), 
      c.CanUseArmor, 
      c.canUseWeapon, 
      c.getToolingskills(), 
      c.UIContext
    );
  }
  
  static final _classConstructors = <String, CharClass Function(
    Health health,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context
  )>{
    'бард': (health, stats, skills, armor, weapons, tools, context) => 
      Bard(health, stats, skills, armor, weapons, tools, context),
    'варвар': (health, stats, skills, armor, weapons, tools, context) => 
      Barbarian(health, stats, skills, armor, weapons, tools, context),
    'воин': (health, stats, skills, armor, weapons, tools, context) => 
      Fighter(health, stats, skills, armor, weapons, tools, context),
    'волшебник': (health, stats, skills, armor, weapons, tools, context) => 
      Wizzard(health, stats, skills, armor, weapons, tools, context),
    'друид': (health, stats, skills, armor, weapons, tools, context) => 
      Druid(health, stats, skills, armor, weapons, tools, context),
    'жрец': (health, stats, skills, armor, weapons, tools, context) => 
      Clerc(health, stats, skills, armor, weapons, tools, context),
    'изобретатель': (health, stats, skills, armor, weapons, tools, context) => 
      Artifier(health, stats, skills, armor, weapons, tools, context),
    'колдун': (health, stats, skills, armor, weapons, tools, context) => 
      Warlock(health, stats, skills, armor, weapons, tools, context),
    'монах': (health, stats, skills, armor, weapons, tools, context) => 
      Monk(health, stats, skills, armor, weapons, tools, context),
    'паладин': (health, stats, skills, armor, weapons, tools, context) => 
      Paladin(health, stats, skills, armor, weapons, tools, context),
    'плут': (health, stats, skills, armor, weapons, tools, context) => 
      Rouge(health, stats, skills, armor, weapons, tools, context),
    'следопыт': (health, stats, skills, armor, weapons, tools, context) => 
      Ranger(health, stats, skills, armor, weapons, tools, context),
    'чародей': (health, stats, skills, armor, weapons, tools, context) => 
      Sorcerer(health, stats, skills, armor, weapons, tools, context),
  };
}

// Класс для неопределенного/невыбранного класса
final class Undefined extends BaseCharClass {
  Undefined(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Не выбрано",
    hitDice: DiceType.D6,
    armorProficiencies: {},
    weaponProficiencies: {},
    toolProficiencies: {},
    savingThrowProficiencies: {},
    availableSkills: {},
    skillChoices: 0,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
  
  @override
  Future<void> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) async {
    // Не применяем никаких изменений для неопределенного класса
  }
}

// Класс "Бард"
final class Bard extends BaseCharClass {
  Bard(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Бард",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.lightArmor,
    weaponProficiencies: ClassProficiencies.bardWeapons,
    toolProficiencies: {"музыкальные инструменты"},
    savingThrowProficiencies: {BasicStatNames.DEX, BasicStatNames.CHR},
    availableSkills: Skills.values.toSet(), // Бард может выбрать любые навыки
    skillChoices: 3,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Варвар"
final class Barbarian extends BaseCharClass {
  Barbarian(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Варвар",
    hitDice: DiceType.D12,
    armorProficiencies: ClassProficiencies.mediumArmor,
    weaponProficiencies: ClassProficiencies.martialWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.STR, BasicStatNames.CON},
    availableSkills: {
      Skills.Athletics,
      Skills.Perception,
      Skills.Survival,
      Skills.Intimidation,
      Skills.Animal_Handling,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Воин"
final class Fighter extends BaseCharClass {
  Fighter(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Воин",
    hitDice: DiceType.D10,
    armorProficiencies: ClassProficiencies.allArmor,
    weaponProficiencies: ClassProficiencies.martialWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.STR, BasicStatNames.CON},
    availableSkills: {
      Skills.Acrobatics,
      Skills.Athletics,
      Skills.Perception,
      Skills.Survival,
      Skills.Intimidation,
      Skills.History,
      Skills.Insight,
      Skills.Animal_Handling,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Волшебник"
final class Wizzard extends BaseCharClass {
  Wizzard(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Волшебник",
    hitDice: DiceType.D6,
    armorProficiencies: {},
    weaponProficiencies: ClassProficiencies.wizardWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.INT, BasicStatNames.WIS},
    availableSkills: {
      Skills.History,
      Skills.Arcana,
      Skills.Medicine,
      Skills.Perception,
      Skills.Investigation,
      Skills.Religion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Друид"
final class Druid extends BaseCharClass {
  Druid(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Друид",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.mediumArmor,
    weaponProficiencies: ClassProficiencies.druidWeapons,
    toolProficiencies: {"набор травника"},
    savingThrowProficiencies: {BasicStatNames.INT, BasicStatNames.WIS},
    availableSkills: {
      Skills.Perception,
      Skills.Survival,
      Skills.Arcana,
      Skills.Medicine,
      Skills.Animal_Handling,
      Skills.Nature,
      Skills.Insight,
      Skills.Religion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Жрец"
final class Clerc extends BaseCharClass {
  Clerc(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Жрец",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.mediumArmor,
    weaponProficiencies: ClassProficiencies.simpleWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.CHR, BasicStatNames.WIS},
    availableSkills: {
      Skills.History,
      Skills.Medicine,
      Skills.Insight,
      Skills.Religion,
      Skills.Persuasion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Изобретатель"
final class Artifier extends BaseCharClass {
  Artifier(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Изобретатель",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.mediumArmor,
    weaponProficiencies: ClassProficiencies.simpleWeapons,
    toolProficiencies: {
      "воровские инструменты",
      "инструменты ремонтника", 
      "инструменты ремесленника"
    },
    savingThrowProficiencies: {BasicStatNames.CON, BasicStatNames.INT},
    availableSkills: {
      Skills.Perception,
      Skills.History,
      Skills.Sleight_of_Hand,
      Skills.Arcana,
      Skills.Medicine,
      Skills.Nature,
      Skills.Investigation,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Колдун"
final class Warlock extends BaseCharClass {
  Warlock(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Колдун",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.lightArmor,
    weaponProficiencies: ClassProficiencies.simpleWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.WIS, BasicStatNames.CHR},
    availableSkills: {
      Skills.Intimidation,
      Skills.History,
      Skills.Arcana,
      Skills.Deception,
      Skills.Nature,
      Skills.Investigation,
      Skills.Religion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Монах"
final class Monk extends BaseCharClass {
  Monk(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Монах",
    hitDice: DiceType.D8,
    armorProficiencies: {},
    weaponProficiencies: {
      WeaponType.SimpleWeapon,
      WeaponType.ShortSword,
    },
    toolProficiencies: {}, // Выбирается отдельно в apply
    savingThrowProficiencies: {BasicStatNames.STR, BasicStatNames.DEX},
    availableSkills: {
      Skills.Acrobatics,
      Skills.Athletics,
      Skills.History,
      Skills.Insight,
      Skills.Religion,
      Skills.Stealth,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }

  @override
  Future<void> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) async {
    // Сначала вызываем базовый apply
    await super.apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
    
    // Затем добавляем специфичную для монаха логику выбора инструмента
    final chosen = ToolSkill('').pick(context, {
      ToolsNames.Artisans_Tools,
      ToolsNames.Musical_Instruments
    });
    tools.add(ToolSkill(chosen!, {
      MetaFlags.IS_PICKED,
      MetaFlags.IS_PICKED_ON_CLASS
    }));
  }
}

// Класс "Паладин"
final class Paladin extends BaseCharClass {
  Paladin(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Паладин",
    hitDice: DiceType.D10,
    armorProficiencies: ClassProficiencies.allArmor,
    weaponProficiencies: ClassProficiencies.martialWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.WIS, BasicStatNames.CHR},
    availableSkills: {
      Skills.Athletics,
      Skills.Intimidation,
      Skills.Medicine,
      Skills.Insight,
      Skills.Religion,
      Skills.Persuasion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Плут"
final class Rouge extends BaseCharClass {
  Rouge(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Плут",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.lightArmor,
    weaponProficiencies: ClassProficiencies.rogueWeapons,
    toolProficiencies: {"воровские инструменты"},
    savingThrowProficiencies: {BasicStatNames.DEX, BasicStatNames.INT},
    availableSkills: {
      Skills.Athletics,
      Skills.Acrobatics,
      Skills.Perception,
      Skills.Performance,
      Skills.Intimidation,
      Skills.Sleight_of_Hand,
      Skills.Deception,
      Skills.Insight,
      Skills.Investigation,
      Skills.Stealth,
      Skills.Persuasion,
    },
    skillChoices: 4,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Следопыт"
final class Ranger extends BaseCharClass {
  Ranger(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Следопыт",
    hitDice: DiceType.D10,
    armorProficiencies: ClassProficiencies.mediumArmor,
    weaponProficiencies: ClassProficiencies.martialWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.DEX, BasicStatNames.STR},
    availableSkills: {
      Skills.Athletics,
      Skills.Perception,
      Skills.Survival,
      Skills.Nature,
      Skills.Insight,
      Skills.Investigation,
      Skills.Stealth,
      Skills.Animal_Handling,
    },
    skillChoices: 3,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}

// Класс "Чародей"
final class Sorcerer extends BaseCharClass {
  Sorcerer(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    BuildContext context,
  ) : super(
    classname: "Чародей",
    hitDice: DiceType.D6,
    armorProficiencies: {},
    weaponProficiencies: ClassProficiencies.sorcererWeapons,
    toolProficiencies: {},
    savingThrowProficiencies: {BasicStatNames.CON, BasicStatNames.CHR},
    availableSkills: {
      Skills.Intimidation,
      Skills.Arcana,
      Skills.Deception,
      Skills.Insight,
      Skills.Religion,
      Skills.Persuasion,
    },
    skillChoices: 2,
  ) {
    apply(charHeath, stats, skills, canUseArmor, canUseWeapon, tools, context);
  }
}