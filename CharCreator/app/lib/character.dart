// ignore_for_file: non_constant_identifier_names

import 'background.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'inventory.dart';
import 'items/item.dart';
import 'money.dart';
import 'race.dart';
import 'charclass.dart';
import 'package:hive/hive.dart';
import 'ui/modal_service.dart';
part 'character.g.dart'; 

// Основной класс персонажа для RPG системы

class Character {
  
  // Имя персонажа
  String name = "";
  
  // Раса персонажа (может быть null если не выбрана)
  Race? race;
  
  // Предыстория персонажа (может быть null если не выбрана)
  Background? bg;
  
  CharClass? class_;
  
  // Базовые характеристики персонажа
  BasicStat STR = 10.toBasicStat();
  
  BasicStat DEX = 10.toBasicStat();
  
  BasicStat CON = 10.toBasicStat();
  
  BasicStat INT = 10.toBasicStat();
  
  BasicStat WIS = 10.toBasicStat();
  
  BasicStat CHR = 10.toBasicStat();

  Skill? Acrobatics;
  Skill? Animal_Handling;
  
  Skill? Arcana;
  
  Skill? Athletics;
  
  Skill? Deception;
  
  Skill? History;
  
  Skill? Insight;
  
  Skill? Intimidation;
  
  Skill? Investigation;
  
  Skill? Medicine;
  Skill? Nature;
  Skill? Perception;
  
  Skill? Performance;
  
  Skill? Persuasion;
  
  Skill? Religion;
  
  Skill? Sleight_of_Hand;
  
  Skill? Stealth;
  
  Skill? Survival;
  int ProfBonus = 2;
  int lvl = 1;
  
  int exp = 0;

  late int PassiveInsight;
  late int InitiativeBonus;
  
  late int armor;
  
  // Коллекции инструментов и языков персонажа
  Set<ToolSkill> tools = {};
  Set<Langs> langs = {};
  
  // Здоровье персонажа
  Health health = Health();
  
  // Боевые характеристики
  Set<AbstractArmor> CanUseArmor = {};
  
  Set<AbstractWeapon> canUseWeapon = {};
  
  // Финансы и инвентарь
  Money wallet = Money();

  InventorySystem inventory =InventorySystem();
  
  // Физические характеристики
  Size? size;
  
  int? speed;
  String PortraitURL = "";


  void setImageUrl(String url) {
    PortraitURL = url;
  }
  List<String> AbilityNames() => ["Сила", "Ловкость", "Телосложение", "Интеллект", "Мудрость", "Харизма"];

  void Reroll() {
    STR = BasicStat().generate();
    DEX = BasicStat().generate();
    CON = BasicStat().generate();
    INT = BasicStat().generate();
    WIS = BasicStat().generate();
    CHR = BasicStat().generate();
  }

  // Возвращает Map всех статистик персонажа
  Map<StatNames, Stat> getallstats() {
    return {
      if (bg != null) StatNames.Background: bg!,
      StatNames.STR: STR,
      StatNames.DEX: DEX,
      StatNames.CON: CON,
      StatNames.INT: INT,
      StatNames.WIS: WIS,
      StatNames.CHR: CHR,
      if (Acrobatics != null) StatNames.Acrobatics: Acrobatics!,
      if (Animal_Handling != null) StatNames.Animal_Handling: Animal_Handling!,
      if (Arcana != null) StatNames.Arcana: Arcana!,
      if (Athletics != null) StatNames.Athletics: Athletics!,
      if (Deception != null) StatNames.Deception: Deception!,
      if (History != null) StatNames.History: History!,
      if (Insight != null) StatNames.Insight: Insight!,
      if (Intimidation != null) StatNames.Intimidation: Intimidation!,
      if (Investigation != null) StatNames.Investigation: Investigation!,
      if (Medicine != null) StatNames.Medicine: Medicine!,
      if (Nature != null) StatNames.Nature: Nature!,
      if (Perception != null) StatNames.Perception: Perception!,
      if (Performance != null) StatNames.Performance: Performance!,
      if (Persuasion != null) StatNames.Persuasion: Persuasion!,
      if (Religion != null) StatNames.Religion: Religion!,
      if (Sleight_of_Hand != null) StatNames.Sleight_of_Hand: Sleight_of_Hand!,
      if (Stealth != null) StatNames.Stealth: Stealth!,
      if (Survival != null) StatNames.Survival: Survival!,
    };
  }

  // Возвращает Map только базовых характеристик
  Map<BasicStatNames, BasicStat> getbasicstats() {
    return {
      BasicStatNames.STR: STR,
      BasicStatNames.DEX: DEX,
      BasicStatNames.CON: CON,
      BasicStatNames.INT: INT,
      BasicStatNames.WIS: WIS,
      BasicStatNames.CHR: CHR
    };
  }

  // Возвращает Map всех навыков персонажа
  Map<StatNames, Skill> getskills() {
    return {
      if (Animal_Handling != null) StatNames.Animal_Handling: Animal_Handling!,
      if (Arcana != null) StatNames.Arcana: Arcana!,
      if (Athletics != null) StatNames.Athletics: Athletics!,
      if (Acrobatics != null) StatNames.Acrobatics: Acrobatics!,
      if (Deception != null) StatNames.Deception: Deception!,
      if (History != null) StatNames.History: History!,
      if (Insight != null) StatNames.Insight: Insight!,
      if (Intimidation != null) StatNames.Intimidation: Intimidation!,
      if (Investigation != null) StatNames.Investigation: Investigation!,
      if (Medicine != null) StatNames.Medicine: Medicine!,
      if (Nature != null) StatNames.Nature: Nature!,
      if (Perception != null) StatNames.Perception: Perception!,
      if (Performance != null) StatNames.Performance: Performance!,
      if (Persuasion != null) StatNames.Persuasion: Persuasion!,
      if (Religion != null) StatNames.Religion: Religion!,
      if (Sleight_of_Hand != null) StatNames.Sleight_of_Hand: Sleight_of_Hand!,
      if (Stealth != null) StatNames.Stealth: Stealth!,
      if (Survival != null) StatNames.Survival: Survival!,
    };
  }

  // Геттер для инструментов
  Set<ToolSkill> getToolingskills() => tools;

  // Геттер для языков
  Set<Langs> getLangs() => langs;

  // Вычисляет модификатор для указанной базовой характеристики
  int getModifier(BasicStatNames s) => getbasicstats()[s]!.stat2Modifier();

  String currentclass() {
    return class_?.classname ?? "";
  }

  void HandleClassChange(String new_) {
    if (class_ != null && new_ != currentclass()) {
      class_?.delete(health, getbasicstats(), getskills(), CanUseArmor, canUseWeapon, tools);
    }
    class_ = CharClass.create(new_, this);
  }

  String currentbg() {
    return bg?.BGName ?? "";
  }

  void HandleBgChange(String new_,ModalService service) {
    if (bg != null && new_ != currentbg()) {
      bg?.delete(getskills(), tools, langs);
    }
    bg = Background.withContext(new_, this,service);
  }

  String currentRace() {
    return race?.racename ?? "";
  }

  void HandleRaceChange(String new_) {
    if (race != null && new_ != currentRace()) {
      race?.delete(getbasicstats(), size, speed, langs, tools, CanUseArmor, health, getskills(), canUseWeapon);
    }
    race = Race.create(new_, this);
  }

Character() {
  STR = BasicStat().generate();
  DEX = BasicStat().generate();
  CON = BasicStat().generate();
  INT = BasicStat().generate();
  WIS = BasicStat().generate();
  CHR = BasicStat().generate();
  name = "Безымянный";
  Acrobatics = Skill("ловкость");
  Animal_Handling = Skill("Мудрость");
  Arcana = Skill("Интеллект");
  Athletics = Skill("сила");
  Deception = Skill("Харизма");
  History = Skill("Интеллект");
  Insight = Skill("Мудрость");
  Intimidation = Skill("Харизма");
  Investigation = Skill("интеллект");
  Medicine = Skill("Мудрость");
  Nature = Skill("Интеллект");
  Perception = Skill("Мудрость");
  Performance = Skill("Харизма");
  Persuasion = Skill("Харизма");
  Religion = Skill("Интеллект");
  Sleight_of_Hand = Skill("Ловкость");
  Stealth = Skill("Ловкость");
  Survival = Skill("Мудрость");
  class_ = CharClass.create("", this);
  race = Race.create("", this);


  PassiveInsight = 10;
  InitiativeBonus = 0;
  armor = 0;
  speed = 30;
}

// Method to set background with service
void initializeBackground(ModalService service) {
  bg = Background.withContext('', this, service);
}

// Factory that creates and initializes
factory Character.withContext(ModalService service) {
  final character = Character();
  character.initializeBackground(service);
  return character;
}


  void SetName(String new_) {
    name = new_;
    //print("Name is set to $new_");
  }
  String Skill2modstr(Skill s){
  bool hasprofbounus = s.hasprofbounus > 0 ? true:false;
  BasicStat? bst;
  switch(s.bs){
    case BasicStatNames.STR: bst = STR;
    case BasicStatNames.DEX: bst = DEX;
    case BasicStatNames.CON: bst = CON;
    case BasicStatNames.INT: bst = INT;
    case BasicStatNames.WIS: bst = WIS;
    case BasicStatNames.CHR: bst = CHR;
    default: bst = null;

  }
  int mod =bst!.mod;
  hasprofbounus ? mod += ProfBonus: mod;
  return mod > 0 ? "+$mod" : "$mod"; 
}
CharacterView ToView(){
  return CharacterView.fromChar(this);


}
void FromView(CharacterView v){
  v.unpack(this);
}
}
@HiveType(typeId: 1) 
class CharacterView extends HiveObject {
  @HiveField(1)
  String name = "";
  
  @HiveField(2)
  String race = "";
  
  @HiveField(3)
  String bg = "";
  
  @HiveField(4)
  String class_ = "";
  
  @HiveField(5)
  String STR = "";
  
  @HiveField(6)
  String DEX = "";
  
  @HiveField(7)
  String CON = "";
  
  @HiveField(8)
  String INT = "";
  
  @HiveField(9)
  String WIS = "";
  
  @HiveField(10)
  String CHR = "";
  
  @HiveField(11)
  String Acrobatics = "";
  
  @HiveField(12)
  String Animal_Handling = "";
  
  @HiveField(13)
  String Arcana = "";
  
  @HiveField(14)
  String Athletics = "";
  
  @HiveField(15)
  String Deception = "";
  
  @HiveField(16)
  String History = "";
  
  @HiveField(17)
  String Insight = "";
  
  @HiveField(18)
  String Intimidation = "";
  
  @HiveField(19)
  String Investigation = "";
  
  @HiveField(20)
  String Medicine = "";
  
  @HiveField(21)
  String Nature = "";
  
  @HiveField(22)
  String Perception = "";
  
  @HiveField(23)
  String Performance = "";
  
  @HiveField(24)
  String Persuasion = "";
  
  @HiveField(25)
  String Religion = "";
  
  @HiveField(26)
  String Sleight_of_Hand = "";
  
  @HiveField(27)
  String Stealth = "";
  
   @HiveField(28)
  int ProfBonus = 2;
  @HiveField(29)
  int lvl = 1;
  @HiveField(30)
  int exp = 0;
   @HiveField(31)
  int? PassiveInsight;
   @HiveField(32)
  int? InitiativeBonus;
   @HiveField(33)
  int? armor;
  @HiveField(34)
  List<String> tools = [];
  @HiveField(35)
  List<String> langs = [];
  
  @HiveField(36)
  String health="";

  @HiveField(37)
  List<String> usearmor=[];
  @HiveField(38)
  List<String> useweapon=[];
  @HiveField(39)
  int copperMoney = 0;


@HiveField(40)
  String size="";
  @HiveField(41)
  int speed=0;
  @HiveField(42)
  String PortraitURL = "";

  
CharacterView();
  CharacterView.fromChar (Character c) {
    name = c.name;
    race = c.currentRace();
    bg = c.currentbg();
    class_ = c.currentclass();
    STR = c.STR.Str("STR");
    DEX = c.DEX.Str("DEX");
    CON = c.CON.Str("CON");
    INT = c.INT.Str("INT");
    WIS = c.WIS.Str("WIS");
    CHR = c.CHR.Str("CHR");
    
    Acrobatics = c.Acrobatics?.Str("Акробатика") ?? "";
    Animal_Handling = c.Animal_Handling?.Str("Уход за животными") ?? "";
    Arcana = c.Arcana?.Str("Магия") ?? "";
    Athletics = c.Athletics?.Str("Атлетика") ?? "";
    Deception = c.Deception?.Str("Обман") ?? "";
    History = c.History?.Str("История") ?? "";
    Insight = c.Insight?.Str("Проницательность") ?? "";
    Intimidation = c.Intimidation?.Str("Запугивание") ?? "";
    Investigation = c.Investigation?.Str("Анализ") ?? "";
    Medicine = c.Medicine?.Str("Медицина") ?? "";
    Nature = c.Nature?.Str("Природа") ?? "";
    Perception = c.Perception?.Str("Восприятие") ?? "";
    Performance = c.Performance?.Str("Выступление") ?? "";
    Persuasion = c.Persuasion?.Str("Убеждение") ?? "";
    Religion = c.Religion?.Str("Религия") ?? "";
    Sleight_of_Hand = c.Sleight_of_Hand?.Str("Ловкость рук") ?? "";
    Stealth = c.Stealth?.Str("Скрытность") ?? "";

  ProfBonus = c.ProfBonus;
  lvl = c.lvl;
  exp = c.exp;
  PassiveInsight = c.PassiveInsight;
  InitiativeBonus = InitiativeBonus;
  armor=c.armor;
  StringifyTools(c.tools, tools);
  StringifyLangs(c.langs, langs);
  StringifyArmor(c.CanUseArmor, usearmor);
  StringifyAWeapon(c.canUseWeapon, useweapon);
  health = c.health.toString();
  copperMoney = c.wallet.to_coper();
  size = c.size.toString();
  speed = c.speed!;
  PortraitURL = c.PortraitURL;


  }
  void unpack(Character c){
    c.name = name;
    c.race = Race.create(race, c);
    c.class_ = CharClass.create(class_, c);
    // TODO: BACKGROUND

    c.STR = BasicStat(int.parse(STR.split(":")[1]));
    c.STR.stat2Modifier();
    if(int.parse(STR.split(":")[2]) >=1){
      c.STR.savingthrow = 1;
    }
    

      c.DEX = BasicStat(int.parse(DEX.split(":")[1]));
    c.DEX.stat2Modifier();
    if(int.parse(DEX.split(":")[2]) >=1){
      c.DEX.savingthrow = 1;
    }
    
    


  }

void StringifyTools(Set<ToolSkill> p,List<String> target){
  for (var data in p){
    target.add("${data.displayName}:${data.metadata.ToInt()}");
  }
}

void StringifyLangs(Set<Langs> p,List<String> target){
  for (var data in p){
    target.add("${data.displayName}:${data.metadata.ToInt()}");
  }
}
void StringifyArmor(Set<AbstractArmor> p,List<String> target){
for(var data in p){
  target.add(data.toString());
}
}

void StringifyAWeapon(Set<AbstractWeapon> p,List<String> target){
for(var data in p){
  target.add(data.toString());
}
}
}