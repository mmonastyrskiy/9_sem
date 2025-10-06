// ignore_for_file: constant_identifier_names

import 'stat.dart';
enum ToolsNames{
  Thieves_Tools,
  Gaming_Set,
  Nav_Tools,
  Poisoning_Tools,
  Artisans_Tools,
  Musical_Instruments,
  Disguise_Kit,
  Forgery_Kit,
  Herbalism_Kit

}
final class ToolSkill implements Stat{
  late  final ToolsNames tooltype;

  ToolSkill(String sk){
    switch(sk.toLowerCase()){
      case "воровские инструменты": tooltype = ToolsNames.Thieves_Tools;
      case "игровой набор":tooltype = ToolsNames.Gaming_Set;
      case "инструменты навигатора":tooltype = ToolsNames.Nav_Tools;
      case "инструменты отравителя": tooltype =ToolsNames.Poisoning_Tools;
      case "инструменты ремесленников": tooltype = ToolsNames.Artisans_Tools;
      case "музыкальные инструменты": tooltype = ToolsNames.Musical_Instruments;
      case "набор для грима": tooltype = ToolsNames.Disguise_Kit;
      case "набор для фальсификации": tooltype = ToolsNames.Forgery_Kit;
      default: tooltype = ToolsNames.Herbalism_Kit;
    }
  }

  @override
  int hasprofbounus=-1;
// TODO ML
// TODO Типы музыкальных инструментов
 
 static void remove (ToolsNames name,Set<ToolSkill> tools){
      for (ToolSkill ts in tools){
      if(ts.tooltype == name){
        tools.remove(ts);
      }
    }
 }

 }