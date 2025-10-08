// ignore_for_file: non_constant_identifier_names, collection_methods_unrelated_type

import 'package:app/meta.dart';

import 'stat.dart';
import 'dice.dart';
import 'character.dart';
import 'items.dart';
import 'tool.dart';
import 'package:flutter/material.dart';
// ignore_for_file: constant_identifier_names

enum CharClassNames {

Bard,
Barbarian,
Fighter,
Wizzard,
Druid,
Clerc,
Artifier,
Warlock,
Monk,
Paladin,
Rouge,
Ranger,
Sorcerer
}

abstract interface class CharClass implements AffectsStatClass{
  factory CharClass(String chosen,Character c) 
  {
    Health charHeath = c.health;
    Set<Armor> CanUseArmor = c.CanUseArmor;
    Set<Weapon> canUseWeapon = c.canUseWeapon;
    BuildContext context = c.UIContext;
    Map<StatNames,Skill> skills = c.getskills();

    Set<ToolSkill> tools = c.getToolingskills();
    Map<BasicStatNames,BasicStat> stats = c.getbasicstats();
    switch(chosen.toLowerCase()){
      case 'бард': return Bard(charHeath,stats,skills,CanUseArmor,canUseWeapon,tools,context);
      case 'варвар':return Barbarian(charHeath,stats,skills,CanUseArmor,canUseWeapon,tools,context);

      default: throw ArgumentError("Not implemented class");
    }
  }

}
final class Bard implements CharClass {
  Bard(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  @override
  void apply(Health charHeath,Map<BasicStatNames,BasicStat> stat,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor, Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    CanUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LongSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Rapier,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.HandCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    

    int CONmodifier = stat[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier;
    charHeath.current_health = charHeath.max_health;

    stat[BasicStatNames.DEX]!.savingthrow=1;
    stat[BasicStatNames.CHR]!.savingthrow=1;
    Set<String>? choise = Skill('').pickmany(context, null, 3);
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;



    }
    
  }

  @override
  void delete(Health charHeath,stat,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Armor.deletebyMeta(CanUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);
    stat[BasicStatNames.DEX]!.savingthrow=0;
    stat[BasicStatNames.CHR]!.savingthrow=0;
    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }


  }

}
final class Barbarian implements CharClass{
  Barbarian(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D12;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier;
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.STR]!.savingthrow=1;
    stats[BasicStatNames.CON]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,{Skills.Athletics,Skills.Perception,Skills.Survival,Skills.Intimidation,Skills.Animal_Handling});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.STR]!.savingthrow=0;
    stats[BasicStatNames.CON]!.savingthrow=0;
    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }

}





final class Fighter implements CharClass{
  Fighter(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D10;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier;
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Heavy,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    stats[BasicStatNames.STR]!.savingthrow=1;
    stats[BasicStatNames.CON]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Acrobatics,Skills.Athletics,Skills.Perception,Skills.Survival,Skills.Intimidation,Skills.History,Skills.Insight,Skills.Animal_Handling});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.STR]!.savingthrow=0;
    stats[BasicStatNames.CON]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; //TODO: При удалении параметра флаги с него не снимаются, нигде
        
      }
    }

  }
}
final class Wizzard implements CharClass{
  Wizzard(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D6;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier;
    charHeath.current_health = charHeath.max_health;


    canUseWeapon.add(Weapon(WeaponType.Dagger,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sling,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.CombatStaff,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LightCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));


    stats[BasicStatNames.INT]!.savingthrow=1;
    stats[BasicStatNames.WIS]!.savingthrow=1;


    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.History,Skills.Arcana,Skills.Medicine,Skills.Perception,Skills.Investigation,Skills.Religion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }


  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);


    stats[BasicStatNames.INT]!.savingthrow=0;
    stats[BasicStatNames.WIS]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
}
final class Druid implements CharClass{
  Druid(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    canUseWeapon.add(Weapon(WeaponType.CombatStaff,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Mace,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Club,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Javeline,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Scimitar,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sickle,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    tools.add(ToolSkill("набор травника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.INT]!.savingthrow=1;
    stats[BasicStatNames.WIS]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Perception,Skills.Survival,Skills.Arcana,Skills.Medicine,Skills.Animal_Handling,Skills.Nature,Skills.Insight,Skills.Religion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }



  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.INT]!.savingthrow=0;
    stats[BasicStatNames.WIS]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }


  }
}

final class Clerc implements CharClass{
  Clerc(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    stats[BasicStatNames.CHR]!.savingthrow=1;
    stats[BasicStatNames.WIS]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.History,Skills.Medicine,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }

  
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.CHR]!.savingthrow=0;
    stats[BasicStatNames.WIS]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
    
  }

  final class Artifier implements CharClass{
  Artifier(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    tools.add(ToolSkill("инструменты ремонтника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
    tools.add(ToolSkill("инструменты ремесленника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.CON]!.savingthrow=1;
    stats[BasicStatNames.INT]!.savingthrow=1;


  
    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Perception,Skills.History,Skills.Sleight_of_Hand,Skills.Arcana,Skills.Medicine,Skills.Nature,Skills.Investigation});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;


    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }

  }
  
}
final class Warlock implements CharClass{
  Warlock(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.WIS]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;


    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Intimidation,Skills.History,Skills.Arcana,Skills.Deception,Skills.Nature,Skills.Investigation,Skills.Religion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }

  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
     charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
}
final class Monk implements CharClass{
  Monk(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));


    String? chosen =ToolSkill('').pick(context,{ToolsNames.Artisans_Tools,ToolsNames.Musical_Instruments});
    tools.add(ToolSkill(chosen!,{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_CLASS}));

    stats[BasicStatNames.STR]!.savingthrow=1;
    stats[BasicStatNames.DEX]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Acrobatics,Skills.Athletics,Skills.History,Skills.Insight,Skills.Religion,Skills.Stealth});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }

  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);
    stats[BasicStatNames.STR]!.savingthrow=0;
    stats[BasicStatNames.DEX]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }

  }

  
}

final class Paladin implements CharClass{
  Paladin(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D10;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Heavy,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));



    stats[BasicStatNames.WIS]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;


    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Athletics,Skills.Intimidation,Skills.Medicine,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.WIS]!.savingthrow=0;
    stats[BasicStatNames.CHR]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
}

final class Rouge implements CharClass{
  Rouge(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D8;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.HandCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LongSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.ShortSword,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Rapier,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_CLASS}));
  
  stats[BasicStatNames.DEX]!.savingthrow=1;
  stats[BasicStatNames.INT]!.savingthrow=1;


    Set<String>? choise = Skill('').pickmany(context, null, 4,
    {Skills.Athletics,Skills.Acrobatics,Skills.Perception,Skills.Performance,Skills.Intimidation,
    Skills.Sleight_of_Hand,Skills.Deception,Skills.Insight,Skills.Investigation,Skills.Stealth,Skills.Persuasion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.DEX]!.savingthrow=0;
    stats[BasicStatNames.INT]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }

}

final class Ranger implements CharClass{
  Ranger(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D10;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;


    canUseWeapon.add(Weapon(WeaponType.SimpleWeapon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.MartialWearpon,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Shield,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.DEX]!.savingthrow=1;
    stats[BasicStatNames.STR]!.savingthrow=1;


    Set<String>? choise = Skill('').pickmany(context, null, 3,
    {Skills.Athletics,Skills.Perception,Skills.Survival,Skills.Nature,Skills.
    Insight,Skills.Investigation,Skills.Stealth,Skills.Animal_Handling});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
    
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;

    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);
    Armor.deletebyMeta(canUseArmor, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.DEX]!.savingthrow=0;
    stats[BasicStatNames.STR]!.savingthrow=0;

     for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
  
}

final class Sorcerer implements CharClass{
  Sorcerer(Health charHeath,Map<BasicStatNames,BasicStat> stats,Map<StatNames,Skill> skills,Set<Armor> CanUseArmor,Set<Weapon> canUseWeapon,Set<ToolSkill> tools,BuildContext context){
    apply(charHeath,stats,skills,CanUseArmor,canUseWeapon, tools, context);
  }
  
  @override
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context) {
    charHeath.HitDice = DiceType.D6;
    ThrowObject tosser = ThrowObject();
    tosser.addDT(charHeath.HitDice!);
    tosser.DoRoll();
    int CONmodifier = stats[BasicStatNames.CON]!.mod;
    charHeath.max_health = tosser.total()+CONmodifier; //TODO: Есть вариант альтернативно выбрать серидину
    charHeath.current_health = charHeath.max_health;

    canUseWeapon.add(Weapon(WeaponType.CombatStaff,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dart,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Dagger,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.LightCrossBow,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));
    canUseWeapon.add(Weapon(WeaponType.Sling,{MetaFlags.IS_PICKED_ON_CLASS,MetaFlags.IS_PICKED}));

    stats[BasicStatNames.CON]!.savingthrow=1;
    stats[BasicStatNames.CHR]!.savingthrow=1;

    Set<String>? choise = Skill('').pickmany(context, null, null,
    {Skills.Intimidation,Skills.Arcana,Skills.Deception,Skills.Insight,Skills.Religion,Skills.Persuasion});
    for(String s in choise!)
    {
      Skills skilltoadd = Skill.string2skill()[s]!;
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED_ON_CLASS);
      skills[skilltoadd]!.addMeta(MetaFlags.IS_PICKED); 
      skills[skilltoadd]!.hasprofbounus+=1;
  }
  }
  
  @override
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools) {
    charHeath.HitDice = null;
    charHeath.max_health = 0;
    charHeath.current_health = 0;
    Weapon.deletebyMeta(canUseWeapon, MetaFlags.IS_PICKED_ON_CLASS);

    stats[BasicStatNames.CON]!.savingthrow=0;
    stats[BasicStatNames.CHR]!.savingthrow=0;

    for(Skill s in skills.values){
      if(s.metadata.MetaFlags_.contains(MetaFlags.IS_PICKED_ON_CLASS)){
        s.hasprofbounus-=1; 
      }
    }
  }
}
