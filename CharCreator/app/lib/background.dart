// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'meta.dart';
import 'character.dart';
enum BackgroundNames  {
  Entertainer,
  Urchin,
  Noble,
  Guild_artisan,
  Sailor,
  Sage,
  Folk_Hero,
  Hermit,
  Pirate,
  Criminal,
  Acolyte,
  Soldier,
  Outlander,
  Charlatan


}
abstract class Background implements AffectsStatBackground,Stat {
  factory Background(String chosen, Character char)
  {
    Map<StatNames,ModifierStat> stats =char.getskills(); 
    Set<ToolSkill> tools = char.getToolingskills();
    Set<Langs> langs = char.getLangs();
    BuildContext context = char.UIContext;
    switch (chosen.toLowerCase()) {
      case 'артист': return Entertainer(stats, tools, langs, context);
      case 'беспризорник': return Urchin(stats, tools, langs, context); 
      case 'благородный': return Noble(stats, tools, langs, context); 
      case 'гильдейский ремесленник': return Guild_artisan(stats, tools, langs, context); 
      case 'моряк': return Sailor(stats, tools, langs, context); 
      case 'мудрец': return Sage(stats, tools, langs, context);
      case 'народный герой': return Folk_Hero(stats, tools, langs, context); 
      case 'отшельник': return Hermit(stats, tools, langs, context); 
      case 'пират': return Pirate(stats, tools, langs, context); 
      case 'преступник': return Criminal(stats, tools, langs, context); 
      case 'прислужник': return Acolyte(stats, tools, langs, context); 
      case 'солдат': return Soldier(stats, tools, langs, context); 
      case 'чужеземец': return Outlander(stats, tools, langs, context); 
      case 'шарлатан': return Charlatan(stats, tools, langs, context); 
      
      default: throw ArgumentError('Unknown background name');
    }
  
}

}
final class Entertainer implements Background {
  @override
  void apply(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context) {
    stats[StatNames.Acrobatics]?.hasprofbounus+= 1;
    stats[StatNames.Performance]?.hasprofbounus+= 1;
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    
    


  }

  @override
  void delete(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Acrobatics]?.hasprofbounus-= 1;
    stats[StatNames.Performance]?.hasprofbounus-= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  Entertainer(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
    apply(stats, tools,langs,context);
  }


}
final class Urchin implements Background {

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    stats[StatNames.Stealth]?.hasprofbounus +=1;
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Stealth]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  Urchin(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
  apply(stats,tools,langs,context);
  }
}
final class Noble implements Background {

  Noble(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);

    
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
  }
  final class Guild_artisan implements Background{
  Guild_artisan(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  
  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    stats[StatNames.Insight]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    stats[StatNames.Insight]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools,MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

  }

final class Sailor implements Background{
  Sailor(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }



  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Perception]?.hasprofbounus +=1;
    tools.add(ToolSkill('инструменты навигатора',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill('водный транспорт',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Perception]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    


  }

}
final class Sage implements Background{
  Sage(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Arcana]?.hasprofbounus +=1;
    
    Set<String>? r =Langs('').pickmany(context);
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));

    }


  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Arcana]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Folk_Hero implements Background{
  Folk_Hero(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Survival]?.hasprofbounus +=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Survival]?.hasprofbounus -=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Hermit implements Background {
  Hermit(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Medicine]?.hasprofbounus+=1;
    stats[StatNames.Religion]?.hasprofbounus+=1;
    tools.add(ToolSkill("Набор травника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);

  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Medicine]?.hasprofbounus-=1;
    stats[StatNames.Religion]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

final class Pirate implements Background{
  Pirate(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus+=1;
    stats[StatNames.Perception]?.hasprofbounus+=1;
    tools.add(ToolSkill("инструменты навигатора",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("водный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus-=1;
    stats[StatNames.Perception]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);


  }

}
final class Criminal implements Background{
  Criminal(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Stealth]?.hasprofbounus+=1;
    stats[StatNames.Deception]?.hasprofbounus+=1;
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
   stats[StatNames.Stealth]?.hasprofbounus-=1;
    stats[StatNames.Deception]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Acolyte implements Background{
  Acolyte(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Insight]?.hasprofbounus +=1;
    stats[StatNames.Religion]?.hasprofbounus +=1;
    Set<String>? r =Langs('').pickmany(context);
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));

    }

  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Insight]?.hasprofbounus -=1;
    stats[StatNames.Religion]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Soldier implements Background{
  Soldier(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Intimidation]?.hasprofbounus +=1;
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Intimidation]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Outlander implements Background{
  Outlander(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Survival]?.hasprofbounus +=1;
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Survival]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
  }
  final class Charlatan implements Background{
    Charlatan(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    stats[StatNames.Deception]?.hasprofbounus +=1;
    tools.add(ToolSkill("набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("набор для фальсификации",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }
  
  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Deception]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);

  }
  }