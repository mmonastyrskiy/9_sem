// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/race.dart';
import 'package:flutter_application_1/spells/spell.dart';



final class Friends implements Spell {
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 0; // На себя

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Дружба";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class ViciousMockery implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard
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
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Злая насмешка";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Cantrip;
}


final class Bless implements Spell {
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
    SpellComponents.Somatic,
    SpellComponents.Material
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Благословение";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}



final class CompelledDuel implements Spell {
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
  int distance = 30;

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Вызов на дуэль";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Heroism implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
  int distance = 0; // Касание

  @override
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Героизм";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}

final class DissonantWhispers implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 0; // Мгновенная

  @override
  String name = "Диссонирующий шёпот";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}

final class AnimalFriendship implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Druid,
    CharClassNames.Ranger,
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
  int duration_sec = 86400; // 24 часа

  @override
  String name = "Дружба с животными";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}

final class TashasHideousLaughter implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
  int duration_sec = 60; // Концентрация, до 1 минуты

  @override
  String name = "Жуткий смех Таши";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}


final class CharmPerson implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Wizzard,
    CharClassNames.Druid,
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
    SpellComponents.Somatic
  };

  @override
  int distance = 30;

  @override
  int duration_sec = 3600; // 1 час

  @override
  String name = "Очарование личности";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}



final class Bane implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Clerc,
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
  String name = "Порча";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Command implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
    CharClassNames.Clerc,
    CharClassNames.Paladin,
  ];

  @override
  List<RaceName> avaliabletorace = [];

  @override
  SpellcastTime? casttime = SpellcastTime.Action;

  @override
  Set<SpellComponents> components = {
    SpellComponents.Verbal
  };

  @override
  int distance = 60;

  @override
  int duration_sec = 6; // 1 раунд

  @override
  String name = "Приказ";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}


final class Hex implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Warlock,
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
  int distance = 90;

  @override
  int duration_sec = 3600; // Концентрация, до 1 часа

  @override
  String name = "Сглаз";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}

final class Sleep implements Spell {
  @override
  List<CharClassNames> avaliabletoclass = [
    CharClassNames.Bard,
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
  int distance = 90;

  @override
  int duration_sec = 60; // 1 минута

  @override
  String name = "Усыпление";

  @override
  School? school = School.Enchantment;

  @override
  SpellType? type = SpellType.Spell1;
}