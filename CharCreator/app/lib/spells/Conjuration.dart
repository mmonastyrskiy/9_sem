// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';

final class MageHand implements Spell {
  @override
  List<CharClassNames> avaliabletoclass= [CharClassNames.Bard,CharClassNames.Wizzard,CharClassNames.Warlock,CharClassNames.Sorcerer,CharClassNames.Artifier];

  @override
  List<RaceName> avaliabletorace=[];

  @override
  SpellcastTime? casttime=SpellcastTime.Action;

  @override
  Set<SpellComponents> components={SpellComponents.Somatic,SpellComponents.Verbal};

  @override
  int distance=30;

  @override
  int duration_sec=60;

  @override
  String name="Волшебная рука";

  @override
  School? school=School.Conjuration;

  @override
  SpellType? type=SpellType.Cantrip;

}

final class SwordBurst implements Spell {
  @override
  List<CharClassNames> avaliabletoclass =[ 
    CharClassNames.Wizzard,
    CharClassNames.Warlock, 
    CharClassNames.Sorcerer,
    CharClassNames.Artifier];

  @override
  List<RaceName> avaliabletorace=[];

  @override
  SpellcastTime? casttime=SpellcastTime.Action;

  @override
  Set<SpellComponents> components={SpellComponents.Verbal};

  @override
  int distance=5;

  @override
  int duration_sec=0;

  @override
  String name='Вспышка мечей';

  @override
  School? school=School.Conjuration;

  @override
  SpellType? type=SpellType.Cantrip;

}

final class Infestation implements Spell {
  @override
   List<CharClassNames> avaliabletoclass =  [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer
  ];
  

  @override
  List<RaceName> avaliabletorace =  [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components =  {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Нашествие";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class CreateBonfire implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer,
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
  int distance = 60;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Сотворение костра";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class ProduceFlame implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
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
  int distance = 0; // На себя, но атака на 30 футов

  @override
  int duration_sec = 600; // 10 минут

  @override
  String name = "Сотворение пламени";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class PoisonSpray implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer,
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
  int distance = 10;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Ядовитые брызги";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class HailOfThorns implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Ranger
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
  String name = "Град шипов";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class IceKnife implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Ледяной кинжал";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class UnseenServant implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock
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
  int distance = 60;

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Невидимый слуга";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class Entangle implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
    CharClassNames.Ranger,
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
  int distance = 90;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Опутывание";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class EnsnaringStrike implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Ranger
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
  String name = "Опутывающий удар";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class FindFamiliar implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.OneHour;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 10;

  @override
  int duration_sec = 0; // Мгновенная (создание фамильяра)

  @override
  String name = "Поиск фамильяра";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}
final class ArmsOfHadar implements Spell {
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
  int distance = 0; // На себя (радиус 10 футов)

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Руки Хадара";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Grease implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier,
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
  int distance = 60;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Скольжение";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class TensersFloatingDisk implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard
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
  int duration_sec = 3600; // 1 час

  @override
  String name = "Парящий диск Тенсера";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class FogCloud implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Ranger,
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
  int distance = 120;

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Туманное облако";

  @override
  School? school = School.Conjuration;

  @override
  SpellType? type = SpellType.Spell1;
}