// ignore_for_file: non_constant_identifier_names, collection_methods_unrelated_type, constant_identifier_names

// Импорт необходимых модулей и библиотек
import 'meta.dart';
import 'stat.dart';
import 'dice.dart';
import 'character.dart';
import 'items/item.dart';
import 'items/weapon.dart';
import 'items/armor.dart';
import 'tool.dart';
import 'ui/modal_service.dart';

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
      default: return 100;
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

// Результат применения класса персонажа
class ClassApplicationResult {
  final Set<String> selectedSkills;
  final String? selectedTool;

  ClassApplicationResult({
    required this.selectedSkills,
    this.selectedTool,
  });
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
  Future<ClassApplicationResult> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    ModalService modalService,
  ) async {
    // Устанавливаем кость хитов
    charHeath.hitDice = hitDice;
    
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
      tools.add(ToolSkill(tool,modalService, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_CLASS
      }));
    }

    // Устанавливаем спасброски
    for (final stat in savingThrowProficiencies) {
      stats[stat]!.savingthrow = 1;
    }

    // Выбор навыков
    final skillNames = availableSkills.map((skill) => skill.displayName).toSet();
    final choices = await modalService.showMultiSelectListPicker(
      items: skillNames,
      initialSelections: null,
    );
    
    for (final choice in choices) {
      final skillToAdd = Skills.values.firstWhere(
        (skill) => skill.displayName == choice,
        orElse: () => Skills.Acrobatics
      );
      skills[StatNames.fromSkill(skillToAdd)]!
        ..addMeta(MetaFlags.IS_PICKED_ON_CLASS)
        ..addMeta(MetaFlags.IS_PICKED)
        ..hasprofbounus += 1;
    }

    return ClassApplicationResult(selectedSkills: choices);
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
    charHeath.hitDice = null;
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
  
  factory CharClass.create(String className, Character character) {
    final constructor = _classConstructors[className.toLowerCase()];
    if (constructor != null) {
      return constructor(character);
    }
    return Undefined(character);
  }
  
  static final _classConstructors = <String, CharClass Function(Character character)>{
    'бард': (character) => Bard(character),
    'варвар': (character) => Barbarian(character),
    'воин': (character) => Fighter(character),
    'волшебник': (character) => Wizzard(character),
    'друид': (character) => Druid(character),
    'жрец': (character) => Clerc(character),
    'изобретатель': (character) => Artifier(character),
    'колдун': (character) => Warlock(character),
    'монах': (character) => Monk(character),
    'паладин': (character) => Paladin(character),
    'плут': (character) => Rouge(character),
    'следопыт': (character) => Ranger(character),
    'чародей': (character) => Sorcerer(character),
  };

  static Set<String> get availableClasses => _classConstructors.keys.toSet();

  @override
  Future<ClassApplicationResult> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    ModalService modalService,
  );

  @override
  void delete(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
  );
}

// Класс для неопределенного/невыбранного класса
final class Undefined extends BaseCharClass {
  Undefined(Character character) : super(
    classname: "Не выбрано",
    hitDice: DiceType.D6,
    armorProficiencies: {},
    weaponProficiencies: {},
    toolProficiencies: {},
    savingThrowProficiencies: {},
    availableSkills: {},
    skillChoices: 0,
  );

  @override
  Future<ClassApplicationResult> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    ModalService modalService,
  ) async {
    // Не применяем никаких изменений для неопределенного класса
    return ClassApplicationResult(selectedSkills: {});
  }
}

// Базовый конструктор для всех классов
base class CharacterClass extends BaseCharClass {
  CharacterClass({
    required super.classname,
    required super.hitDice,
    required super.armorProficiencies,
    required super.weaponProficiencies,
    required super.toolProficiencies,
    required super.savingThrowProficiencies,
    required super.availableSkills,
    required super.skillChoices,
  });
}

// Класс "Бард"
final class Bard extends CharacterClass {
  Bard(Character character) : super(
    classname: "Бард",
    hitDice: DiceType.D8,
    armorProficiencies: ClassProficiencies.lightArmor,
    weaponProficiencies: ClassProficiencies.bardWeapons,
    toolProficiencies: {"музыкальные инструменты"},
    savingThrowProficiencies: {BasicStatNames.DEX, BasicStatNames.CHR},
    availableSkills: Skills.values.toSet(),
    skillChoices: 3,
  );
}

// Класс "Варвар"
final class Barbarian extends CharacterClass {
  Barbarian(Character character) : super(
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
  );
}

// Класс "Воин"
final class Fighter extends CharacterClass {
  Fighter(Character character) : super(
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
  );
}

// Класс "Волшебник"
final class Wizzard extends CharacterClass {
  Wizzard(Character character) : super(
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
  );
}

// Класс "Друид"
final class Druid extends CharacterClass {
  Druid(Character character) : super(
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
  );
}

// Класс "Жрец"
final class Clerc extends CharacterClass {
  Clerc(Character character) : super(
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
  );
}

// Класс "Изобретатель"
final class Artifier extends CharacterClass {
  Artifier(Character character) : super(
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
  );
}

// Класс "Колдун"
final class Warlock extends CharacterClass {
  Warlock(Character character) : super(
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
  );
}

// Класс "Монах"
final class Monk extends CharacterClass {
  Monk(Character character) : super(
    classname: "Монах",
    hitDice: DiceType.D8,
    armorProficiencies: {},
    weaponProficiencies: {
      WeaponType.SimpleWeapon,
      WeaponType.ShortSword,
    },
    toolProficiencies: {},
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
  );

  @override
  Future<ClassApplicationResult> apply(
    Health charHeath,
    Map<BasicStatNames, BasicStat> stats,
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor,
    Set<AbstractWeapon> canUseWeapon,
    Set<ToolSkill> tools,
    ModalService modalService,
  ) async {
    final result = await super.apply(
      charHeath, stats, skills, canUseArmor, canUseWeapon, tools, modalService
    );

    // Выбор инструмента для монаха
    final toolOptions = {"инструменты ремесленника", "музыкальные инструменты"};
    final toolChoices = await modalService.showMultiSelectListPicker(
      items: toolOptions,
      initialSelections: null,
    );

    if (toolChoices.isNotEmpty) {
      final chosenTool = toolChoices.first;
      tools.add(ToolSkill(chosenTool,modalService, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_CLASS
      }));
      
      return ClassApplicationResult(
        selectedSkills: result.selectedSkills,
        selectedTool: chosenTool,
      );
    }

    return result;
  }
}

// Класс "Паладин"
final class Paladin extends CharacterClass {
  Paladin(Character character) : super(
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
  );
}

// Класс "Плут"
final class Rouge extends CharacterClass {
  Rouge(Character character) : super(
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
  );
}

// Класс "Следопыт"
final class Ranger extends CharacterClass {
  Ranger(Character character) : super(
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
  );
}

// Класс "Чародей"
final class Sorcerer extends CharacterClass {
  Sorcerer(Character character) : super(
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
  );
}