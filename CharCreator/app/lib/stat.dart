// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

import 'tool.dart';
import 'langs.dart';
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


abstract class AffectsStat {
  void apply(Map<StatNames,Stat> stats,Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);
  void delete(Map<StatNames,Stat> stats, Set<ToolSkill> tools, Set<Langs> langs);
}
abstract interface class Stat {
  int hasprofbounus=0;



}
abstract interface class ModifierStat implements Stat{
  
}
class BasicStat implements Stat {
  late int value;
  int Stat2Modifier()=> mod=((value-10) / 2).floor();
  late int mod;
BasicStat(int val){
  value = val;
  mod = Stat2Modifier();
}

  @override
  int hasprofbounus=-1;



}
extension IntToBasicStat on int {
  BasicStat toBasicStat() => BasicStat(this);
}

final class Skill implements Stat{
  late BasicStatNames bs;
  @override
  int hasprofbounus = 0;
  Skill(String bsn){
    // TODO: ML
    switch(bsn.toLowerCase()){
      case "сила": bs = BasicStatNames.STR;
      case "ловкость": bs = BasicStatNames.DEX;
      case "Телосложение": bs = BasicStatNames.CON;
      case "интелект": bs = BasicStatNames.INT;
      case "мудрость": bs = BasicStatNames.WIS;
      default: bs = BasicStatNames.CHR;

    }

  }
}
 