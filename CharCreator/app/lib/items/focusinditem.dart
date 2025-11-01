import 'package:flutter_application_1/items/item.dart';
import 'package:flutter_application_1/meta.dart';
import 'package:flutter_application_1/money.dart';

abstract interface class Focusingitem implements HasMeta, SellableItem {}


abstract interface class DruidicFocusingitem implements HasMeta, SellableItem {}

final class Amulet with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Амулет";

  @override
  Price price=Price(gold: 5);


  @override
  double weight=1;

}



final class Wand with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Волшебная палочка";

  @override
  Price price=Price(gold: 10);


  @override
  double weight=1;

}


final class Rod with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Жезл";

  @override
  Price price=Price(gold: 10);


  @override
  double weight=2;

}



final class Crystal with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Кристалл";

  @override
  Price price=Price(gold: 10);


  @override
  double weight=1;

}




final class Staff with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Посох";

  @override
  Price price=Price(gold: 5);


  @override
  double weight=4;

}





final class Reliquary with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Реликварий";

  @override
  Price price=Price(gold: 5);


  @override
  double weight=2;

}





final class Orb with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Сфера";

  @override
  Price price=Price(gold: 20);


  @override
  double weight=3;

}


final class Emblem with DefaultQty implements Focusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Эмблема";

  @override
  Price price=Price(gold: 5);


  @override
  double weight=0;

}

final class Sprigofmistletoe with DefaultQty implements DruidicFocusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Веточка омелы";

  @override
  Price price=Price(gold: 1);


  @override
  double weight=0;

}

final class Woodenstaff with DefaultQty implements DruidicFocusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Деревянный посох";

  @override
  Price price=Price(gold: 5);


  @override
  double weight=4;

}


final class Yewwand with DefaultQty implements DruidicFocusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Тисовая палочка";

  @override
  Price price=Price(gold: 10);


  @override
  double weight=1;

}

final class Totem with DefaultQty implements DruidicFocusingitem{
  @override
  Meta meta=Meta();

  @override
  String name="Тотем";

  @override
  Price price=Price(gold: 1);


  @override
  double weight=0;

}