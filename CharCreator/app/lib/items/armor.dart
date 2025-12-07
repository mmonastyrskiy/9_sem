// ignore_for_file: non_constant_identifier_names, unused_local_variable
// ignore_for_file: constant_identifier_names

import 'item.dart';
import '../money.dart';
import '../meta.dart';
import '../stat.dart';
import '../character.dart';


enum ArmorType {
  
  Light,    // Легкая броня - обеспечивает базовую защиту, не ограничивает движения
  Medium,   // Средняя броня - баланс между защитой и подвижностью
  Heavy,    // Тяжелая броня - максимальная защита, но ограничивает подвижность
  Shield,    // Щит - дополнительная защита, обычно используется в одной руке
  PaddedArmor,
  LeatherArmor,
  StuddedLeatherArmor,
  HideArmor,
  ChainShirt,
  ScaleMailArmor,
  Breastplate,
  HalfPlateArmor,
  RingMailArmor,
  ChainMail,
  SplintArmor,
  PlateArmor;

    String get displayName => switch (this) {
    ArmorType.Light => "Легкая броня",
    ArmorType.Medium => "Средняя броня",
    ArmorType.Heavy => "Тяжелая броня",
    ArmorType.Shield => "Щит",
    ArmorType.PaddedArmor => "Стеганая броня",
    ArmorType.LeatherArmor => "Кожаная броня",
    ArmorType.StuddedLeatherArmor => "Кожаная броня с заклепками",
    ArmorType.HideArmor => "Броня из шкур",
    ArmorType.ChainShirt => "Кольчужная рубаха",
    ArmorType.ScaleMailArmor => "Чешуйчатый доспех",
    ArmorType.Breastplate => "Кираса",
    ArmorType.HalfPlateArmor => "Полулаты",
    ArmorType.RingMailArmor => "Кольчатый доспех",
    ArmorType.ChainMail => "Кольчуга",
    ArmorType.SplintArmor => "Пластинчатый доспех",
    ArmorType.PlateArmor => "Латный доспех",
  };
  
  @override
  String toString() => displayName;
}

enum ArmorProperty {
  AffectsStealth,
  RequireStrength
}

abstract interface class RequireStrength {
  int req = 0;
  bool can(int STR) => STR >= req;
} 

abstract interface class Armor implements SellableItem {
  List<ArmorType> type= [];
  int? ArmorModifier;
  @override
  String name ="";
  Meta meta =Meta();
  bool isEquiped = false;
  Set<ArmorProperty> props={};

  



  Armor(Character c,String chosen ){
    Set<AbstractArmor> CanUseArmor = c.CanUseArmor;
    int DEXmod = c.getbasicstats()[BasicStatNames.DEX]!.mod;
    int STR = c.getbasicstats()[BasicStatNames.STR]!.value;
  }
}
final class PaddedArmor with DefaultQty implements Armor{
  PaddedArmor(int DEXmod){
    ArmorModifier = DEXmod +11;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Стёганный доспех";

  @override
  Price price = Price(gold: 5);

  @override
  List<ArmorType> type = [ArmorType.Light];

  @override
  double weight = 8;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth};



}

final class LeatherArmor with DefaultQty implements Armor{
  LeatherArmor(int DEXmod){
    ArmorModifier = DEXmod +11;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Кожаный доспех";

  @override
  Price price = Price(gold: 10);

  @override
  List<ArmorType> type = [ArmorType.Light];

  @override
  double weight = 10;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};



}

final class StuddedLeatherArmor with DefaultQty implements Armor{
  StuddedLeatherArmor(int DEXmod){
    ArmorModifier = DEXmod +12;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Проклёпанная кожа";

  @override
  Price price = Price(gold: 45);

  @override
  List<ArmorType> type = [ArmorType.Light];

  @override
  double weight = 13;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};


}



final class HideArmor with DefaultQty implements Armor{
  HideArmor(int DEXmod){
    DEXmod <= 2 ? ArmorModifier = DEXmod +12 :  ArmorModifier = 2 +12;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Шкурный доспех";

  @override
  Price price = Price(gold: 10);

  @override
  List<ArmorType> type = [ArmorType.Medium];

  @override
  double weight = 12;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};


}


final class ChainShirt with DefaultQty implements Armor{
  ChainShirt(int DEXmod){
    DEXmod <= 2 ? ArmorModifier = DEXmod +13 :  ArmorModifier = 2 +13;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Кольчужная рубаха";

  @override
  Price price = Price(gold: 50);

  @override
  List<ArmorType> type = [ArmorType.Medium];

  @override
  double weight = 20;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};


}

final class ScaleMailArmor with DefaultQty implements Armor{
  ScaleMailArmor (int DEXmod){
    DEXmod <= 2 ? ArmorModifier = DEXmod +14 :  ArmorModifier = 2 +14;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Чешуйчатый доспех";

  @override
  Price price = Price(gold: 50);

  @override
  List<ArmorType> type = [ArmorType.Medium];

  @override
  double weight = 45;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth};


}


final class Breastplate with DefaultQty implements Armor{
  Breastplate (int DEXmod){
    DEXmod <= 2 ? ArmorModifier = DEXmod +14 :  ArmorModifier = 2 +14;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Кираса";

  @override
  Price price = Price(gold: 400);

  @override
  List<ArmorType> type = [ArmorType.Medium];

  @override
  double weight = 20;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};


}

final class HalfPlateArmor with DefaultQty implements Armor{
  HalfPlateArmor (int DEXmod){
    DEXmod <= 2 ? ArmorModifier = DEXmod +15 :  ArmorModifier = 2 +15;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Полулаты";

  @override
  Price price = Price(gold: 750);

  @override
  List<ArmorType> type = [ArmorType.Medium];

  @override
  double weight = 40;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth};


}

final class RingMailArmor with DefaultQty implements Armor{
  RingMailArmor (){
    ArmorModifier = 14;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Кольчатый доспех";

  @override
  Price price = Price(gold: 30);

  @override
  List<ArmorType> type = [ArmorType.Heavy];

  @override
  double weight = 40;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth};


}

final class ChainMail with DefaultQty implements Armor,RequireStrength{
  ChainMail (int STR){
    ArmorModifier = 16;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Кольчуга";

  @override
  Price price = Price(gold: 75);

  @override
  List<ArmorType> type = [ArmorType.Heavy];

  @override
  double weight = 55;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth,ArmorProperty.RequireStrength};
  
  @override
  int req=13;
  
  @override
  bool can(int STR) => STR >= req;


}


final class SplintArmor with DefaultQty implements Armor,RequireStrength{
  SplintArmor (int STR){
    ArmorModifier = 17;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Наборный доспех";

  @override
  Price price = Price(gold: 200);

  @override
  List<ArmorType> type = [ArmorType.Heavy];

  @override
  double weight = 60;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth,ArmorProperty.RequireStrength};
  
  @override
  int req=15;
  
  @override
  bool can(int STR) => STR >= req;


}


final class PlateArmor with DefaultQty implements Armor,RequireStrength{
  PlateArmor (int STR){
    ArmorModifier = 18;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Латы";

  @override
  Price price = Price(gold: 1500);

  @override
  List<ArmorType> type = [ArmorType.Heavy];

  @override
  double weight = 65;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={ArmorProperty.AffectsStealth,ArmorProperty.RequireStrength};
  
  @override
  int req=15;
  
  @override
  bool can(int STR) => STR >= req;


}

final class Shield with DefaultQty implements Armor{
  Shield(){
    ArmorModifier = 2;
  }
  @override
  int? ArmorModifier;

  @override
  Meta meta = Meta();

  @override
  String name = "Щит";

  @override
  Price price = Price(gold: 10);

  @override
  List<ArmorType> type = [ArmorType.Shield];

  @override
  double weight = 6;
  
  @override
  bool isEquiped = false;

  @override
  Set<ArmorProperty> props={};



}
