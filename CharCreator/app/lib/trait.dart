// ignore_for_file: constant_identifier_names

import 'meta.dart';
enum TraitNames {
  DarkVision,
  GnomesCunning,
  CommunicationWithSmallAnimals,
  CraftKnowledge,
  Tinker,
  DwarvenResilience,
  DwarvenCombatTraining,
  DwarvenLodge
}
class Trait {
  TraitNames? trait;
  Meta metadata=Meta();


  Trait(TraitNames this.trait,Set<MetaFlags> flags){
    metadata.MetaFlags_ = flags;
  }

  static void deletebyMeta(Set<Trait> traits, MetaFlags flag) {
    for(Trait s in traits){
      if(s.metadata.MetaFlags_.contains(flag)){
        traits.remove(s);
        
      }
    }
  }
}
