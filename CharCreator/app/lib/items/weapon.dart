// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'item.dart';
import '../money.dart';
import '../dice.dart';
import '../meta.dart';

enum WearponProperty{
Finesse,
Universal,
Light,
Thrown,
TwoHanded,
Ammo,
Reload,
Heavy,
Reach,
Special,
Multishot

}

enum WeaponType {
  SimpleWeapon,    // Простое оружие - базовое оружие, доступное всем классам
  MartialWearpon,  // Воинское оружие - специализированное оружие для военных классов
  LongSword,       // Длинный меч - двуручное рубящее/колющее оружие
  ShortSword,      // Короткий меч - одноручное легкое оружие
  Rapier,          // Рапира - изящное колющее оружие для фехтования
  HandCrossBow,    // Ручной арбалет - небольшое метательное оружие
  Dagger,          // Кинжал - маленькое скрытое оружие
  Dart,            // Дротик - метательное оружие для ближней дистанции
  Sling,           // Праща - простое метательное оружие
  CombatStaff,     // Боевой посох - простое двуручное оружие
  LightCrossBow,   // Легкий арбалет - метательное оружие средней мощности
  Mace,            // Булава - дробящее оружие
  Club,            // Дубина - простое дробящее оружие
  Javeline,        // Метательное копье - оружие для бросков
  Sickle,          // Серп - легкое режущее оружие
  Scimitar,         // Скимитар - изогнутый меч для режущих ударов
  ShortBow,
  LongBow,
  Meele,
  Distant,
  Spear,
  Hammer,
  Greatclub,
  Handaxe,
  Halberd,
  WarPick,
  Warhammer,
  Battleaxe,
  Glaive,
  Greatsword,
  Lance,
  Whip,
  Maul,
  Morningstar,
  Pike,
  Greataxe,
  Trident,
  Flail,
  HeavyCrossBow,
  Blowgun,
  Musket,
  AutoPistol,
  Pistol,
  Net
}


enum DamageType {
  Bludgeoning,
  Piercing,
  Slashing //Todo: Возможно где-то еще пропустил рубящий
}

abstract interface class Universal {
  Damage? TwoHandedDamage;
}
abstract interface class Thrown{}
abstract interface class Special{}
abstract interface class Multishot{
  int hasshots = 6;
}

abstract interface class Ammo{SellableItem? ammo;}

class Damage{
  DiceType dmgdice = DiceType.None;
  late DamageType dmgtype;
  late int da;
  


Damage(this.dmgdice,this.dmgtype,{this.da=1}){
  // ignore: unused_local_variable
  bool hasconstdamage = false;
}
Damage.constint(int n){
dmgdice = DiceType.DN;
// ignore: unused_local_variable
bool hasconstdamage= true;
// ignore: unused_local_variable
int mod = n;

}
}

abstract interface class Weapon implements SellableItem {
Set<WeaponType> type= {};
Set<WearponProperty> props={};
@override
  String name ="";
Damage? dmg;
int? distance = 0;
Meta meta =Meta();
bool isEquiped = false;



static List<Weapon> getAllWeapons() {
  return [
    // Простое оружие
    Quarterstaff(),
    Mace(),
    Club(),
    Dagger(),
    Spear(),
    LightHammer(),
    Javeline(), // исправлено с Javeline
    Greatclub(),
    Handaxe(),
    Sickle(),
    LightCrossBow(),
    Dart(),
    Shortbow(),
    Sling(),
    
    // Воинское оружие
    Rapier(),
    Halberd(),
    WarPick(),
    Warhammer(),
    Battleaxe(),
    Glaive(),
    Greatsword(),
    Lance(),
    Whip(),
    Shortsword(),
    Maul(),
    Morningstar(),
    Pike(),
    Greataxe(),
    Scimitar(),
    Trident(),
    Flail(),
    HandCrossBow(),
    HeavyCrossBow(),
    LongBow(),
    Blowgun(),
    Musket(),
    AutoPistol(),
    Pistol(),
    Net(),
    Longsword(),
  ];
}


}



final class Rapier with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 25);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Rapier,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Finesse};

  @override
  String name ="Рапира";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta= Meta();

  @override
  bool isEquiped=false;

}



final class Quarterstaff with DefaultQty implements Weapon,Universal{
  @override
  Price price = Price(silver: 2);



  @override
  double weight=4;

  @override
  Set<WeaponType> type={WeaponType.CombatStaff,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Universal};

  @override
  String name ="Боевой посох";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Bludgeoning);

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D8, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}



final class Mace with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=4;

  @override
  Set<WeaponType> type={WeaponType.Mace,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={};

  @override
  String name ="Булава";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}




final class Club with DefaultQty implements Weapon{
  @override
  Price price = Price(silver: 1);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Club,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={};

  @override
  String name ="Дубинка";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}


final class Dagger with DefaultQty implements Weapon,Thrown{
  @override
  Price price = Price(gold: 2);



  @override
  double weight=1;

  @override
  Set<WeaponType> type={WeaponType.Dagger,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Finesse,WearponProperty.Light,WearponProperty.Thrown};

  @override
  String name ="Кинжал";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}



final class Spear with DefaultQty implements Weapon,Thrown,Universal{
  @override
  Price price = Price(gold: 1);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Spear,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Universal,WearponProperty.Thrown};

  @override
  String name ="Копьё";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D8, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}



final class LightHammer with DefaultQty implements Weapon,Thrown{
  @override
  Price price = Price(gold: 2);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Hammer,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light,WearponProperty.Thrown};

  @override
  String name ="Легкий молот";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}


final class Javeline with DefaultQty implements Weapon,Thrown{
  @override
  Price price = Price(silver: 5);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Javeline,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Thrown};

  @override
  String name ="Метательное копьё";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class Greatclub with DefaultQty implements Weapon{
  @override
  Price price = Price(silver: 2);



  @override
  double weight=10;

  @override
  Set<WeaponType> type={WeaponType.Greatclub,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded};

  @override
  String name ="Палица";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class Handaxe with DefaultQty implements Weapon,Thrown{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Handaxe,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light,WearponProperty.Thrown};

  @override
  String name ="Ручной топор";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class Sickle with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 1);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Sickle,WeaponType.SimpleWeapon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light};

  @override
  String name ="Ручной топор";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class LightCrossBow with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 25);



  @override
  double weight=5;

  @override
  Set<WeaponType> type={WeaponType.LightCrossBow,WeaponType.SimpleWeapon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded,WearponProperty.Ammo,WearponProperty.Reload};

  @override
  String name ="Арбалет, лёгкий";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Piercing);

  @override
  SellableItem? ammo;

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}


final class Dart with DefaultQty implements Weapon,Thrown{
  @override
  Price price = Price(copper: 5);



  @override
  double weight=0.25;

  @override
  Set<WeaponType> type={WeaponType.Dart,WeaponType.SimpleWeapon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Thrown,WearponProperty.Finesse};

  @override
  String name ="Дротик";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}



final class Shortbow with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 25);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.ShortBow,WeaponType.SimpleWeapon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.TwoHanded};

  @override
  String name ="Короткий лук";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  SellableItem? ammo;

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}



final class Sling with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(silver: 1);



  @override
  double weight=0.1;

  @override
  Set<WeaponType> type={WeaponType.Sling,WeaponType.SimpleWeapon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo};

  @override
  String name ="Праща";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Bludgeoning);

  @override
  SellableItem? ammo;

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}


final class Halberd with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Halberd,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded,WearponProperty.Heavy,WearponProperty.Reach};

  @override
  String name ="Алебарда";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class WarPick with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=6;

  @override
  Set<WeaponType> type={WeaponType.WarPick,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={};

  @override
  String name ="Боевая кирка";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class Warhammer with DefaultQty implements Weapon,Universal{
  @override
  Price price = Price(gold: 15);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Warhammer,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Universal};

  @override
  String name ="Боевой молот";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D10, DamageType.Bludgeoning);

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}

final class Battleaxe with DefaultQty implements Weapon,Universal{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=4;

  @override
  Set<WeaponType> type={WeaponType.Battleaxe,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Universal};

  @override
  String name ="Боевой топор";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D10, DamageType.Bludgeoning);

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;
}



final class Glaive with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 20);



  @override
  double weight=6;

  @override
  Set<WeaponType> type={WeaponType.Glaive,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded,WearponProperty.Heavy,WearponProperty.Reach};

  @override
  String name ="Глефа";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Slashing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}


final class Greatsword with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 50);



  @override
  double weight=6;

  @override
  Set<WeaponType> type={WeaponType.Greatsword,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded,WearponProperty.Heavy};

  @override
  String name ="Двуручный меч";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Slashing,da: 2);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}




final class Lance with DefaultQty implements Weapon,Special{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=6;

  @override
  Set<WeaponType> type={WeaponType.Lance,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Reach,WearponProperty.Special};

  @override
  String name ="Длинное копьё";

  @override
  Damage? dmg=Damage(DiceType.D12, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}



final class Longsword with DefaultQty implements Weapon,Universal{
  @override
  Price price = Price(gold: 15);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.LongSword,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Universal};

  @override
  String name ="Длинный меч";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Slashing);

  @override
  int? distance;

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D10, DamageType.Slashing);

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}


final class Whip with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 2);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Whip,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Reach,WearponProperty.Finesse};

  @override
  String name ="Кнут";

  @override
  Damage? dmg=Damage(DiceType.D4, DamageType.Slashing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;
}

final class Shortsword with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.ShortSword,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light,WearponProperty.Finesse};

  @override
  String name ="Короткий меч";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}

final class Maul with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=10;

  @override
  Set<WeaponType> type={WeaponType.Maul,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.TwoHanded,WearponProperty.Heavy};

  @override
  String name ="Молот";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Bludgeoning,da: 2);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}

final class Morningstar with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 15);



  @override
  double weight=4;

  @override
  Set<WeaponType> type={WeaponType.Morningstar,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={};

  @override
  String name ="Моргенштерн";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}


final class Pike with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=18;

  @override
  Set<WeaponType> type={WeaponType.Pike,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Heavy,WearponProperty.TwoHanded,WearponProperty.Reach};

  @override
  String name ="Пика";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Piercing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}

final class Greataxe with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=18;

  @override
  Set<WeaponType> type={WeaponType.Greataxe,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Heavy,WearponProperty.TwoHanded};

  @override
  String name ="Секира";

  @override
  Damage? dmg=Damage(DiceType.D12, DamageType.Slashing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}

final class Scimitar with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 25);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Scimitar,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light,WearponProperty.Finesse};

  @override
  String name ="Скимитар";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Slashing);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}


final class Trident with DefaultQty implements Weapon,Thrown,Universal{
  @override
  Price price = Price(gold: 5);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Trident,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={WearponProperty.Light,WearponProperty.Finesse};

  @override
  String name ="Трезубец";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  int? distance;

  @override
  Damage? TwoHandedDamage=Damage(DiceType.D8, DamageType.Piercing);

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;



}


final class Flail with DefaultQty implements Weapon{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.Flail,WeaponType.MartialWearpon,WeaponType.Meele};

  @override
  Set<WearponProperty> props={};

  @override
  String name ="Цеп";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Bludgeoning);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}


final class HandCrossBow with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 75);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.HandCrossBow,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Reload,WearponProperty.Light};

  @override
  String name ="Арбалет, ручной";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}


final class HeavyCrossBow with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 50);



  @override
  double weight=18;

  @override
  Set<WeaponType> type={WeaponType.HeavyCrossBow,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Reload,WearponProperty.Heavy,WearponProperty.TwoHanded};

  @override
  String name ="Арбалет, тяжёлый";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Piercing);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}

final class LongBow with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 50);



  @override
  double weight=2;

  @override
  Set<WeaponType> type={WeaponType.LongBow,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Heavy,WearponProperty.TwoHanded};

  @override
  String name ="Длинный лук";

  @override
  Damage? dmg=Damage(DiceType.D8, DamageType.Piercing);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}


final class Blowgun with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 10);



  @override
  double weight=1;

  @override
  Set<WeaponType> type={WeaponType.Blowgun,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Reload,};

  @override
  String name ="Духовая трубка";

  @override
  Damage? dmg=Damage.constint(1);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}

final class Musket with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 500);



  @override
  double weight=10;

  @override
  Set<WeaponType> type={WeaponType.Musket,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Reload,WearponProperty.TwoHanded};

  @override
  String name ="Мушкет";

  @override
  Damage? dmg=Damage(DiceType.D12, DamageType.Piercing);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}



final class AutoPistol with DefaultQty implements Weapon,Ammo,Multishot{
  @override
  Price price = Price(gold: 0);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Musket,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Multishot};

  @override
  String name ="Пистолет, автоматический";

  @override
  Damage? dmg=Damage(DiceType.D6, DamageType.Piercing,da: 2);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  int hasshots=6;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}

final class Pistol with DefaultQty implements Weapon,Ammo{
  @override
  Price price = Price(gold: 250);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Pistol,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Ammo,WearponProperty.Reload};

  @override
  String name ="Пистоль";

  @override
  Damage? dmg=Damage(DiceType.D10, DamageType.Piercing);

  @override
  int? distance;

  @override
  SellableItem? ammo;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;

}

final class Net with DefaultQty implements Weapon,Special,Thrown{
  @override
  Price price = Price(gold: 1);



  @override
  double weight=3;

  @override
  Set<WeaponType> type={WeaponType.Net,WeaponType.MartialWearpon,WeaponType.Distant};

  @override
  Set<WearponProperty> props={WearponProperty.Special,WearponProperty.Thrown};

  @override
  String name ="Сеть";

  @override
  Damage? dmg=Damage.constint(0);

  @override
  int? distance;

  @override
  Meta meta=Meta();

  @override
  bool isEquiped=false;


}
final class Arrow  implements SellableItem {
  @override
  String name = "стрела";

  @override
  Price price=Price(gold: 1);

  @override
  double weight=1;

  @override
  int qty=20;

}


final class CrossBowBolt  implements SellableItem {
  @override
  String name = "Болт";

  @override
  Price price=Price(gold: 1);

  @override
  double weight=1.5;

  @override
  int qty=20;

}