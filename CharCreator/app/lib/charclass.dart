// ignore_for_file: non_constant_identifier_names

import 'package:app/meta.dart';

import 'stat.dart';
import 'dice.dart';
import 'character.dart';
import 'items.dart';
// ignore_for_file: constant_identifier_names

enum CharClassNames {

Bard,
Barbarian,
Fighter,
Wizzrd,
Druid,
Clerc,
Artifier,
Warlok,
Monk,
Paladin,
Rouge,
Ranger,
Sorcerer
}

abstract interface class CharClass implements AffectsStatClass{
  factory CharClass(String chosen,Character c) 
  {
    Health charHeath = c.health;
    Set<Armor> CanUseArmor = c.CanUseArmor;
    Set<Weapon> canUseWeapon = c.canUseWeapon;
    Map<BasicStatNames,BasicStat> stats = c.getbasicstats();
    switch(chosen.toLowerCase()){
      case 'варвар': Bard(charHeath,stats,CanUseArmor,canUseWeapon);
      default: throw ArgumentError("Not implemented class");
    }
   throw ArgumentError("Not implemented class"); //TODO странная штука, надо разобраться 
  }

}
final class Bard implements CharClass {
  Bard(Health charHeath,Map<BasicStatNames,BasicStat> stats,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon){
    apply(charHeath,stats,CanUseArmor,canUseWeapon);
  }
  @override
  void apply(Health charHeath,Map<BasicStatNames,BasicStat> stat,Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    CanUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS}));
    canUseWeapon.add(Weapon(armor))
    int CONmodifier = stat[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier;
    charHeath.current_health = charHeath.max_health;


  }

  @override
  void delete(Health charHeath,stat,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Armor.deletebyMeta(CanUseArmor, MetaFlags.IS_PICKED_ON_CLASS);


  }

}