import 'package:flutter_application_1/items/item.dart';
import 'package:flutter_application_1/meta.dart';
import 'package:flutter_application_1/money.dart';

abstract interface class Musicalinstruments implements SellableItem {

}
final class Drum with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Барабан";

  @override
  Price price=Price(gold: 6);

  @override
  double weight=3;

  @override
  Meta meta=Meta();

}



final class Viol with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Виола";

  @override
  Price price=Price(gold: 30);

  @override
  double weight=1;

  @override
  Meta meta=Meta();

}


final class Bagpipes with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Волынка";

  @override
  Price price=Price(gold: 30);

  @override
  double weight=6;

  @override
  Meta meta=Meta();

}


final class Lyre with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Лира";

  @override
  Price price=Price(gold: 30);

  @override
  double weight=2;

  @override
  Meta meta=Meta();

}

final class Lute with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Лютня";

  @override
  Price price=Price(gold: 35);

  @override
  double weight=2;

  @override
  Meta meta=Meta();

}

final class Horn with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Рожок";

  @override
  Price price=Price(gold: 3);

  @override
  double weight=2;

  @override
  Meta meta=Meta();

}




final class PanFlute with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Свирель";

  @override
  Price price=Price(gold: 3);

  @override
  double weight=2;

  @override
  Meta meta=Meta();

}


final class Flute with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Флейта";

  @override
  Price price=Price(gold: 2);

  @override
  double weight=1;

  @override
  Meta meta=Meta();

}



final class Dulcimer with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Цимбалы";

  @override
  Price price=Price(gold: 25);

  @override
  double weight=10;

  @override
  Meta meta=Meta();

}


final class Shawm with DefaultQty implements Musicalinstruments,HasMeta{
  @override
  String name="Шалмей";

  @override
  Price price=Price(gold: 2);

  @override
  double weight=1;

  @override
  Meta meta=Meta();

}