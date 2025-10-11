// ignore_for_file: non_constant_identifier_names

// Импорт необходимых модулей и библиотек
import 'background.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'package:flutter/material.dart';
import 'items.dart';
import 'money.dart';
import 'race.dart';
import 'charclass.dart';

// Основной класс персонажа для RPG системы
class Character {
  // Контекст UI для взаимодействия с Flutter виджетами
  late BuildContext UIContext;
  // Имя персонажа
  String name="";
  // Раса персонажа (может быть null если не выбрана)
  Race? race;
  // Предыстория персонажа (может быть null если не выбрана)
  Background? bg;
  CharClass? class_;
  
  // Базовые характеристики персонажа (сила, ловкость, телосложение, интеллект, мудрость, харизма)
  // Инициализируются стандартным значением 10
  BasicStat STR = 10.toBasicStat();
  BasicStat DEX = 10.toBasicStat();
  BasicStat CON = 10.toBasicStat();
  BasicStat INT = 10.toBasicStat();
  BasicStat WIS = 10.toBasicStat();
  BasicStat CHR = 10.toBasicStat();
  List<String> AbilityNames () => ["Сила","Ловкость","Телосложение","Интеллект","Мудрость","Харизма"] ;
  


  void Reroll(){
  STR = BasicStat().generate();
  DEX = BasicStat().generate();
  CON = BasicStat().generate();
  INT = BasicStat().generate();
  WIS = BasicStat().generate();
  CHR = BasicStat().generate();
  }
  // Навыки персонажа, инициализируются с временным значением "сила"
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
  int lvl=1;
  int exp = 0;
  late int PassiveInsight;
  late int InitiativeBonus;
  late int armor;
  
  // Коллекции инструментов и языков персонажа
  Set<ToolSkill> tools = {};
  Set<Langs> langs = {};
  
  // Здоровье персонажа
  Health health = Health();
  
  // Боевые характеристики - какие типы брони и оружия может использовать
  Set<Armor> CanUseArmor = {};
  Set<Weapon> canUseWeapon = {};
  
  // Финансы и инвентарь
  Money wallet = Money();
  List<Item> inventory = [];
  
  // Физические характеристики
  Size? size;
  int? speed;
  

  // Возвращает Map всех статистик персонажа (базовые характеристики + навыки + предыстория)
  Map<StatNames, Stat> getallstats() {
    return {
      StatNames.Background: ?bg,        // Предыстория
      StatNames.STR: STR,              // Сила
      StatNames.DEX: DEX,              // Ловкость
      StatNames.CON: CON,              // Телосложение
      StatNames.INT: INT,              // Интеллект
      StatNames.WIS: WIS,              // Мудрость
      StatNames.CHR: CHR,              // Харизма
      StatNames.Acrobatics: ?Acrobatics,              // Акробатика
      StatNames.Animal_Handling: ?Animal_Handling,    // Уход за животными
      StatNames.Arcana: ?Arcana,                      // Магия
      StatNames.Athletics: ?Athletics,                // Атлетика
      StatNames.Deception: ?Deception,                // Обман
      StatNames.History: ?History,                    // История
      StatNames.Insight: ?Insight,                    // Проницательность
      StatNames.Intimidation: ?Intimidation,          // Запугивание
      StatNames.Investigation: ?Investigation,        // Расследование
      StatNames.Medicine: ?Medicine,                  // Медицина
      StatNames.Nature: ?Nature,                      // Природа
      StatNames.Perception: ?Perception,              // Внимательность
      StatNames.Performance: ?Performance,            // Выступление
      StatNames.Persuasion: ?Persuasion,              // Убеждение
      StatNames.Religion: ?Religion,                  // Религия
      StatNames.Sleight_of_Hand: ?Sleight_of_Hand,    // Ловкость рук
      StatNames.Stealth: ?Stealth,                    // Скрытность
      StatNames.Survival: ?Survival,                  // Выживание
    };
  }

  // Возвращает Map только базовых характеристик (сила, ловкость, телосложение, интеллект, мудрость, харизма)
  Map<BasicStatNames, BasicStat> getbasicstats() {
    return {
      BasicStatNames.STR: STR,  // Сила
      BasicStatNames.DEX: DEX,  // Ловкость
      BasicStatNames.CON: CON,  // Телосложение
      BasicStatNames.INT: INT,  // Интеллект
      BasicStatNames.WIS: WIS,  // Мудрость
      BasicStatNames.CHR: CHR   // Харизма
    };
  }

  // Возвращает Map всех навыков персонажа
  Map<StatNames, Skill> getskills() {
    return {
      StatNames.Animal_Handling: ?Animal_Handling,    // Уход за животными
      StatNames.Arcana: ?Arcana,                      // Магия
      StatNames.Athletics: ?Athletics,                // Атлетика
      StatNames.Acrobatics: ?Acrobatics,              // Акробатика
      StatNames.Deception: ?Deception,                // Обман
      StatNames.History: ?History,                    // История
      StatNames.Insight: ?Insight,                    // Проницательность
      StatNames.Intimidation: ?Intimidation,          // Запугивание
      StatNames.Investigation: ?Investigation,        // Расследование
      StatNames.Medicine: ?Medicine,                  // Медицина
      StatNames.Nature: ?Nature,                      // Природа
      StatNames.Perception: ?Perception,              // Внимательность
      StatNames.Performance: ?Performance,            // Выступление
      StatNames.Persuasion: ?Persuasion,              // Убеждение
      StatNames.Religion: ?Religion,                  // Религия
      StatNames.Sleight_of_Hand: ?Sleight_of_Hand,    // Ловкость рук
      StatNames.Stealth: ?Stealth,                    // Скрытность
      StatNames.Survival: ?Survival,                  // Выживание
    };
  }

  // Геттер для инструментов - возвращает множество инструментов персонажа
  Set<ToolSkill> getToolingskills() => tools;

  // Геттер для языков - возвращает множество языков персонажа
  Set<Langs> getLangs() => langs;

  // Вычисляет модификатор для указанной базовой характеристики
  // Используется для определения бонусов к броскам кубов
  int getModifier(BasicStatNames s) => getbasicstats()[s]!.Stat2Modifier();

  // Конструктор персонажа
  // Принимает UIContext для взаимодействия с UI
  Character(this.UIContext) {
  STR = BasicStat().generate();
  DEX = BasicStat().generate();
  CON = BasicStat().generate();
  INT = BasicStat().generate();
  WIS = BasicStat().generate();
  CHR = BasicStat().generate();
  name = "Безымянный";
  }
}