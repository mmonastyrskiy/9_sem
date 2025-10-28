// ignore_for_file: non_constant_identifier_names

import 'background.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'package:flutter/material.dart';
import 'items/item.dart';
import 'money.dart';
import 'race.dart';
import 'charclass.dart';
import 'package:hive/hive.dart';
part 'sys/character.g.dart'; 

// Основной класс персонажа для RPG системы
@HiveType(typeId: 0)
class Character {
  // Контекст UI для взаимодействия с Flutter виджетами
  @HiveField(0)
  late BuildContext UIContext;
  
  // Имя персонажа
  @HiveField(1)
  String name = "";
  
  // Раса персонажа (может быть null если не выбрана)
  @HiveField(2)
  Race? race;
  
  // Предыстория персонажа (может быть null если не выбрана)
  @HiveField(3)
  Background? bg;
  
  @HiveField(4)
  CharClass? class_;
  
  // Базовые характеристики персонажа
  @HiveField(5)
  BasicStat STR = 10.toBasicStat();
  
  @HiveField(6)
  BasicStat DEX = 10.toBasicStat();
  
  @HiveField(7)
  BasicStat CON = 10.toBasicStat();
  
  @HiveField(8)
  BasicStat INT = 10.toBasicStat();
  
  @HiveField(9)
  BasicStat WIS = 10.toBasicStat();
  
  @HiveField(10)
  BasicStat CHR = 10.toBasicStat();

  @HiveField(11)
  Skill? Acrobatics;
  
  @HiveField(12)
  Skill? Animal_Handling;
  
  @HiveField(13)
  Skill? Arcana;
  
  @HiveField(14)
  Skill? Athletics;
  
  @HiveField(15)
  Skill? Deception;
  
  @HiveField(16)
  Skill? History;
  
  @HiveField(17)
  Skill? Insight;
  
  @HiveField(18)
  Skill? Intimidation;
  
  @HiveField(19)
  Skill? Investigation;
  
  @HiveField(20)
  Skill? Medicine;
  
  @HiveField(21)
  Skill? Nature;
  
  @HiveField(22)
  Skill? Perception;
  
  @HiveField(23)
  Skill? Performance;
  
  @HiveField(24)
  Skill? Persuasion;
  
  @HiveField(25)
  Skill? Religion;
  
  @HiveField(26)
  Skill? Sleight_of_Hand;
  
  @HiveField(27)
  Skill? Stealth;
  
  @HiveField(28)
  Skill? Survival;
  
  @HiveField(29)
  int ProfBonus = 2;
  
  @HiveField(30)
  int lvl = 1;
  
  @HiveField(31)
  int exp = 0;
  
  @HiveField(32)
  late int PassiveInsight;
  
  @HiveField(33)
  late int InitiativeBonus;
  
  @HiveField(34)
  late int armor;
  
  // Коллекции инструментов и языков персонажа
  @HiveField(35)
  Set<ToolSkill> tools = {};
  
  @HiveField(36)
  Set<Langs> langs = {};
  
  // Здоровье персонажа
  @HiveField(37)
  Health health = Health();
  
  // Боевые характеристики
  @HiveField(38)
  Set<AbstractArmor> CanUseArmor = {};
  
  @HiveField(39)
  Set<AbstractWeapon> canUseWeapon = {};
  
  // Финансы и инвентарь
  @HiveField(40)
  Money wallet = Money();
  
  @HiveField(41)
  List<SellableItem> inventory = [];
  
  // Физические характеристики
  @HiveField(42)
  Size? size;
  
  @HiveField(43)
  int? speed;

  @HiveField(44)
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
  int getModifier(BasicStatNames s) => getbasicstats()[s]!.Stat2Modifier();

  String currentclass() {
    return class_?.classname ?? "";
  }

  void HandleClassChange(String new_) {
    if (class_ != null && new_ != currentclass()) {
      class_?.delete(health, getbasicstats(), getskills(), CanUseArmor, canUseWeapon, tools);
    }
    class_ = CharClass(new_, this);
  }

  String currentbg() {
    return bg?.BGName ?? "";
  }

  void HandleBgChange(String new_) {
    if (bg != null && new_ != currentbg()) {
      bg?.delete(getskills(), tools, langs);
    }
    bg = Background(new_, this);
  }

  String currentRace() {
    return race?.racename ?? "";
  }

  void HandleRaceChange(String new_) {
    if (race != null && new_ != currentRace()) {
      race?.delete(getbasicstats(), size, speed, langs, tools, CanUseArmor, health, getskills(), canUseWeapon);
    }
    race = Race(new_, this);
  }

  Character(this.UIContext) {
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
    bg = Background('', this);
    class_ = CharClass("", this);
    race = Race("", this);

    PassiveInsight = 10;
    InitiativeBonus = 0;
    armor = 0;
    speed = 30;
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
}