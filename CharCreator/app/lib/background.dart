// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'meta.dart';
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
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    
    


  }

  @override
  void delete(Map<StatNames,Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Acrobatics]?.hasprofbounus-= 1;
    stats[StatNames.Performance]?.hasprofbounus-= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
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
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Stealth]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  Urchin(Map<StatNames,Stat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
  apply(stats,tools,langs,context);
  }
}
final class Noble implements Background {
  @override
  int hasprofbounus=-1;
  
  Noble(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);

    
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
  }
  final class Guild_artisan implements Background{
  @override
  int hasprofbounus=-1;

  
  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    stats[StatNames.Insight]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    stats[StatNames.Insight]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools,MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

  }

final class Sailor implements Background{
  @override
  int hasprofbounus=-1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Perception]?.hasprofbounus +=1;
    tools.add(ToolSkill('инструменты навигатора',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill('водный транспорт',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Perception]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    


  }

}
final class Sage implements Background{
  @override
  int hasprofbounus=-1;
  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Arcana]?.hasprofbounus +=1;

    
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
// TODO: языки могут быть одинаковые, нужен обработчик
    Langs ch2 = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch2);

  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Arcana]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Folk_Hero implements Background{
  @override
  int hasprofbounus=-1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Survival]?.hasprofbounus +=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Survival]?.hasprofbounus -=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
