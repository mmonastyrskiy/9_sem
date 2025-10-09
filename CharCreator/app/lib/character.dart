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

// Основной класс персонажа для RPG системы
class Character {
  // Контекст UI для взаимодействия с Flutter виджетами
  late BuildContext UIContext;
  // Имя персонажа
  late String name;
  // Раса персонажа (может быть null если не выбрана)
  Race? race;
  // Предыстория персонажа (может быть null если не выбрана)
  Background? bg;
  
  // Базовые характеристики персонажа (сила, ловкость, телосложение, интеллект, мудрость, харизма)
  // Инициализируются стандартным значением 10
  BasicStat STR = 10.toBasicStat();
  BasicStat DEX = 10.toBasicStat();
  BasicStat CON = 10.toBasicStat();
  BasicStat INT = 10.toBasicStat();
  BasicStat WIS = 10.toBasicStat();
  BasicStat CHR = 10.toBasicStat();
  
  // Навыки персонажа, инициализируются с временным значением "сила"
  Skill? Acrobatics = Skill("сила");
  Skill? Animal_Handling = Skill("сила");
  Skill? Arcana = Skill("сила");
  Skill? Athletics = Skill("сила");
  Skill? Deception = Skill("сила");
  Skill? History = Skill("сила");
  Skill? Insight = Skill("сила");
  Skill? Intimidation = Skill("сила");
  Skill? Investigation = Skill("сила");
  Skill? Medicine = Skill("сила");
  Skill? Nature = Skill("сила");
  Skill? Perception = Skill("сила");
  Skill? Performance = Skill("сила");
  Skill? Persuasion = Skill("сила");
  Skill? Religion = Skill("сила");
  Skill? Sleight_of_Hand = Skill("сила");
  Skill? Stealth = Skill("сила");
  Skill? Survival = Skill("сила");
  
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
    // Сохраняем переданный контекст
    bg = Background("Тест", this);
  }
}