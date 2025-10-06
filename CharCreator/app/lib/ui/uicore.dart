import 'package:flutter/material.dart';

abstract interface class Pickable{
  Set<String> menu={};
  Set<dynamic> ret={};
  String? pick(BuildContext bc){
    return null;
  }
}