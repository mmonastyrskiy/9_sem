// ignore_for_file: non_constant_identifier_names

import 'background.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'package:flutter/material.dart';
import 'items.dart';


class Character {
  late BuildContext UIContext;
  late String name;
  Background? bg;
  BasicStat STR = 10.toBasicStat();
  BasicStat DEX = 10.toBasicStat();
  BasicStat CON =10.toBasicStat();
  BasicStat INT = 10.toBasicStat();
  BasicStat WIS= 10.toBasicStat();
  BasicStat CHR = 10.toBasicStat();
  Skill? Acrobatics =Skill("сила");
  Skill? Animal_Handling =Skill("сила");
  Skill? Arcana =Skill("сила");
  Skill? Athletics=Skill("сила");
  Skill? Deception =Skill("сила");
  Skill? History=Skill("сила");
  Skill? Insight=Skill("сила");
  Skill? Intimidation=Skill("сила");
  Skill? Investigation=Skill("сила");
  Skill? Medicine=Skill("сила");
  Skill? Nature=Skill("сила");
  Skill? Perception=Skill("сила");
  Skill? Performance=Skill("сила");
  Skill? Persuasion=Skill("сила");
  Skill? Religion=Skill("сила");
  Skill? Sleight_of_Hand=Skill("сила");
  Skill? Stealth=Skill("сила");
  Skill? Survival=Skill("сила");
  Set<ToolSkill> tools = {};
  Set<Langs> langs= {};
  Health health =Health();
  Set<Armor> CanUseArmor = {};
  Set<Weapon> canUseWeapon = {};



  

Map<StatNames,Stat> getallstats(){
  return  {
  StatNames.Background:?bg,
  StatNames.STR:STR,
  StatNames.DEX:DEX,
  StatNames.CON:CON,
  StatNames.INT:INT,
  StatNames.WIS:WIS,
  StatNames.CHR:CHR,
  StatNames.Acrobatics:?Acrobatics,
  StatNames.Animal_Handling:?Animal_Handling,
  StatNames.Arcana:?Arcana,
  StatNames.Athletics:?Athletics,
  StatNames.Deception:?Deception,
  StatNames.History:?History,
  StatNames.Insight:?Insight,
  StatNames.Intimidation:?Intimidation,
  StatNames.Investigation:?Investigation,
  StatNames.Medicine:?Medicine,
  StatNames.Nature:?Nature,
  StatNames.Perception:?Perception,
  StatNames.Performance:?Performance,
  StatNames.Persuasion:?Persuasion,
  StatNames.Religion:?Religion,
  StatNames.Sleight_of_Hand:?Sleight_of_Hand,
  StatNames.Stealth:?Stealth,
  StatNames.Survival:?Survival,
  };
}

Map<BasicStatNames,BasicStat> getbasicstats(){
  return  {
  BasicStatNames.STR:STR,
  BasicStatNames.DEX:DEX,
  BasicStatNames.CON:CON,
  BasicStatNames.INT:INT,
  BasicStatNames.WIS:WIS,
  BasicStatNames.CHR:CHR 
};
}

Map<StatNames,ModifierStat> getskills(){
  return  {
  StatNames.Acrobatics:?Acrobatics,
  StatNames.Animal_Handling:?Animal_Handling,
  StatNames.Arcana:?Arcana,
  StatNames.Athletics:?Athletics,
  StatNames.Deception:?Deception,
  StatNames.History:?History,
  StatNames.Insight:?Insight,
  StatNames.Intimidation:?Intimidation,
  StatNames.Investigation:?Investigation,
  StatNames.Medicine:?Medicine,
  StatNames.Nature:?Nature,
  StatNames.Perception:?Perception,
  StatNames.Performance:?Performance,
  StatNames.Persuasion:?Persuasion,
  StatNames.Religion:?Religion,
  StatNames.Sleight_of_Hand:?Sleight_of_Hand,
  StatNames.Stealth:?Stealth,
  StatNames.Survival:?Survival,
  };
}
Set<ToolSkill> getToolingskills() => tools;
Set<Langs> getLangs() => langs;
int getModifier(BasicStatNames s) => getbasicstats()[s]!.Stat2Modifier();

Character(BuildContext UIContext){
  bg = Background("Тест",this);

}
}