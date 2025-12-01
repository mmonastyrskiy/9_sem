// ignore_for_file: constant_identifier_names

import "package:flutter_application_1/money.dart";

import "storage.dart";
import 'item.dart';
import '../meta.dart';

enum MiscItems{
  Chest,
  CaseMapOrScroll,
  FineClothes,
  Ink,
  InkPen,
  OilFlask,
  Paper,
  Lamp,
  Soap,
  Backpack,
  Perfume,
  SealingWax,
  Bedroll,
  CostumeClothes,
  Candle,
  Ration,
  Waterskin

}

final class Chest with DefaultQty implements Storage, SellableItem,HasMeta {
  @override
  double currentweight= 0;

  @override
  List<SellableItem> items= [];

  @override
  double size = 300;

  @override
  bool add(SellableItem item) {
    if(currentweight + item.weight <= size){
      currentweight += item.weight;
      weight +=item.weight;
      items.add(item);
      return true;
    }
    return false;
  }

  @override
  bool del(SellableItem item) {

    throw UnimplementedError();
  }

  @override
  Price price =Price(gold: 5);

  @override
  double weight =25;

  @override
  Meta meta=Meta();

  @override
  String name="Сундук";

}
 final class CaseMapOrScroll with DefaultQty implements Storage,SellableItem,HasMeta {
  @override
  double currentweight=0;
 
  @override
  List<SellableItem> items=[];
 
  @override
  Price price=Price(gold:1);
 
  @override
  double size=MAX_SIZE;
 
  @override
  double weight=1;
 
  @override
  bool add(SellableItem item) {
    // TODO: implement add ограничение на тип предмета указываем здесь 
    throw UnimplementedError();
  }
 
  @override
  bool del(SellableItem item) {
    throw UnimplementedError();
  }

  @override
  Meta meta=Meta();

  @override
  String name="Контейнер для карт и свитков";
 }
 final class FineClothes with DefaultQty implements SellableItem,HasMeta {
  @override
  Price price=Price(gold: 15);
 
  @override
  double weight=6;

  @override
  Meta meta=Meta();

  @override
  String name="Комплект отличной одежды";

 }
 final class Ink with DefaultQty implements SellableItem{
  @override
  Price price=Price(gold:10);
 
  @override
  double weight=0.07;

  @override
  String name="Чернила";

 }
 final class InkPen with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(copper:2);
 
  @override
  double weight=0;

  @override
  String name="Писчее перо";

  @override
  Meta meta=Meta();

 }
  final class Lamp with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=1;

  @override
  String name="Лампа";

  @override
  Meta meta=Meta();

 }
  final class OilFlask with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=1;

  @override
  String name="Фляга масла";

  @override
  Meta meta=Meta();

 }
   final class Paper with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:2);
 
  @override
  double weight=0;

  @override
  String name="Лист бумаги";

  @override
  Meta meta=Meta();

 }


final class Perfume with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:5);
 
  @override
  double weight=0;

  @override
  String name="Духи (флакон)";

  @override
  Meta meta=Meta();

 }

 final class SealingWax with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=0;

  @override
  String name="Воск (сургуч)";

  @override
  Meta meta=Meta();

 }
 final class Soap with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(copper:2);
 
  @override
  double weight=0;

  @override
  String name="Мыло";

  @override
  Meta meta=Meta();

 }
 final class Backpack with DefaultQty implements Storage, SellableItem,HasMeta {
  @override
  double currentweight= 0;

  @override
  List<SellableItem> items= [];

  @override
  double size = 30;

  @override
  bool add(SellableItem item) {
    if(currentweight + item.weight <= size){
      currentweight += item.weight;
      weight +=item.weight;
      items.add(item);
      return true;
    }
    return false;
  }

  @override
  bool del(SellableItem item) {

    throw UnimplementedError();
  }

  @override
  Price price =Price(gold: 2);

  @override
  double weight =5;

  @override
  Meta meta=Meta();

  @override
  String name="Рюкзак";

}

final class Bedroll with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:1);
 
  @override
  double weight=7;

  @override
  String name="Спальник (спальный мешок)";

  @override
  Meta meta=Meta();

 }

final class CostumeClothes with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:5);
 
  @override
  double weight=4;

  @override
  String name="Комплект одежды (костюм)";

  @override
  Meta meta=Meta();

 }

 final class Candle with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(copper:1);
 
  @override
  double weight=0;

  @override
  String name="Свеча";

  @override
  Meta meta=Meta();

 }


  final class Ration with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=2;

  @override
  String name="Рацион";

  @override
  Meta meta=Meta();

 }

 final class Waterskin with DefaultQty implements Storage, SellableItem,HasMeta {
  @override
  double currentweight= 0;

  @override
  List<SellableItem> items= [];

  @override
  double size = 30;

  @override
  bool add(SellableItem item) {
    if(currentweight + item.weight <= size){
      currentweight += item.weight;
      weight +=item.weight;
      items.add(item);
      return true;
    }
    return false;
  }

  @override
  bool del(SellableItem item) {

    throw UnimplementedError();
  }

  @override
  Price price =Price(gold: 2);

  @override
  double weight =5;

  @override
  Meta meta=Meta();

  @override
  String name="Бурдюк";

}

  final class MetallBall implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:1);
 
  @override
  double weight=2;

  @override
  String name="Металлические шарики";

  @override
  Meta meta=Meta();

  @override
  int qty=1000;

 }


 final class Bell with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:1);
 
  @override
  double weight=0;

  @override
  String name="Колокольчик";

  @override
  Meta meta=Meta();

 }

 final class Crowbar with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:2);
 
  @override
  double weight=5;

  @override
  String name="Ломик";

  @override
  Meta meta=Meta();

 }

 final class Hammer with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:1);
 
  @override
  double weight=3;

  @override
  String name="Молоток";

  @override
  Meta meta=Meta();

 }


 final class Piton with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(copper:1);
 
  @override
  double weight=0.25;

  @override
  String name="Шлямбур (колышек)";

  @override
  Meta meta=Meta();

 }

 final class HoodedLantern with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:5);
 
  @override
  double weight=2;

  @override
  String name="Фонарь, закрытый";

  @override
  Meta meta=Meta();

 }

 final class Tinderbox with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=1;

  @override
  String name="Трутница";

  @override
  Meta meta=Meta();

 }


 final class HempenRope with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:1);
 
  @override
  double weight=10;

  @override
  String name="Верёвка пеньковая";

  @override
  Meta meta=Meta();

 }

 final class Torch with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(copper:1);
 
  @override
  double weight=1;

  @override
  String name="Факел";

  @override
  Meta meta=Meta();

 }

 final class MessKit with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:2);
 
  @override
  double weight=1;

  @override
  String name="Столовый набор";

  @override
  Meta meta=Meta();

 }

  final class Blanket with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:5);
 
  @override
  double weight=3;

  @override
  String name="Одеяло";

  @override
  Meta meta=Meta();

 }

 final class Book with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:25);
 
  @override
  double weight=5;

  @override
  String name="Книга";

  @override
  Meta meta=Meta();

 }

  final class Parchment with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(silver:1);
 
  @override
  double weight=5;

  @override
  String name="Пергамент";

  @override
  Meta meta=Meta();

 }

  final class Shovel with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:2);
 
  @override
  double weight=5;

  @override
  String name="Лопата";

  @override
  Meta meta=Meta();

 }


 final class ComponentPouch with DefaultQty implements SellableItem,HasMeta{
  @override
  Price price=Price(gold:25);
 
  @override
  double weight=2;

  @override
  String name="Мешочек с компонентами";

  @override
  Meta meta=Meta();

 }