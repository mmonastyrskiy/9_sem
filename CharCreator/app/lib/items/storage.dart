import 'package:flutter_application_1/items/item.dart';

abstract interface class Storage implements SellableItem {
List<SellableItem> items=[];
double currentweight= 0;
double size = 300;
bool add(SellableItem item) ;
bool del(SellableItem item) ;

}
double MAX_SIZE = 10000;