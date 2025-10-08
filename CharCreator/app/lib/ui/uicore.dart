import 'package:flutter/material.dart';

abstract interface class Pickable{
  Set<String> menu={};
  Set<dynamic> ret={};
  String? pick(BuildContext bc){
    return null;
  }
  Set<String>? pickmany(BuildContext bc,[ List<String>? initialSelections,int howmany=2]){
  return null;  
  }
  
}