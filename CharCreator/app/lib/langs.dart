// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'stat.dart';
import 'ui/uicore.dart';
import 'snippets.dart';
import 'ui/uisnippets.dart';
import 'meta.dart';
enum LangsNames {
  Common,
  Dwarvish,
  Elvish,
  Giant,
  Gnomish,
  Goblin,
  Halfling,
  Orc,
  Abyssal,
  Celestial,
  Draconic,
  Deep_Speech,
  Infernal,
  Primordial,
  Sylvan,
  Undercommon,



}
final class Langs implements Stat,Pickable {
  late final LangsNames lang;
  Meta metadata = Meta(); 

  Langs(String l, [Set<MetaFlags>? metadata]){
    switch(l.toLowerCase()) {
  case "общий": lang = LangsNames.Common;
  case "дварфийский": lang = LangsNames.Dwarvish;
  case "эльфийский": lang = LangsNames.Elvish;
  case "великаний": lang = LangsNames.Giant;
  case "гномий": lang = LangsNames.Gnomish;
  case "гоблинский": lang = LangsNames.Goblin;
  case "полуросликов": lang = LangsNames.Halfling;
  case "орочий": lang = LangsNames.Orc;
  case "бездны": lang = LangsNames.Abyssal;
  case "небесный": lang = LangsNames.Celestial;
  case "драконий": lang = LangsNames.Draconic;
  case "глубинная речь": lang = LangsNames.Deep_Speech;
  case "инферальный": lang = LangsNames.Infernal;
  case "первичный": lang = LangsNames.Primordial;
  case "силван": lang = LangsNames.Sylvan;
  case "подземный": lang = LangsNames.Undercommon;
  default: lang = LangsNames.Common; // Значение по умолчанию
  }
  if(metadata != null){
  this.metadata.MetaFlags_ = metadata;
  }
  }
  static void deletebyMeta(Set<Langs>? langs,MetaFlags m){
    for(Langs l in langs!){
      if (l.metadata.MetaFlags_.contains(m)){
        langs.remove(l);
      }
    }
  }
  
  @override
  Set<String> menu ={"общий","дварфийский","эльфийский","великаний","гномий","гоблинский","полуросликов","орочий","бездны",
  "небесный","драконий","глубинная речь","инферальный","первичный","силван","подземный"};
  
  @override
  Set ret = {LangsNames.Common,LangsNames.Dwarvish,LangsNames.Elvish,LangsNames.Giant,LangsNames.Gnomish,LangsNames.Goblin,
  LangsNames.Halfling,LangsNames.Orc,LangsNames.Abyssal,LangsNames.Celestial,LangsNames.Draconic,LangsNames.Deep_Speech,
  LangsNames.Infernal,LangsNames.Primordial,LangsNames.Sylvan,LangsNames.Undercommon};
  
  @override
  String? pick(BuildContext context) {
    Map<String, dynamic> c =CoupleMaker.CMtoMap(menu, ret);
    String chosen = ModalDispatcher.showListPicker(context, c);
    return chosen;
  }
    @override
      Future<Set<String>>? pickmany (BuildContext context,[List<String>? initialSelections, int howmany=2])async {
    Map<String, dynamic> c =CoupleMaker.CMtoMap(menu, ret);
    Set<String> res = ModalDispatcher.showMultiSelectListPicker(context: context, items: c,initialSelections: initialSelections) as Set<String>;
    if (res.length != howmany){

    PopUpDispatcher.showErrorDialog(context,"Select $howmany");
    pickmany(context);
    }
    return res;
    }
    

    



  }