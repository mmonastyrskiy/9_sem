// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';


final class Shillelagh implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
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
  int distance = 0; // Касание

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Дубинка";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class Druidcraft implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid
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
  int distance = 30;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Искусство друидов";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class Mending implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier
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
  String name = "Починка";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class Message implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 120;

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Сообщение";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class ThornWhip implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
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
  int distance = 30;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Терновый кнут";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class Prestidigitation implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
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
  int distance = 10;

  @override
  int duration_sec = 3600; // до 1 часа

  @override
  String name = "Фокусы";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}
final class Thaumaturgy implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Clerc,
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
  int distance = 30;

  @override
  int duration_sec = 60; // до 1 минуты

  @override
  String name = "Чудотворство";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Cantrip;
}

final class PurifyFoodAndDrink implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
    CharClassNames.Clerc,
    CharClassNames.Paladin,
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
  int distance = 10;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Очищение пищи и питья";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class FeatherFall implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Reaction;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal,
    SpellComponents.Material
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Падение пёрышком";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}

final class ExpeditiousRetreat implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Warlock,
    CharClassNames.Sorcerer,
    CharClassNames.Artifier,
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
  int duration_sec = 600; // Концентрация, до 10 минут

  @override
  String name = "Поспешное отступление";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Jump implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Wizzard,
    CharClassNames.Druid,
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Прыжок";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Longstrider implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Druid,
    CharClassNames.Ranger,
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // Касание

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Скороход";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}



final class CreateOrDestroyWater implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Сотворение или уничтожение воды";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}
final class Goodberry implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Druid,
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
  int distance = 0; // Касание

  @override
  int duration_sec = 0; // Мгновенная (ягоды действуют 24 часа)

  @override
  String name = "Чудо-ягоды";

  @override
  School? school = School.Transmutation;

  @override
  SpellType? type = SpellType.Spell1;
}