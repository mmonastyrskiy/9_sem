// ignore_for_file: constant_identifier_names
import 'meta.dart';

abstract interface class Item {


}

enum ArmorType {
  Light,
  Medium,
  Heavy,
  Shield
}

enum WeaponType{
  SimpleWeapon,
  MartialWearpon,
  LongSword,
  ShortSword,
  Rapier,
  HandCrossBow,
  Dagger,
  Dart,
  Sling,
  CombatStaff,
  LightCrossBow,
  Mace,
  Club,
  Javeline,
  Sickle,
  Scimitar
}


enum OverallWeaponType {
  SimpleWeapon,
  MartialWearpon
}


final class Armor implements Item{
ArmorType? type; 
Meta metadata = Meta();

Armor(ArmorType armor, [Set<MetaFlags>? metadata]){
  type = armor;
  this.metadata.MetaFlags_ = metadata!;
}

static void deletebyMeta(Set<Armor>? armor,MetaFlags m){
    for(Armor l in armor!){
      if (l.metadata.MetaFlags_.contains(m)){
        armor.remove(l);
      }
    }
  }
  

}


class Weapon implements Item{
WeaponType? type;
Meta metadata = Meta();

Weapon(WeaponType weapon, [Set<MetaFlags>? metadata]){
  this.metadata.MetaFlags_ = metadata!;
  type = weapon;
}

static void deletebyMeta(Set<Weapon>? weapon,MetaFlags m){
    for(Weapon l in weapon!){
      if (l.metadata.MetaFlags_.contains(m)){
        weapon.remove(l);
      }
    }
  }
  

}

