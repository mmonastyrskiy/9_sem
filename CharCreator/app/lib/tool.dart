// ignore_for_file: constant_identifier_names

import 'stat.dart';
import 'meta.dart';
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
final class ToolSkill implements Stat{
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
      default: tooltype = ToolsNames.Herbalism_Kit;
      metadata.MetaFlags_ = meta!;
    }
  }

  @override
  int hasprofbounus=-1;
// TODO ML
// TODO Типы музыкальных инструментов
 
 static void deletebyMeta(Set<ToolSkill>? tools,MetaFlags m){
    for(ToolSkill l in tools!){
      if (l.metadata.MetaFlags_.contains(m)){
        tools.remove(l);
      }
    }
  }

 }