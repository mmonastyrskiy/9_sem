// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';

final class BladeWard implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Защита от оружия";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class Resistance implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Artifier
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
  int distance = 0; // Касание

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Сопротивление";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class ArmorOfAgathys implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Warlock,
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
  String name = "Доспех Агатиса";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class MageArmor implements Spell {
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 28800; // 8 часов

  @override
  String name = "Доспехи мага";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class ProtectionFromEvilAndGood implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Warlock,
    CharClassNames.Paladin,
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
  int distance = 0; // Касание

  @override
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Защита от добра и зла";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Alarm implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Ranger,
    CharClassNames.Artifier
  ];

  @override
  List<RaceName> avaliabletorace = [
  ];

  @override
  SpellcastTime? casttime = SpellcastTime.OneMinute;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 28800; // 8 часов

  @override
  String name = "Сигнал тревоги";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Sanctuary implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc,
    CharClassNames.Artifier,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Убежище";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}

final class Shield implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
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
  int distance = 0; // На себя

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Щит";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}


final class ShieldOfFaith implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc,
    CharClassNames.Paladin,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.BonusAction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Щит веры";

  @override
  School? school = School.Abjuration;

  @override
  SpellType? type = SpellType.Spell1;
}