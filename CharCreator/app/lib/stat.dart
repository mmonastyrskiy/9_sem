// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// Этот комментарий игнорирует правила Dart относительно именования постоянных и переменных.

// Импортируем основные виды материалов для разработки приложений на Flutter.
import 'package:flutter/material.dart';

// Импортируем используемые типы данных и модели из других файлов проекта.
import 'tool.dart'; // Инструменты персонажа.
import 'langs.dart'; // Языки персонажа.

// Перечисление названий статистических показателей персонажа.
enum StatNames {
  Background, // Происхождение персонажа
  STR, // Сила
  DEX, // Ловкость
  CON, // Телосложение
  INT, // Интеллект
  WIS, // Мудрость
  CHR, // Харизма
  Acrobatics, // Акробатика
  Animal_Handling, // Работа с животными
  Arcana, // Магические тайны
  Athletics, // Атлетика
  Deception, // Обман
  History, // История
  Insight, // Интуиция
  Intimidation, // Угроза
  Investigation, // Исследование
  Medicine, // Медицину
  Nature, // Природу
  Perception, // Восприятие
  Performance, // Исполнение
  Persuasion, // Убеждение
  Religion, // Религиозные знания
  Sleight_of_Hand, // Хитрости руками
  Stealth, // Скрытность
  Survival, // Выживание
  ToolSkills // Умения пользования инструментами
}

// Перечисление основных атрибутов персонажа.
enum BasicStatNames {
  STR, // Сила
  DEX, // Ловкость
  CON, // Телосложение
  INT, // Интеллект
  WIS, // Мудрость
  CHR // Харизма
}

// Перечисление навыков персонажа.
enum Skills {
  Acrobatics, // Акробатика
  Animal_Handling, // Работа с животными
  Arcana, // Магические секреты
  Athletics, // Физическая подготовка
  Deception, // Обман
  History, // Исторические знания
  Insight, // Осведомленность
  Intimidation, // Угрозы
  Investigation, // Исследовательская деятельность
  Medicine, // Медицинские навыки
  Nature, // Знании природы
  Perception, // Восприятие окружающего мира
  Performance, // Театральные способности
  Persuasion, // Способность убеждать
  Religion, // Религиозные познания
  Sleight_of_Hand, // Манипуляции руками
  Stealth, // Скрытность движений
  Survival // Способность выжить в сложных условиях
}

// Интерфейс классов, влияющих на статистику персонажа.
abstract class AffectsStat {
<<<<<<< HEAD
  void apply(Map<StatNames,ModifierStat> stats,Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);
  void delete(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs);
=======
  // Применение изменений к статистике персонажа.
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);

  // Удаление изменений из статистики персонажа.
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs);
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
}

// Интерфейс общего представления статистики персонажа.
abstract interface class Stat {
<<<<<<< HEAD
  



}
abstract interface class ModifierStat implements Stat{
  int hasprofbounus=0;
=======
  // Значение показателя профпригодности.
  int hasprofbounus = 0;
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
}

// Интерфейс представляющий модификаторы статистики персонажа.
abstract interface class ModifierStat implements Stat {}

// Класс основной характеристики персонажа.
class BasicStat implements Stat {
  late int value; // Основное значение атрибута.

<<<<<<< HEAD




=======
  // Метод перевода основного значения в модификатор.
  int Stat2Modifier() => ((value - 10) / 2).floor();

  late int mod; // Модификатор статистики.

  // Конструктор для установки начальной величины базовой характеристики.
  BasicStat(int val) {
    value = val;
    mod = Stat2Modifier(); // Рассчитываем модификатор при создании.
  }

  // Стандартный уровень профбонуса базовой характеристики.
  @override
  int hasprofbounus = -1;
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
}

// Расширение позволяет преобразовать целое число в базовую характеристику.
extension IntToBasicStat on int {
  BasicStat toBasicStat() => BasicStat(this);
}

<<<<<<< HEAD
final class Skill implements ModifierStat{
  late BasicStatNames bs;

  Skill(String bsn){
    // TODO: ML
    switch(bsn.toLowerCase()){
      case "сила": bs = BasicStatNames.STR;
      case "ловкость": bs = BasicStatNames.DEX;
      case "Телосложение": bs = BasicStatNames.CON;
      case "интелект": bs = BasicStatNames.INT;
      case "мудрость": bs = BasicStatNames.WIS;
      default: bs = BasicStatNames.CHR;
=======
// Класс отдельного навыка персонажа.
final class Skill implements Stat {
  late BasicStatNames bs; // Связанная основная характеристика.

  // Профильный бонус навыка.
  @override
  int hasprofbounus = 0;
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24

  // Конструктор для задания связанной основной характеристики.
  Skill(String bsn) {
        switch (bsn.toLowerCase()) {
      case "сила":
        bs = BasicStatNames.STR;
        break;
      case "ловкость":
        bs = BasicStatNames.DEX;
        break;
      case "телосложение":
        bs = BasicStatNames.CON;
        break;
      case "интеллект":
        bs = BasicStatNames.INT;
        break;
      case "мудрость":
        bs = BasicStatNames.WIS;
        break;
      default:
        bs = BasicStatNames.CHR; // По умолчанию харизма.
    }
  }
<<<<<<< HEAD

  @override
  int hasprofbounus=0;
}
 
=======
}
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
