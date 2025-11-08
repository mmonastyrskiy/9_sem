// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';

final class AcidSplash implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Брызги кислоты";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class RayOfFrost implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Луч холода";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class EldritchBlast implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Warlock
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Мистический заряд";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class FireBolt implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Огненный снаряд";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class DancingLights implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Пляшущие огоньки";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class Light implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Clerc,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Свет";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class SacredFlame implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Священное пламя";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class ShockingGrasp implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Электрошок";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class HellishRebuke implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Warlock
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Reaction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Адское возмездие";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class DivineFavor implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Paladin
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Божественное благоволение";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}
final class WitchBolt implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Ведьмин снаряд";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Thunderwave implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Sorcerer,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // На себя (15-футовый куб)

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Волна грома";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class MagicMissile implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Волшебная стрела";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class WrathfulSmite implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Paladin
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Гневная кара";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class ThunderousSmite implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Paladin
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Громовая кара";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class HealingWord implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Druid,
    CharClassNames.Clerc
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Лечащее слово";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}
final class CureWounds implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Paladin,
    CharClassNames.Ranger,
    CharClassNames.Artifier,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Лечение ран";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class GuidingBolt implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 6; // 1 раунд (6 секунд)

  @override
  String name = "Направленный снаряд";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class BurningHands implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // На себя (15-футовый конус)

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Огненные ладони";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class FaerieFire implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Druid,
    CharClassNames.Artifier,
  ];

  @override
  List<RaceName> avaliabletorace = [

  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Огонь фей";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class SearingSmite implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Paladin,
    CharClassNames.Ranger
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Палящая кара";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class ChromaticOrb implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 90;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Цветной шарик";

  @override
  School? school = School.Evocation;

  @override
  SpellType? type = SpellType.Spell1;
}