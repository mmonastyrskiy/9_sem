// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:app/ui/uicore.dart';
import 'package:flutter/material.dart';

import 'tool.dart';
import 'langs.dart';
import 'dice.dart';
import 'items.dart';
import 'meta.dart';
import 'ui/uisnippets.dart';
import 'snippets.dart';

enum StatNames {
  Background,
  STR,
  DEX,
  CON,
  INT,
  WIS,
  CHR,
  Acrobatics,
  Animal_Handling,
  Arcana,
  Athletics,
  Deception,
  History,
  Insight,
  Intimidation,
  Investigation,
  Medicine,
  Nature,
  Perception,
  Performance,
  Persuasion,
  Religion,
  Sleight_of_Hand,
  Stealth,
  Survival,
  ToolSkills

}
enum BasicStatNames {
  STR,
  DEX,
  CON,
  INT,
  WIS,
  CHR
}
enum Skills {
  Acrobatics,
  Animal_Handling,
  Arcana,
  Athletics,
  Deception,
  History,
  Insight,
  Intimidation,
  Investigation,
  Medicine,
  Nature,
  Perception,
  Performance,
  Persuasion,
  Religion,
  Sleight_of_Hand,
  Stealth,
  Survival

}
abstract interface class AffectsStat{}

abstract interface class AffectsStatBackground implements AffectsStat {
  void apply(Map<StatNames,ProfBonusStat> stats,Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);
  void delete(Map<StatNames,ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs);
}

abstract interface class AffectsStatClass implements AffectsStat {
  void apply(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> canUseArmor,Set<Weapon> canUseWeapon,
  Set<ToolSkill> tools,BuildContext context);
  void delete(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> canUseArmor,Set<Weapon> canUseWeapon,
  Set<ToolSkill> tools);
}
abstract interface class AffectsStatRace implements AffectsStat {
  void apply(Map<BasicStatNames,BasicStat> stats,Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,Set<Armor> canUseArmor,Health health);
  void delete(Map<BasicStatNames,BasicStat> stats,Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,Set<Armor> canUseArmor,Health health); // TODO: унификация?
}


abstract interface class Stat {
  

}
abstract interface class Updateable {
  List<Modifier> affectedby = [];
  void update(int effect, Set<MetaFlags> flags);
  void deletebyMeta(MetaFlags m);
}
abstract interface class ProfBonusStat implements Stat{
  int hasprofbounus=0;
}

class BasicStat implements Stat,Updateable {
  late int value;
  int mod=0;
  int savingthrow =0;
  List<Modifier> affectedby = [];

  int Stat2Modifier()=> mod=((value-10) / 2).floor();
BasicStat(int val){
  value = val;
  mod = Stat2Modifier();
}
void update(int effect, Set<MetaFlags> flags){
  value +=effect;
  mod = Stat2Modifier();
  affectedby.add(Modifier(effect,flags));
  // TODO: Надо еще пересчитывать статы зависимые от базовых статов

}
 void deletebyMeta(MetaFlags m){
    for(Modifier l in affectedby){
      if (l.metadata.MetaFlags_.contains(m)){
        affectedby.remove(l);
        value + -1*l.value;
        mod = Stat2Modifier();
        // TODO: Надо еще пересчитывать статы зависимые от базовых статов
      }
    }
  }

}

class Modifier{
  int value = 0;
  Meta metadata = Meta();
  Modifier(this.value,Set<MetaFlags> flags){
    metadata.MetaFlags_ = flags;

  }
}



extension IntToBasicStat on int {
  BasicStat toBasicStat() => BasicStat(this);
}

final class Skill implements ProfBonusStat,Pickable{
  late BasicStatNames bs;
  Meta metadata = Meta();

  Skill(String bsn,{Set<MetaFlags>? flags}){

    switch(bsn.toLowerCase()){
      case "сила": bs = BasicStatNames.STR;
      case "ловкость": bs = BasicStatNames.DEX;
      case "Телосложение": bs = BasicStatNames.CON;
      case "интелект": bs = BasicStatNames.INT;
      case "мудрость": bs = BasicStatNames.WIS;
      default: bs = BasicStatNames.CHR; // TODO: тут плохо, надо исключение
      

    }
    metadata.MetaFlags_ =flags!;


  }
  void addMeta(MetaFlags flag){
  metadata.MetaFlags_.add(flag);
}

static Map<String,Skills> string2skill(){
  return {
    'атлетика':Skills.Athletics,
    'акробатика':Skills.Acrobatics,
    'ловкость рук':Skills.Sleight_of_Hand,
    'скрытность':Skills.Stealth,
    'анализ':Skills.Investigation,
    'история':Skills.History,
    'магия':Skills.Arcana,
    'природа':Skills.Nature,
    'религия':Skills.Religion,
    'восприятие':Skills.Perception,
    'выживание':Skills.Survival,
    'медицина':Skills.Medicine,
    'проницательность':Skills.Insight,
    'уход за животными':Skills.Animal_Handling,
    'выступление':Skills.Performance,
    'запугивание':Skills.Intimidation,
    'обман':Skills.Deception,
    'убеждение':Skills.Deception



  };

}

static void deletebyMeta(Map<StatNames, Skill> skills, MetaFlags flag) {
    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(flag)){
        s.hasprofbounus-=1;
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED_ON_CLASS);
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED);
        
      }
    }
  }

  @override
  int hasprofbounus=0;
  
  @override
  Set<String> menu=string2skill().keys.toSet();
  
  @override
  Set ret=string2skill().values.toSet();
  
  @override
  String? pick(BuildContext bc) {
    // TODO: implement pick
    throw UnimplementedError();
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


    PopUpDispatcher.showErrorDialog(bc,"Select $howmany");
    opt = ModalDispatcher.showMultiSelectListPicker(context: bc, items: c,initialSelections: res.toList()) as Set<String>;
    }
    return opt;
    }
    return res;
    }
  }



class Health implements Updateable {
  int max_health=0;
  int current_health=0;
  DiceType? HitDice;
  
  @override
  List<Modifier> affectedby= [];
  
  @override
  void deletebyMeta(MetaFlags m) {
    for(Modifier l in affectedby){
      if (l.metadata.MetaFlags_.contains(m)){
        affectedby.remove(l);
        max_health + -1*l.value;
      }
    }
  }
  
  @override
  void update(int effect, Set<MetaFlags> flags) {
  max_health +=effect;
  affectedby.add(Modifier(effect,flags));
  }
}

enum MindSets {
  LG,
  NG,
  CG,
  LN,
  N,
  CN,
  LE,
  NE,
  CE,
  ALL
}

enum Size {
  SMALL,MEDIUM,LARGE
}
 