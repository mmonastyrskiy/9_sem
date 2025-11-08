// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_application_1/charclass.dart';
import 'package:flutter_application_1/items/item.dart';
import 'package:flutter_application_1/race.dart';

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

enum SpellComponents{
  Verbal,
  Somatic,
  Material
}
abstract interface class MaterialComponent {
  List<SellableItem> items = [];
}

abstract class Spell {
  String name ="";
  SpellType? type;
  School? school;
  SpellcastTime? casttime;
  int distance = 5;
  int duration_sec = 0;
  Set<SpellComponents> components ={};
  List<CharClassNames> avaliabletoclass =[];
  List<RaceName> avaliabletorace =[];
}

