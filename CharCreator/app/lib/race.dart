// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

import 'package:app/meta.dart';
import 'tool.dart';
import 'stat.dart';
import 'character.dart';
import 'trait.dart';
import 'langs.dart';
import 'items.dart';

enum RaceName {

  Gnome,
  Dwarf,
  Dragonborn,
  HalfOrc,
  Hafling,
  HalfElf,
  Elf,
  Human,
  Tiefling
}

enum SubRaces{
  ForestGnome,
  RockGnome,
  MountainDwarf,
  HillDwarf

}



abstract interface class Race implements AffectsStatRace {
  Set<Trait> traits ={};


  List<MindSets> PossibleMindset = [];

  factory Race(String chosen,Character c){
    Map<BasicStatNames,BasicStat> stats = c.getbasicstats();
    Size? size = c.size;
    int? speed = c.speed;
    Set<Langs> langs = c.getLangs();
    Set<ToolSkill> tools = c.getToolingskills();
    Set<Armor> CanUseArmor = c.CanUseArmor;
    Health health =c.health;

    switch(chosen){
      case 'лесной гном': return ForestGnome(stats,size, speed,langs,tools,CanUseArmor,health);
      default: throw ArgumentError("Not implemented Race");
    }
  }


}
abstract class Gnome implements Race {
  

}
abstract class Dwarf implements Race{

}



final class ForestGnome extends Gnome{
 
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];
  @override
  Set<Trait> traits ={};
  
  
  ForestGnome(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health){
    apply(stats, size, speed,langs,tools,canUseArmor,health);
  }



  @override
  void apply(Map<BasicStatNames,BasicStat> stats,Size? size,int? speed,Set<Langs> langs,Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.INT]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.DEX]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.SMALL;
    speed = 25;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.GnomesCunning, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    langs.add(Langs('гномий',{MetaFlags.IS_PICKED,MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.CommunicationWithSmallAnimals, {MetaFlags.AFFECTED_BY_RACE}));
    
  }

  @override
  void delete(Map<BasicStatNames,BasicStat> stats,Size? size,int? speed,Set<Langs> langs,Set<ToolSkill> tools,Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);


  }
}

final class RockGnome extends Gnome{
 
  @override
  List<MindSets> PossibleMindset = [MindSets.ALL];
  @override
  Set<Trait> traits ={};
  
  RockGnome(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,Set<Armor> canUseArmor,Health health){
    apply(stats, size, speed,langs,tools,canUseArmor,health);
  }



  @override
  void apply(Map<BasicStatNames,BasicStat> stats,Size? size,int? speed,Set<Langs> langs,Set<ToolSkill> tools,Set<Armor> 
  canUseArmor,Health health) {
    stats[BasicStatNames.INT]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.CON]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.SMALL;
    speed = 25;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.GnomesCunning, {MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    langs.add(Langs('гномий',{MetaFlags.IS_PICKED,MetaFlags.AFFECTED_BY_RACE}));

    traits.add(Trait(TraitNames.CraftKnowledge, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.Tinker, {MetaFlags.AFFECTED_BY_RACE}));
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
  }

  @override
  void delete(Map<BasicStatNames,BasicStat> stats,Size? size,int? speed,Set<Langs> langs,Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.INT]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);


  }
}

final class MountainDwarf extends Dwarf{
  @override
  List<MindSets> PossibleMindset =[MindSets.ALL];

  @override
  Set<Trait> traits={};

  MountainDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health){
    apply(stats, size, speed,langs,tools,canUseArmor,health);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.CON]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.STR]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    speed =25;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DwarvenCombatTraining, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DwarvenResilience, {MetaFlags.AFFECTED_BY_RACE}));
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    langs.add(Langs('дварфийскмй',{MetaFlags.IS_PICKED,MetaFlags.AFFECTED_BY_RACE}));
    canUseArmor.add(Armor(ArmorType.Light,{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    canUseArmor.add(Armor(ArmorType.Medium,{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.STR]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size =null;
    speed = null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
    Armor.deletebyMeta(canUseArmor, MetaFlags.AFFECTED_BY_RACE);

  }

  
}
final class HillDwarf extends Dwarf{
  @override
  List<MindSets> PossibleMindset=[MindSets.ALL];

  @override
  Set<Trait> traits={};

  
  HillDwarf(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed,Set<Langs> langs,Set<ToolSkill> tools,
  Set<Armor> canUseArmor,Health health){
    apply(stats, size, speed,langs,tools,canUseArmor,health);
  }

  @override
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.CON]?.update(2, {MetaFlags.AFFECTED_BY_RACE});
    stats[BasicStatNames.WIS]?.update(1, {MetaFlags.AFFECTED_BY_RACE});
    size = Size.MEDIUM;
    speed =25;
    traits.add(Trait(TraitNames.DarkVision, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DwarvenCombatTraining, {MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DwarvenResilience, {MetaFlags.AFFECTED_BY_RACE}));
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.AFFECTED_BY_RACE}));
    langs.add(Langs('общий',{MetaFlags.AFFECTED_BY_RACE,MetaFlags.IS_PICKED}));
    langs.add(Langs('дварфийскмй',{MetaFlags.IS_PICKED,MetaFlags.AFFECTED_BY_RACE}));
    traits.add(Trait(TraitNames.DwarvenLodge, {MetaFlags.AFFECTED_BY_RACE}));
    health.update(1, {MetaFlags.AFFECTED_BY_RACE});
  }

  @override
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, Set<ToolSkill> tools, 
  Set<Armor> canUseArmor,Health health) {
    stats[BasicStatNames.WIS]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    stats[BasicStatNames.CON]?.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    health.deletebyMeta(MetaFlags.AFFECTED_BY_RACE);
    size = null;
    speed =null;
    Trait.deletebyMeta(traits, MetaFlags.AFFECTED_BY_RACE);
    ToolSkill.deletebyMeta(tools, MetaFlags.AFFECTED_BY_RACE);
    Langs.deletebyMeta(langs, MetaFlags.AFFECTED_BY_RACE);
  }

}