// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';



final class ChillTouch implements Spell {
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
    SpellComponents.Somatic
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Леденящее прикосновение";

  @override
  School? school = School.Necromancy;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class SpareTheDying implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
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
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Уход за умирающим";

  @override
  School? school = School.Necromancy;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class RayOfSickness implements Spell {
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
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Луч болезни";

  @override
  School? school = School.Necromancy;

  @override
  SpellType? type = SpellType.Spell1;
}
final class InflictWounds implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc,
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
  String name = "Нанесение ран";

  @override
  School? school = School.Necromancy;

  @override
  SpellType? type = SpellType.Spell1;
}

final class FalseLife implements Spell {
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
  int distance = 0; // На себя

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Псевдожизнь";

  @override
  School? school = School.Necromancy;

  @override
  SpellType? type = SpellType.Spell1;
}