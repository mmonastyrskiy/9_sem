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
  void apply(Map<StatNames,ModifierStat> stats,Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);
  void delete(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs);
}

abstract interface class AffectsStatClass implements AffectsStat {
  void apply(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> canUseArmor,Set<Weapon> canUseWeapon,
  Set<ToolSkill> tools,BuildContext context);
  void delete(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> canUseArmor,Set<Weapon> canUseWeapon,
  Set<ToolSkill> tools);
}


abstract interface class Stat {
  



}
abstract interface class ModifierStat implements Stat{
  int hasprofbounus=0;
}
class BasicStat implements Stat {
  late int value;
  int mod=0;
  int savingthrow =0;
  int Stat2Modifier()=> mod=((value-10) / 2).floor();
BasicStat(int val){
  value = val;
  mod = Stat2Modifier();
}





}
extension IntToBasicStat on int {
  BasicStat toBasicStat() => BasicStat(this);
}

final class Skill implements ModifierStat,Pickable{
  late BasicStatNames bs;
  Meta metadata = Meta();

  Skill(String bsn,{Set<MetaFlags>? flags}){
    // TODO: ML
    switch(bsn.toLowerCase()){
      case "сила": bs = BasicStatNames.STR;
      case "ловкость": bs = BasicStatNames.DEX;
      case "Телосложение": bs = BasicStatNames.CON;
      case "интелект": bs = BasicStatNames.INT;
      case "мудрость": bs = BasicStatNames.WIS;
      default: bs = BasicStatNames.CHR;
      

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

      
      //TODO: Switch to modal error
    print("Select $howmany");
    opt = ModalDispatcher.showMultiSelectListPicker(context: bc, items: c,initialSelections: res.toList()) as Set<String>;
    }
    return opt;
    }
    return res;
    }
  }


class Health {
  int max_health=0;
  int current_health=0;
  DiceType? HitDice;
}
 