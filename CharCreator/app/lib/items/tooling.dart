import 'package:flutter_application_1/items/item.dart';
import 'package:flutter_application_1/meta.dart';
import 'package:flutter_application_1/money.dart';

abstract interface class Tooling implements SellableItem,HasMeta {

}


abstract interface class ArtisanTools implements SellableItem,HasMeta {

}

final class DisguiseKit with DefaultQty implements Tooling {
  @override
  String name="Набор для грима";

  @override
  Price price=Price(gold: 25);

  @override
  double weight=3;

  @override
  Meta meta=Meta();

}


final class ThievesTools with DefaultQty implements Tooling {
  @override
  String name="Воровские инструменты";

  @override
  Price price=Price(gold: 25);

  @override
  double weight=1;

  @override
  Meta meta=Meta();

}





final class HerbalismKit with DefaultQty implements Tooling {
  @override
  String name="Набор травника";

  @override
  Price price=Price(gold: 5);

  @override
  double weight=3;

  @override
  Meta meta=Meta();

}


final class DiceSet with DefaultQty implements Tooling {
  @override
  String name="Набор игровых костей";

  @override
  Price price=Price(silver: 1);

  @override
  double weight=0;

  @override
  Meta meta=Meta();

}

final class PlayingCardSet with DefaultQty implements Tooling {
  @override
  String name="Игральные карты";

  @override
  Price price=Price(silver: 5);

  @override
  double weight=0;

  @override
  Meta meta=Meta();

}



final class AlchemistsSupplies with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты алхимика";

  @override
  Price price=Price(gold: 50);

  @override
  double weight=8;

  @override
  Meta meta=Meta();

}



final class PottersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты гончара";

  @override
  Price price=Price(gold: 10);

  @override
  double weight=3;

  @override
  Meta meta=Meta();

}



final class TinkersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты жестянщика (ремонтный)";

  @override
  Price price=Price(gold: 50);

  @override
  double weight=10;

  @override
  Meta meta=Meta();

}


final class CalligraphersSupplies with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты каллиграфа";

  @override
  Price price=Price(gold: 10);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}

final class MasonsTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты каменщика";

  @override
  Price price=Price(gold: 10);

  @override
  double weight=8;

  @override
  Meta meta=Meta();

}




final class CartographersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты картографа";

  @override
  Price price=Price(gold: 15);

  @override
  double weight=6;

  @override
  Meta meta=Meta();

}





final class LeatherworkersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты кожевника";

  @override
  Price price=Price(gold: 5);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}


final class SmithsTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты кузнеца";

  @override
  Price price=Price(gold: 20);

  @override
  double weight=8;

  @override
  Meta meta=Meta();

}



final class BrewersSupplies with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты пивовара";

  @override
  Price price=Price(gold: 20);

  @override
  double weight=8;

  @override
  Meta meta=Meta();

}




final class CarpentersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты плотника";

  @override
  Price price=Price(gold: 8);

  @override
  double weight=6;

  @override
  Meta meta=Meta();

}




final class CookUtensils with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты повара";

  @override
  Price price=Price(gold: 1);

  @override
  double weight=8;

  @override
  Meta meta=Meta();

}




final class WoodcarversTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты резчика по дереву";

  @override
  Price price=Price(gold: 1);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}




final class CobblersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты сапожника";

  @override
  Price price=Price(gold: 5);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}





final class GlassblowersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты стеклодува";

  @override
  Price price=Price(gold: 30);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}



final class WeaversTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты ткача";

  @override
  Price price=Price(gold: 1);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}



final class PaintersSupplies with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты художника";

  @override
  Price price=Price(gold: 10);

  @override
  double weight=5;

  @override
  Meta meta=Meta();

}




final class JewelersTools with DefaultQty implements ArtisanTools {
  @override
  String name="Инструменты ювелира";

  @override
  Price price=Price(gold: 25);

  @override
  double weight=2;

  @override
  Meta meta=Meta();

}