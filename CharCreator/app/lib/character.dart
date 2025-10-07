// ignore_for_file: non_constant_identifier_names
// Игнорируем предупреждение о несоблюдении соглашения об именовании Dart.

// Импортируем необходимые файлы и пакет Material для интерфейсов Flutter.
import 'background.dart'; // Определение фонов персонажа
import 'stat.dart'; // Модели характеристик персонажей
import 'tool.dart'; // Навыки владения инструментами
import 'langs.dart'; // Языковые знания
import 'package:flutter/material.dart'; // Основные виджеты и инструменты Flutter

// Основной класс описания игрового персонажа
class Character {
  late BuildContext UIContext; // Контекст интерфейса для взаимодействия с GUI
  late String name; // Имя персонажа
  Background? bg; // Фон истории персонажа
  BasicStat? STR = 10.toBasicStat(); // Основная характеристика сила
  BasicStat? DEX = 10.toBasicStat(); // Основная характеристика ловкость
  BasicStat? CON = 10.toBasicStat(); // Основная характеристика выносливость
  BasicStat? INT = 10.toBasicStat(); // Основная характеристика интеллект
  BasicStat? WIS = 10.toBasicStat(); // Основная характеристика мудрость
  BasicStat? CHR = 10.toBasicStat(); // Основная характеристика харизма
  Skill? Acrobatics = Skill("ловкость"); // Акробатика
  Skill? Animal_Handling = Skill("мудрость"); // Уход за животными
  Skill? Arcana = Skill("интеллект"); // Тайны
  Skill? Athletics = Skill("сила"); // Атлетизм
  Skill? Deception = Skill("харизма"); // Обман
  Skill? History = Skill("интеллект"); // История
  Skill? Insight = Skill("мудрость"); // Интуиция
  Skill? Intimidation = Skill("харизма"); // Запугивание
  Skill? Investigation = Skill("интеллект"); // Расследование
  Skill? Medicine = Skill("мудрость"); // Медицина
  Skill? Nature = Skill("интеллект"); // Природа
  Skill? Perception = Skill("мудрость"); // Восприятие
  Skill? Performance = Skill("харизма"); // Выступления
  Skill? Persuasion = Skill("харизма"); // Убеждение
  Skill? Religion = Skill("интеллект"); // Религия
  Skill? Sleight_of_Hand = Skill("ловкость"); // Скрытность рук
  Skill? Stealth = Skill("ловкость"); // Скрытность
  Skill? Survival = Skill("мудрость"); // Выживание
  Set<ToolSkill>? tools = {}; // Дополнительные умения владения инструментами
  Set<Langs>? langs = {}; // Владение языками

  // Возвращает карту всех характеристик персонажа
  Map<StatNames, Stat> getallstats() {
    return {
      StatNames.Background: bg,
      StatNames.STR: STR,
      StatNames.DEX: DEX,
      StatNames.CON: CON,
      StatNames.INT: INT,
      StatNames.WIS: WIS,
      StatNames.CHR: CHR,
      StatNames.Acrobatics: Acrobatics,
      StatNames.Animal_Handling: Animal_Handling,
      StatNames.Arcana: Arcana,
      StatNames.Athletics: Athletics,
      StatNames.Deception: Deception,
      StatNames.History: History,
      StatNames.Insight: Insight,
      StatNames.Intimidation: Intimidation,
      StatNames.Investigation: Investigation,
      StatNames.Medicine: Medicine,
      StatNames.Nature: Nature,
      StatNames.Perception: Perception,
      StatNames.Performance: Performance,
      StatNames.Persuasion: Persuasion,
      StatNames.Religion: Religion,
      StatNames.Sleight_of_Hand: Sleight_of_Hand,
      StatNames.Stealth: Stealth,
      StatNames.Survival: Survival,
    };
  }

<<<<<<< HEAD
Map<StatNames,Stat> getallstats(){
  return  {
  StatNames.Background:?bg,
  StatNames.STR:?STR,
  StatNames.DEX:?DEX,
  StatNames.CON:?CON,
  StatNames.INT:?INT,
  StatNames.WIS:?WIS,
  StatNames.CHR:?CHR,
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

Map<StatNames,ModifierStat> getmodifierstats(){
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
Set<ToolSkill>? getToolingskills() => tools;
Set<Langs>? getLangs() => langs;

Character(BuildContext UIContext){
  bg = Background("Тест", getmodifierstats(), tools!, langs!, UIContext);
=======
  // Возвращает набор инструментальных навыков персонажа
  Set<ToolSkill>? getToolingskills() => tools;

  // Возвращает языки, которыми владеет персонаж
  Set<Langs>? getLangs() => langs;
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24

  // Конструктор персонажа, создаётся фон персонажа с тестовыми значениями
  Character(BuildContext UIContext) {
    bg = Background("Тест", getallstats(), tools!, langs!, UIContext);
  }
}