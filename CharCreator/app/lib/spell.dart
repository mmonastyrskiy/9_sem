// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/items/item.dart';

// === ПЕРЕЧИСЛЕНИЯ ===

enum SpellType {
  Cantrip,
  Spell1
}

enum School {
  Conjuration,
  Evocation,
  Illusion,
  Necromancy,
  Abjuration,
  Enchantment,
  Transmutation,
  Divination
}

enum SpellcastTime {
  Action,
  BonusAction,
  OneHour,
  Reaction,
  OneMinute
}

enum SpellComponents {
  Verbal,
  Somatic,
  Material
}

// === ИНТЕРФЕЙСЫ И БАЗОВЫЕ КЛАССЫ ===

abstract interface class MaterialComponent {
  List<SellableItem> get items;
}

class SimpleMaterialComponent implements MaterialComponent {
  @override
  final List<SellableItem> items;

  const SimpleMaterialComponent(this.items);
}

/// Базовый класс заклинания с иммутабельными свойствами
abstract class Spell {
  final String name;
  final SpellType? type;
  final School? school;
  final SpellcastTime? castTime;
  final int distance;
  final int durationSec;
  final Set<SpellComponents> components;
  final List<CharClassNames> availableToClass;
  final List<RaceName> availableToRace;
  final MaterialComponent? materialComponent;

   Spell({
    required this.name,
    this.type,
    this.school,
    this.castTime,
    this.distance = 5,
    this.durationSec = 0,
    this.components = const {},
    this.availableToClass = const [],
    this.availableToRace = const [],
    this.materialComponent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spell &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'Spell(name: $name)';
}

// === ЕДИНЫЙ КЛАСС ДЛЯ ВСЕХ ЗАКЛИНАНИЙ ===

class Spells {
  // Abjuration
  static final Spell bladeWard = _BladeWard();
  static final Spell resistance = _Resistance();
  static final Spell armorOfAgathys = _ArmorOfAgathys();
  static final Spell mageArmor = _MageArmor();
  static final Spell protectionFromEvilAndGood = _ProtectionFromEvilAndGood();
  static final Spell alarm = _Alarm();
  static final Spell sanctuary = _Sanctuary();
  static final Spell shield = _Shield();
  static final Spell shieldOfFaith = _ShieldOfFaith();

  // Conjuration
  static final Spell mageHand = _MageHand();
  static final Spell swordBurst = _SwordBurst();
  static final Spell infestation = _Infestation();
  static final Spell createBonfire = _CreateBonfire();
  static final Spell produceFlame = _ProduceFlame();
  static final Spell poisonSpray = _PoisonSpray();
  static final Spell hailOfThorns = _HailOfThorns();
  static final Spell iceKnife = _IceKnife();
  static final Spell unseenServant = _UnseenServant();
  static final Spell entangle = _Entangle();
  static final Spell ensnaringStrike = _EnsnaringStrike();
  static final Spell findFamiliar = _FindFamiliar();
  static final Spell armsOfHadar = _ArmsOfHadar();
  static final Spell grease = _Grease();
  static final Spell tensersFloatingDisk = _TensersFloatingDisk();
  static final Spell fogCloud = _FogCloud();

  // Divination
  static final Spell trueStrike = _TrueStrike();
  static final Spell guidance = _Guidance();
  static final Spell huntersMark = _HuntersMark();
  static final Spell detectPoisonAndDisease = _DetectPoisonAndDisease();
  static final Spell detectEvilAndGood = _DetectEvilAndGood();
  static final Spell detectMagic = _DetectMagic();
  static final Spell identify = _Identify();
  static final Spell comprehendLanguages = _ComprehendLanguages();
  static final Spell speakWithAnimals = _SpeakWithAnimals();

  // Enchantment
  static final Spell friends = _Friends();
  static final Spell viciousMockery = _ViciousMockery();
  static final Spell bless = _Bless();
  static final Spell compelledDuel = _CompelledDuel();
  static final Spell heroism = _Heroism();
  static final Spell dissonantWhispers = _DissonantWhispers();
  static final Spell animalFriendship = _AnimalFriendship();
  static final Spell tashasHideousLaughter = _TashasHideousLaughter();
  static final Spell charmPerson = _CharmPerson();
  static final Spell bane = _Bane();
  static final Spell command = _Command();
  static final Spell hex = _Hex();
  static final Spell sleep = _Sleep();

  // Evocation
  static final Spell acidSplash = _AcidSplash();
  static final Spell rayOfFrost = _RayOfFrost();
  static final Spell eldritchBlast = _EldritchBlast();
  static final Spell fireBolt = _FireBolt();
  static final Spell dancingLights = _DancingLights();
  static final Spell light = _Light();
  static final Spell sacredFlame = _SacredFlame();
  static final Spell shockingGrasp = _ShockingGrasp();
  static final Spell hellishRebuke = _HellishRebuke();
  static final Spell divineFavor = _DivineFavor();
  static final Spell witchBolt = _WitchBolt();
  static final Spell thunderwave = _Thunderwave();
  static final Spell magicMissile = _MagicMissile();
  static final Spell wrathfulSmite = _WrathfulSmite();
  static final Spell thunderousSmite = _ThunderousSmite();
  static final Spell healingWord = _HealingWord();
  static final Spell cureWounds = _CureWounds();
  static final Spell guidingBolt = _GuidingBolt();
  static final Spell burningHands = _BurningHands();
  static final Spell faerieFire = _FaerieFire();
  static final Spell searingSmite = _SearingSmite();
  static final Spell chromaticOrb = _ChromaticOrb();

  // Illusion
  static final Spell minorIllusion = _MinorIllusion();
  static final Spell silentImage = _SilentImage();
  static final Spell disguiseSelf = _DisguiseSelf();
  static final Spell illusoryScript = _IllusoryScript();
  static final Spell colorSpray = _ColorSpray();

  // Necromancy
  static final Spell chillTouch = _ChillTouch();
  static final Spell spareTheDying = _SpareTheDying();
  static final Spell rayOfSickness = _RayOfSickness();
  static final Spell inflictWounds = _InflictWounds();
  static final Spell falseLife = _FalseLife();

  // Transmutation
  static final Spell shillelagh = _Shillelagh();
  static final Spell druidcraft = _Druidcraft();
  static final Spell mending = _Mending();
  static final Spell message = _Message();
  static final Spell thornWhip = _ThornWhip();
  static final Spell prestidigitation = _Prestidigitation();
  static final Spell thaumaturgy = _Thaumaturgy();
  static final Spell purifyFoodAndDrink = _PurifyFoodAndDrink();
  static final Spell featherFall = _FeatherFall();
  static final Spell expeditiousRetreat = _ExpeditiousRetreat();
  static final Spell jump = _Jump();
  static final Spell longstrider = _Longstrider();
  static final Spell createOrDestroyWater = _CreateOrDestroyWater();
  static final Spell goodberry = _Goodberry();

  // Список всех заклинаний
  static final List<Spell> all = [
    // Abjuration
    bladeWard, resistance, armorOfAgathys, mageArmor,
    protectionFromEvilAndGood, alarm, sanctuary, shield, shieldOfFaith,
    
    // Conjuration
    mageHand, swordBurst, infestation, createBonfire, produceFlame,
    poisonSpray, hailOfThorns, iceKnife, unseenServant, entangle,
    ensnaringStrike, findFamiliar, armsOfHadar, grease,
    tensersFloatingDisk, fogCloud,
    
    // Divination
    trueStrike, guidance, huntersMark, detectPoisonAndDisease,
    detectEvilAndGood, detectMagic, identify, comprehendLanguages, speakWithAnimals,
    
    // Enchantment
    friends, viciousMockery, bless, compelledDuel, heroism,
    dissonantWhispers, animalFriendship, tashasHideousLaughter,
    charmPerson, bane, command, hex, sleep,
    
    // Evocation
    acidSplash, rayOfFrost, eldritchBlast, fireBolt, dancingLights,
    light, sacredFlame, shockingGrasp, hellishRebuke, divineFavor,
    witchBolt, thunderwave, magicMissile, wrathfulSmite, thunderousSmite,
    healingWord, cureWounds, guidingBolt, burningHands, faerieFire,
    searingSmite, chromaticOrb,
    
    // Illusion
    minorIllusion, silentImage, disguiseSelf, illusoryScript, colorSpray,
    
    // Necromancy
    chillTouch, spareTheDying, rayOfSickness, inflictWounds, falseLife,
    
    // Transmutation
    shillelagh, druidcraft, mending, message, thornWhip,
    prestidigitation, thaumaturgy, purifyFoodAndDrink, featherFall,
    expeditiousRetreat, jump, longstrider, createOrDestroyWater, goodberry,
  ];

  // Методы для фильтрации

  static Spell? getByName(String name) {
    try {
      return all.firstWhere((spell) => spell.name == name);
    } catch (e) {
      return null;
    }
  }

  static List<Spell> getByClass(CharClassNames className) {
    return all.where((spell) => spell.availableToClass.contains(className)).toList();
  }

  static List<Spell> getBySchool(School school) {
    return all.where((spell) => spell.school == school).toList();
  }

  static List<Spell> getByType(SpellType type) {
    return all.where((spell) => spell.type == type).toList();
  }

  static List<Spell> getByCastTime(SpellcastTime castTime) {
    return all.where((spell) => spell.castTime == castTime).toList();
  }

  // Удобные геттеры

  static List<Spell> get cantrips => getByType(SpellType.Cantrip);
  static List<Spell> get firstLevelSpells => getByType(SpellType.Spell1);

  // Методы для получения заклинаний по школам (для обратной совместимости)
  static List<Spell> get abjurationSpells => getBySchool(School.Abjuration);
  static List<Spell> get conjurationSpells => getBySchool(School.Conjuration);
  static List<Spell> get divinationSpells => getBySchool(School.Divination);
  static List<Spell> get enchantmentSpells => getBySchool(School.Enchantment);
  static List<Spell> get evocationSpells => getBySchool(School.Evocation);
  static List<Spell> get illusionSpells => getBySchool(School.Illusion);
  static List<Spell> get necromancySpells => getBySchool(School.Necromancy);
  static List<Spell> get transmutationSpells => getBySchool(School.Transmutation);
}

// === РЕАЛИЗАЦИИ КОНКРЕТНЫХ ЗАКЛИНАНИЙ ===

// Abjuration
class _BladeWard extends Spell {
   _BladeWard() : super(
    name: "Защита от оружия", type: SpellType.Cantrip, school: School.Abjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _Resistance extends Spell {
   _Resistance() : super(
    name: "Сопротивление", type: SpellType.Cantrip, school: School.Abjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Artifier],
  );
}

class _ArmorOfAgathys extends Spell {
   _ArmorOfAgathys() : super(
    name: "Доспех Агатиса", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Warlock],
  );
}

class _MageArmor extends Spell {
   _MageArmor() : super(
    name: "Доспехи мага", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 28800,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _ProtectionFromEvilAndGood extends Spell {
   _ProtectionFromEvilAndGood() : super(
    name: "Защита от добра и зла", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Warlock, CharClassNames.Paladin],
  );
}

class _Alarm extends Spell {
   _Alarm() : super(
    name: "Сигнал тревоги", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.OneMinute, distance: 30, durationSec: 28800,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Ranger, CharClassNames.Artifier],
  );
}

class _Sanctuary extends Spell {
   _Sanctuary() : super(
    name: "Убежище", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.BonusAction, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Clerc, CharClassNames.Artifier],
  );
}

class _Shield extends Spell {
   _Shield() : super(
    name: "Щит", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.Reaction, distance: 0, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _ShieldOfFaith extends Spell {
   _ShieldOfFaith() : super(
    name: "Щит веры", type: SpellType.Spell1, school: School.Abjuration,
    castTime: SpellcastTime.BonusAction, distance: 60, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Clerc, CharClassNames.Paladin],
  );
}

// Conjuration
class _MageHand extends Spell {
   _MageHand() : super(
    name: "Волшебная рука", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Somatic, SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _SwordBurst extends Spell {
   _SwordBurst() : super(
    name: "Вспышка мечей", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 5, durationSec: 0,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Infestation extends Spell {
   _Infestation() : super(
    name: "Нашествие", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _CreateBonfire extends Spell {
   _CreateBonfire() : super(
    name: "Сотворение костра", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _ProduceFlame extends Spell {
   _ProduceFlame() : super(
    name: "Сотворение пламени", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Druid],
  );
}

class _PoisonSpray extends Spell {
   _PoisonSpray() : super(
    name: "Ядовитые брызги", type: SpellType.Cantrip, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 10, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _HailOfThorns extends Spell {
   _HailOfThorns() : super(
    name: "Град шипов", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Ranger],
  );
}

class _IceKnife extends Spell {
   _IceKnife() : super(
    name: "Ледяной кинжал", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Sorcerer],
  );
}

class _UnseenServant extends Spell {
   _UnseenServant() : super(
    name: "Невидимый слуга", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock],
  );
}

class _Entangle extends Spell {
   _Entangle() : super(
    name: "Опутывание", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 90, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Druid, CharClassNames.Ranger],
  );
}

class _EnsnaringStrike extends Spell {
   _EnsnaringStrike() : super(
    name: "Опутывающий удар", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Ranger],
  );
}

class _FindFamiliar extends Spell {
   _FindFamiliar() : super(
    name: "Поиск фамильяра", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.OneHour, distance: 10, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard],
  );
}

class _ArmsOfHadar extends Spell {
   _ArmsOfHadar() : super(
    name: "Руки Хадара", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Warlock],
  );
}

class _Grease extends Spell {
   _Grease() : super(
    name: "Скольжение", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _TensersFloatingDisk extends Spell {
   _TensersFloatingDisk() : super(
    name: "Парящий диск Тенсера", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard],
  );
}

class _FogCloud extends Spell {
   _FogCloud() : super(
    name: "Туманное облако", type: SpellType.Spell1, school: School.Conjuration,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Ranger, CharClassNames.Sorcerer],
  );
}

// Divination
class _TrueStrike extends Spell {
   _TrueStrike() : super(
    name: "Меткий удар", type: SpellType.Cantrip, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 6,
    components: {SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _Guidance extends Spell {
   _Guidance() : super(
    name: "Указание", type: SpellType.Cantrip, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Artifier],
  );
}

class _HuntersMark extends Spell {
   _HuntersMark() : super(
    name: "Метка охотника", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.BonusAction, distance: 90, durationSec: 3600,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Ranger],
  );
}

class _DetectPoisonAndDisease extends Spell {
   _DetectPoisonAndDisease() : super(
    name: "Обнаружение болезней и яда", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Paladin, CharClassNames.Ranger],
  );
}

class _DetectEvilAndGood extends Spell {
   _DetectEvilAndGood() : super(
    name: "Обнаружение добра и зла", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Clerc, CharClassNames.Paladin],
  );
}

class _DetectMagic extends Spell {
   _DetectMagic() : super(
    name: "Обнаружение магии", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Paladin, CharClassNames.Ranger, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Identify extends Spell {
   _Identify() : super(
    name: "Опознание", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.OneMinute, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Artifier],
  );
}

class _ComprehendLanguages extends Spell {
   _ComprehendLanguages() : super(
    name: "Понимание языков", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _SpeakWithAnimals extends Spell {
   _SpeakWithAnimals() : super(
    name: "Разговор с животными", type: SpellType.Spell1, school: School.Divination,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Druid, CharClassNames.Ranger],
  );
}

// Enchantment
class _Friends extends Spell {
   _Friends() : super(
    name: "Дружба", type: SpellType.Cantrip, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 60,
    components: {SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _ViciousMockery extends Spell {
   _ViciousMockery() : super(
    name: "Злая насмешка", type: SpellType.Cantrip, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard],
  );
}

class _Bless extends Spell {
   _Bless() : super(
    name: "Благословение", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Clerc, CharClassNames.Paladin],
  );
}

class _CompelledDuel extends Spell {
   _CompelledDuel() : super(
    name: "Вызов на дуэль", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.BonusAction, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Paladin],
  );
}

class _Heroism extends Spell {
   _Heroism() : super(
    name: "Героизм", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Paladin],
  );
}

class _DissonantWhispers extends Spell {
   _DissonantWhispers() : super(
    name: "Диссонирующий шёпот", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard],
  );
}

class _AnimalFriendship extends Spell {
   _AnimalFriendship() : super(
    name: "Дружба с животными", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 86400,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Druid, CharClassNames.Ranger],
  );
}

class _TashasHideousLaughter extends Spell {
   _TashasHideousLaughter() : super(
    name: "Жуткий смех Таши", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard],
  );
}

class _CharmPerson extends Spell {
   _CharmPerson() : super(
    name: "Очарование личности", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _Bane extends Spell {
   _Bane() : super(
    name: "Порча", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Clerc],
  );
}

class _Command extends Spell {
   _Command() : super(
    name: "Приказ", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 6,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard, CharClassNames.Clerc, CharClassNames.Paladin],
  );
}

class _Hex extends Spell {
   _Hex() : super(
    name: "Сглаз", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.BonusAction, distance: 90, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Warlock],
  );
}

class _Sleep extends Spell {
   _Sleep() : super(
    name: "Усыпление", type: SpellType.Spell1, school: School.Enchantment,
    castTime: SpellcastTime.Action, distance: 90, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

// Evocation
class _AcidSplash extends Spell {
   _AcidSplash() : super(
    name: "Брызги кислоты", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _RayOfFrost extends Spell {
   _RayOfFrost() : super(
    name: "Луч холода", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _EldritchBlast extends Spell {
   _EldritchBlast() : super(
    name: "Мистический заряд", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Warlock],
  );
}

class _FireBolt extends Spell {
   _FireBolt() : super(
    name: "Огненный снаряд", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _DancingLights extends Spell {
   _DancingLights() : super(
    name: "Пляшущие огоньки", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Light extends Spell {
   _Light() : super(
    name: "Свет", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Clerc, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _SacredFlame extends Spell {
   _SacredFlame() : super(
    name: "Священное пламя", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Clerc],
  );
}

class _ShockingGrasp extends Spell {
   _ShockingGrasp() : super(
    name: "Электрошок", type: SpellType.Cantrip, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _HellishRebuke extends Spell {
   _HellishRebuke() : super(
    name: "Адское возмездие", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Reaction, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Warlock],
  );
}

class _DivineFavor extends Spell {
   _DivineFavor() : super(
    name: "Божественное благоволение", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Paladin],
  );
}

class _WitchBolt extends Spell {
   _WitchBolt() : super(
    name: "Ведьмин снаряд", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _Thunderwave extends Spell {
   _Thunderwave() : super(
    name: "Волна грома", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Sorcerer],
  );
}

class _MagicMissile extends Spell {
   _MagicMissile() : super(
    name: "Волшебная стрела", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _WrathfulSmite extends Spell {
   _WrathfulSmite() : super(
    name: "Гневная кара", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Paladin],
  );
}

class _ThunderousSmite extends Spell {
   _ThunderousSmite() : super(
    name: "Громовая кара", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Paladin],
  );
}

class _HealingWord extends Spell {
   _HealingWord() : super(
    name: "Лечащее слово", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.BonusAction, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard, CharClassNames.Druid, CharClassNames.Clerc],
  );
}

class _CureWounds extends Spell {
   _CureWounds() : super(
    name: "Лечение ран", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Paladin, CharClassNames.Ranger, CharClassNames.Artifier],
  );
}

class _GuidingBolt extends Spell {
   _GuidingBolt() : super(
    name: "Направленный снаряд", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Clerc],
  );
}

class _BurningHands extends Spell {
   _BurningHands() : super(
    name: "Огненные ладони", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _FaerieFire extends Spell {
   _FaerieFire() : super(
    name: "Огонь фей", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Bard, CharClassNames.Druid, CharClassNames.Artifier],
  );
}

class _SearingSmite extends Spell {
   _SearingSmite() : super(
    name: "Палящая кара", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Paladin, CharClassNames.Ranger],
  );
}

class _ChromaticOrb extends Spell {
   _ChromaticOrb() : super(
    name: "Цветной шарик", type: SpellType.Spell1, school: School.Evocation,
    castTime: SpellcastTime.Action, distance: 90, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

// Illusion
class _MinorIllusion extends Spell {
   _MinorIllusion() : super(
    name: "Малая иллюзия", type: SpellType.Cantrip, school: School.Illusion,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
    availableToRace: [RaceName.ForestGnome],
  );
}

class _SilentImage extends Spell {
   _SilentImage() : super(
    name: "Безмолвный образ", type: SpellType.Spell1, school: School.Illusion,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _DisguiseSelf extends Spell {
   _DisguiseSelf() : super(
    name: "Маскировка", type: SpellType.Spell1, school: School.Illusion,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _IllusoryScript extends Spell {
   _IllusoryScript() : super(
    name: "Невидимое письмо", type: SpellType.Spell1, school: School.Illusion,
    castTime: SpellcastTime.OneMinute, distance: 0, durationSec: 864000,
    components: {SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock],
  );
}

class _ColorSpray extends Spell {
   _ColorSpray() : super(
    name: "Сверкающие брызги", type: SpellType.Spell1, school: School.Illusion,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

// Necromancy
class _ChillTouch extends Spell {
   _ChillTouch() : super(
    name: "Леденящее прикосновение", type: SpellType.Cantrip, school: School.Necromancy,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer],
  );
}

class _SpareTheDying extends Spell {
   _SpareTheDying() : super(
    name: "Уход за умирающим", type: SpellType.Cantrip, school: School.Necromancy,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Clerc, CharClassNames.Artifier],
  );
}

class _RayOfSickness extends Spell {
   _RayOfSickness() : super(
    name: "Луч болезни", type: SpellType.Spell1, school: School.Necromancy,
    castTime: SpellcastTime.Action, distance: 60, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer],
  );
}

class _InflictWounds extends Spell {
   _InflictWounds() : super(
    name: "Нанесение ран", type: SpellType.Spell1, school: School.Necromancy,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Clerc],
  );
}

class _FalseLife extends Spell {
   _FalseLife() : super(
    name: "Псевдожизнь", type: SpellType.Spell1, school: School.Necromancy,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

// Transmutation
class _Shillelagh extends Spell {
   _Shillelagh() : super(
    name: "Дубинка", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid],
  );
}

class _Druidcraft extends Spell {
   _Druidcraft() : super(
    name: "Искусство друидов", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Druid],
  );
}

class _Mending extends Spell {
   _Mending() : super(
    name: "Починка", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.OneMinute, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Message extends Spell {
   _Message() : super(
    name: "Сообщение", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 120, durationSec: 6,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _ThornWhip extends Spell {
   _ThornWhip() : super(
    name: "Терновый кнут", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid, CharClassNames.Artifier],
  );
}

class _Prestidigitation extends Spell {
   _Prestidigitation() : super(
    name: "Фокусы", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 10, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Thaumaturgy extends Spell {
   _Thaumaturgy() : super(
    name: "Чудотворство", type: SpellType.Cantrip, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 60,
    components: {SpellComponents.Verbal},
    availableToClass: [CharClassNames.Clerc],
  );
}

class _PurifyFoodAndDrink extends Spell {
   _PurifyFoodAndDrink() : super(
    name: "Очищение пищи и питья", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 10, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Druid, CharClassNames.Clerc, CharClassNames.Paladin, CharClassNames.Artifier],
  );
}

class _FeatherFall extends Spell {
   _FeatherFall() : super(
    name: "Падение пёрышком", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Reaction, distance: 60, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _ExpeditiousRetreat extends Spell {
   _ExpeditiousRetreat() : super(
    name: "Поспешное отступление", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.BonusAction, distance: 0, durationSec: 600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Warlock, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Jump extends Spell {
   _Jump() : super(
    name: "Прыжок", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 60,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Ranger, CharClassNames.Sorcerer, CharClassNames.Artifier],
  );
}

class _Longstrider extends Spell {
   _Longstrider() : super(
    name: "Скороход", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 3600,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Bard, CharClassNames.Wizzard, CharClassNames.Druid, CharClassNames.Ranger, CharClassNames.Artifier],
  );
}

class _CreateOrDestroyWater extends Spell {
   _CreateOrDestroyWater() : super(
    name: "Сотворение или уничтожение воды", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 30, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid, CharClassNames.Clerc],
  );
}

class _Goodberry extends Spell {
   _Goodberry() : super(
    name: "Чудо-ягоды", type: SpellType.Spell1, school: School.Transmutation,
    castTime: SpellcastTime.Action, distance: 0, durationSec: 0,
    components: {SpellComponents.Verbal, SpellComponents.Somatic, SpellComponents.Material},
    availableToClass: [CharClassNames.Druid, CharClassNames.Ranger],
  );
}