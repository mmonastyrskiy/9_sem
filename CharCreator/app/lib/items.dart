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
ArmorType? type; 
Meta metadata = Meta();

Weapon(ArmorType armor, [Set<MetaFlags>? metadata]){
  type = armor;
  this.metadata.MetaFlags_ = metadata!;
}

static void deletebyMeta(Set<Weapon>? weapon,MetaFlags m){
    for(Weapon l in weapon!){
      if (l.metadata.MetaFlags_.contains(m)){
        weapon.remove(l);
      }
    }
  }
  

}