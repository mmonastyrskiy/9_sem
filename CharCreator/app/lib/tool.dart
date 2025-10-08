// ignore_for_file: constant_identifier_names


import 'package:flutter/src/widgets/framework.dart';

import 'stat.dart';
import 'meta.dart';
import 'ui/uicore.dart';
import 'ui/uisnippets.dart';
import 'snippets.dart';
enum ToolsNames{
  Thieves_Tools,
  Gaming_Set,
  Nav_Tools,
  Poisoning_Tools,
  Artisans_Tools,
  Musical_Instruments,
  Disguise_Kit,
  Forgery_Kit,
  Herbalism_Kit,
  Water_Transport,
  Ground_Transport

}
final class ToolSkill implements Stat,Pickable{
  late final ToolsNames tooltype;
  Meta metadata = Meta();


  ToolSkill(String sk, [Set<MetaFlags>? meta]){
    switch(sk.toLowerCase()){
      case "воровские инструменты": tooltype = ToolsNames.Thieves_Tools;
      case "игровой набор":tooltype = ToolsNames.Gaming_Set;
      case "инструменты навигатора":tooltype = ToolsNames.Nav_Tools;
      case "инструменты отравителя": tooltype =ToolsNames.Poisoning_Tools;
      case "инструменты ремесленников": tooltype = ToolsNames.Artisans_Tools;
      case "музыкальные инструменты": tooltype = ToolsNames.Musical_Instruments;
      case "набор для грима": tooltype = ToolsNames.Disguise_Kit;
      case "набор для фальсификации": tooltype = ToolsNames.Forgery_Kit;
      case "водный транспорт": tooltype = ToolsNames.Water_Transport;
      case "наземный транспорт":tooltype = ToolsNames.Ground_Transport;
      default: throw ArgumentError('Unknown tool type');
    }
    metadata.MetaFlags_ = meta!;
  }

// TODO ML
 
 static void deletebyMeta(Set<ToolSkill>? tools,MetaFlags m){
    for(ToolSkill l in tools!){
      if (l.metadata.MetaFlags_.contains(m)){
        tools.remove(l);
      }
    }
  }


static Map<String,ToolsNames> str2toolskill(){
  return {
     "воровские инструменты":  ToolsNames.Thieves_Tools,
      "инструменты навигатора": ToolsNames.Nav_Tools,
      "игровой набор":ToolsNames.Gaming_Set,
      "инструменты отравителя": ToolsNames.Poisoning_Tools,
      "инструменты ремесленников": ToolsNames.Artisans_Tools,
      "музыкальные инструменты": ToolsNames.Musical_Instruments,
      "набор для грима": ToolsNames.Disguise_Kit,
      "набор для фальсификации":ToolsNames.Forgery_Kit,
      "водный транспорт": ToolsNames.Water_Transport,
      "наземный транспорт":ToolsNames.Ground_Transport
  };
}
  @override
  Set<String> menu=str2toolskill().keys.toSet();

  @override
  Set ret=str2toolskill().values.toSet();

  @override
  String? pick(BuildContext bc,[Set? include]) {
     
    Map<String, dynamic> c =CoupleMaker.CMtoMap(menu, ret);
    if(include != null){
  for (dynamic elem in include){
    c.removeWhere((key, value) => value != elem);
  }
}
    String chosen = ModalDispatcher.showListPicker(bc, c);
    return chosen;
  }
  

  @override
    Set<String>? pickmany(BuildContext bc, [List<String>? initialSelections,int? howmany=2, Set? include]) {

Map<String, dynamic> c =CoupleMaker.CMtoMap(menu, ret);
if(include != null){
  for (dynamic elem in include){
    c.removeWhere((key, value) => value != elem);
  }
}

    Set<String> opt ={};
    Set<String> res = ModalDispatcher.showMultiSelectListPicker(context: bc, items: c,initialSelections: initialSelections) as Set<String>;
    if (res.length != howmany){
      while(opt.length != howmany){

      
      //TODO: Switch to modal error
    print("Select $howmany");
    opt = ModalDispatcher.showMultiSelectListPicker(context: bc, items: c,initialSelections: res.toList()) as Set<String>;
    }
    return opt;
    }
    return res;
    }
  }