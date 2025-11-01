import 'package:flutter_application_1/items/item.dart';
import 'package:flutter_application_1/items/misc.dart';
import 'package:flutter_application_1/items/tooling.dart';
import 'package:flutter_application_1/meta.dart';
import 'package:flutter_application_1/money.dart';
import 'package:flutter_application_1/items/storage.dart';

abstract interface class Pack implements Storage,SellableItem,HasMeta {}

final class EntertainersPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Backpack(),Bedroll(),CostumeClothes(),Candle().setqty(5),Ration().setqty(5),
                            Waterskin(),DisguiseKit()];

  @override
  String name="Набор артиста";

  @override
  Price price=Price(gold: 40);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}


final class BurglarsPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[MetallBall(),Bell(),Candle().setqty(5),Crowbar(),Hammer(),Piton().setqty(10),
                            HoodedLantern(),OilFlask().setqty(2),Ration().setqty(5),Tinderbox(),Waterskin()];

  @override
  String name="Набор взломщика";

  @override
  Price price=Price(gold: 16);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}


final class DiplomatsPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Chest(),CaseMapOrScroll().setqty(2),FineClothes(),Ink(),InkPen(),Lamp(),OilFlask().setqty(2),
                            Paper().setqty(5),Perfume(),SealingWax(),Soap()];

  @override
  String name="Набор дипломата";

  @override
  Price price=Price(gold: 39);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}




final class DungeroneersPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Backpack(),Crowbar(),Hammer(),Piton().setqty(10),Torch().setqty(10),Tinderbox(),
                            Ration().setqty(10),Waterskin()];

  @override
  String name="Набор исследователя подземелий";

  @override
  Price price=Price(gold: 12);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}



final class ExplorersPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Backpack(),Bedroll(),MessKit(),Tinderbox(),Torch().setqty(10),Ration().setqty(10),Waterskin()];

  @override
  String name="Набор путешественника";

  @override
  Price price=Price(gold: 10);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}





final class PriestsPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Backpack(),Blanket(),Candle().setqty(10),Tinderbox(),Ration().setqty(2),Waterskin()];

  @override
  String name="Набор священника";

  @override
  Price price=Price(gold: 19);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}


final class ScholarsPack with DefaultQty implements Pack{
  @override
  double currentweight=MAX_SIZE;

  @override
  List<SellableItem> items=[Backpack(),Ink(),InkPen(),Parchment().setqty(10),Book()];

  @override
  String name="Набор Ученого";

  @override
  Price price=Price(gold:40);

  @override
  double size=MAX_SIZE;

  @override
  double weight=MAX_SIZE;

  @override
  bool add(SellableItem item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  bool del(SellableItem item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

}