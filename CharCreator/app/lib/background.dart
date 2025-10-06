// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
enum BackgroundNames  {
  Entertainer,
  Urchin,
  Noble,
  Guild_artisan,
  Sailor,
  Sage,
  Folk_Hero,
  Hermit,


}
abstract class Background implements AffectsStat,Stat {
  factory Background(String chosen, Map<StatNames,Stat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context)
  {
    switch(chosen.toLowerCase()){
      case "артист": return Entertainer(stats, tools, langs,context);
      default: return Noble(stats, tools,langs,context);

    }
  
}

}
final class Entertainer implements Background {
  @override
  void apply(Map<StatNames,Stat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context) {
    stats[StatNames.Acrobatics]?.hasprofbounus+= 1;
    stats[StatNames.Performance]?.hasprofbounus+= 1;
    tools.add(ToolSkill("Набор для грима"));
    tools.add(ToolSkill("музыкальные инструменты"));
    
    


  }

  @override
  void delete(Map<StatNames,Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Acrobatics]?.hasprofbounus-= 1;
    stats[StatNames.Performance]?.hasprofbounus-= 1;
    ToolSkill.remove(ToolsNames.Musical_Instruments, tools);
    ToolSkill.remove(ToolsNames.Disguise_Kit, tools);
  }
  Entertainer(Map<StatNames,Stat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
    apply(stats, tools,langs,context);
  }

  @override
  int hasprofbounus=-1;


}
final class Urchin implements Background {
  @override
  int hasprofbounus=-1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    stats[StatNames.Stealth]?.hasprofbounus +=1;
    tools.add(ToolSkill("Набор для грима"));
    tools.add(ToolSkill("воровские инструменты"));
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Stealth]?.hasprofbounus -=1;
    ToolSkill.remove(ToolsNames.Thieves_Tools, tools);
    ToolSkill.remove(ToolsNames.Disguise_Kit, tools);
  }
  Urchin(Map<StatNames,Stat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
  apply(stats,tools,langs,context);
  }
}
final class Noble implements Background {
  @override
  int hasprofbounus=-1;
  Langs? ChosenLang;
  
  Noble(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    tools.add(ToolSkill("игровой набор"));
    Langs ch = Langs(Langs('').pick(context) ?? '');
    langs.add(ch);
    
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    ToolSkill.remove(ToolsNames.Gaming_Set, tools);
    langs.remove(ChosenLang);
  }
  }



