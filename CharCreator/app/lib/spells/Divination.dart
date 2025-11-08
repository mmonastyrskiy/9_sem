// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';

final class TrueStrike implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Somatic
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 6; // Концентрация, до 1 раунда

  @override
  String name = "Меткий удар";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class Guidance implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
    CharClassNames.Clerc,
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
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Указание";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class HuntersMark implements Spell {
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
  int distance = 90;

  @override
  int duration_sec = 3600; // Концентрация, до 1 часа

  @override
  String name = "Метка охотника";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}

final class DetectPoisonAndDisease implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Paladin,
    CharClassNames.Ranger
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
  int distance = 0; // На себя (радиус 30 футов)

  @override
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Обнаружение болезней и яда";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}


final class DetectEvilAndGood implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc,
    CharClassNames.Paladin,
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
  int distance = 0; // На себя (радиус 30 футов)

  @override
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Обнаружение добра и зла";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}


final class DetectMagic implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Paladin,
    CharClassNames.Ranger,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier,
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
  int distance = 0; // На себя (радиус 30 футов)

  @override
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Обнаружение магии";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Identify implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Artifier,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.OneMinute;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Опознание";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}



final class ComprehendLanguages implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer
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
  int distance = 0; // На себя

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Понимание языков";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}


final class SpeakWithAnimals implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Druid,
    CharClassNames.Ranger
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
  int distance = 0; // На себя

  @override
  int duration_sec = 600; // 10 минут

  @override
  String name = "Разговор с животными";

  @override
  School? school = School.Divination;

  @override
  SpellType? type = SpellType.Spell1;
}