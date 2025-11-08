// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';

final class MinorIllusion implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer
  ];

  @override
  List<RaceName> avaliabletorace = [
    RaceName.ForestGnome, // Гном (лесной)

  ];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Малая иллюзия";

  @override
  School? school = School.Illusion;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class SilentImage implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer
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
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Безмолвный образ";

  @override
  School? school = School.Illusion;

  @override
  SpellType? type = SpellType.Spell1;
}

final class DisguiseSelf implements Spell {
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
    SpellComponents.Somatic
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Маскировка";

  @override
  School? school = School.Illusion;

  @override
  SpellType? type = SpellType.Spell1;
}


final class IllusoryScript implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock
  ];

  @override
  List<RaceName> avaliabletorace = [

  ];

  @override
  SpellcastTime? casttime = SpellcastTime.OneMinute;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 864000; // 10 дней

  @override
  String name = "Невидимое письмо";

  @override
  School? school = School.Illusion;

  @override
  SpellType? type = SpellType.Spell1;
}

final class ColorSpray implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
  int distance = 0; // На себя (15-футовый конус)

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Сверкающие брызги";

  @override
  School? school = School.Illusion;

  @override
  SpellType? type = SpellType.Spell1;
}