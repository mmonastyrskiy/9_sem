// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// Игнорируем нарушение соглашений об именовании Dart.

<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'meta.dart';
enum BackgroundNames  {
  Entertainer,
  Urchin,
  Noble,
  Guild_artisan,
  Sailor,
  Sage,
  Folk_Hero,
  Hermit,
  Pirate,
  Criminal,
  Acolyte,
  Soldier,
  Outlander,
  Charlatan

=======
// Импортируем необходимые пакеты и модули.
import 'package:flutter/material.dart'; // Для использования базовых компонентов Flutter.
import 'stat.dart'; // Содержит модели характеристик персонажа.
import 'tool.dart'; // Навыки и инструменты персонажа.
import 'langs.dart'; // Модель владения языками.
import 'meta.dart'; // Метаданные и константы игры.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24

// Перечисление возможных вариантов происхождения персонажа (фоны).
enum BackgroundNames {
  Entertainer, // Артист
  Urchin, // Урчин (беспризорник)
  Noble, // Дворянин
  Guild_artisan, // Ремесленник гильдии
  Sailor, // Моряк
  Sage, // Учёный (мудрец)
  Folk_Hero, // Народный герой
  Hermit, // Отшельник
}
<<<<<<< HEAD
abstract class Background implements AffectsStat,Stat {
  factory Background(String chosen, Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context)
  {
    switch (chosen.toLowerCase()) {
      case 'артист': return Entertainer(stats, tools, langs, context);
      case 'беспризорник': return Urchin(stats, tools, langs, context); 
      case 'благородный': return Noble(stats, tools, langs, context); 
      case 'гильдейский ремесленник': return Guild_artisan(stats, tools, langs, context); 
      case 'моряк': return Sailor(stats, tools, langs, context); 
      case 'мудрец': return Sage(stats, tools, langs, context);
      case 'народный герой': return Folk_Hero(stats, tools, langs, context); 
      case 'отшельник': return Hermit(stats, tools, langs, context); 
      case 'пират': return Pirate(stats, tools, langs, context); 
      case 'преступник': return Criminal(stats, tools, langs, context); 
      case 'прислужник': return Acolyte(stats, tools, langs, context); 
      case 'солдат': return Soldier(stats, tools, langs, context); 
      case 'чужеземец': return Outlander(stats, tools, langs, context); 
      case 'шарлатан': return Charlatan(stats, tools, langs, context); 
      
      default: throw ArgumentError('Unknown background name');
=======

// Базовый абстрактный класс фона персонажа, реализующий два интерфейса: изменение статистики и хранение статической информации.
abstract class Background implements AffectsStat, Stat {
  // Фабрика для создания конкретного экземпляра фона персонажа.
  factory Background(String chosen, Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    switch (chosen.toLowerCase()) {
      case "артист":
        return Entertainer(stats, tools, langs, context); // Выбор артиста.
      default:
        return Noble(stats, tools, langs, context); // По умолчанию дворянин.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
    }
  }
}

// Реализация фона "Артист"
final class Entertainer implements Background {
  // Применяет эффекты фона к характеристикам и инструментам персонажа.
  @override
<<<<<<< HEAD
  void apply(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context) {
    stats[StatNames.Acrobatics]?.hasprofbounus+= 1;
    stats[StatNames.Performance]?.hasprofbounus+= 1;
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    
    


=======
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Acrobatics]?.hasprofbounus += 1; // Повышаем бонус акробатики.
    stats[StatNames.Performance]?.hasprofbounus += 1; // Повышаем бонус выступления.
    tools.add(ToolSkill("Набор для грима", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем инструмент набора для грима.
    tools.add(ToolSkill("Музыкальные инструменты", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем музыкальный инструмент.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
  }

  // Убирает ранее применённые бонусы и удаляет инструменты, привязанные к этому фону.
  @override
<<<<<<< HEAD
  void delete(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Acrobatics]?.hasprofbounus-= 1;
    stats[StatNames.Performance]?.hasprofbounus-= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  Entertainer(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
    apply(stats, tools,langs,context);
  }


=======
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Acrobatics]?.hasprofbounus -= 1;
    stats[StatNames.Performance]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
  }

  // Конструктор автоматически вызывает метод apply для инициализации эффектов фона.
  Entertainer(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    apply(stats, tools, langs, context);
  }

  // Признак наличия бонуса от профессии (всегда равен -1, поскольку этот показатель тут не важен).
  @override
  int hasprofbounus = -1;
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
}

// Реализация фона "Беспризорник"
final class Urchin implements Background {
<<<<<<< HEAD

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    stats[StatNames.Stealth]?.hasprofbounus +=1;
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Stealth]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  Urchin(Map<StatNames,ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
  apply(stats,tools,langs,context);
=======
  @override
  int hasprofbounus = -1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus += 1; // Повышаем бонус скрытности рук.
    stats[StatNames.Stealth]?.hasprofbounus += 1; // Повышаем бонус скрытности.
    tools.add(ToolSkill("Набор для грима", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем инструмент набора для грима.
    tools.add(ToolSkill("Воровские инструменты", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем воровской инструмент.
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -= 1;
    stats[StatNames.Stealth]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
  }

  Urchin(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    apply(stats, tools, langs, context);
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
  }
}

// Реализация фона "Дворянин"
final class Noble implements Background {
<<<<<<< HEAD

  Noble(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
=======
  @override
  int hasprofbounus = -1;

  Noble(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
    apply(stats, tools, langs, context);
  }

  @override
<<<<<<< HEAD
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);

    
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
  }
  final class Guild_artisan implements Background{
  Guild_artisan(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  
  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    stats[StatNames.Insight]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
=======
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus += 1; // Повышаем бонус истории.
    stats[StatNames.Persuasion]?.hasprofbounus += 1; // Повышаем бонус убеждения.
    tools.add(ToolSkill("Игровой набор", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем игровой набор инструментов.
    Langs ch = Langs(Langs('').pick(context) ?? '', {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}); // Выбираем дополнительный язык.
    langs.add(ch); // Добавляем новый язык.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
  }

  @override
<<<<<<< HEAD
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    stats[StatNames.Insight]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools,MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
=======
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -= 1;
    stats[StatNames.Persuasion]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG); // Удаляем дополнительные языки, относящиеся к данному фону.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
  }
}

<<<<<<< HEAD
  }

final class Sailor implements Background{
  Sailor(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }



  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Perception]?.hasprofbounus +=1;
    tools.add(ToolSkill('инструменты навигатора',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill('водный транспорт',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Perception]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    


  }

}
final class Sage implements Background{
  Sage(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus +=1;
    stats[StatNames.Arcana]?.hasprofbounus +=1;
    
    Set<String>? r =Langs('').pickmany(context);
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));

    }


  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -=1;
    stats[StatNames.Arcana]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
=======
// Реализация фона "Ремесленник Гильдии"
final class Guild_artisan implements Background {
  @override
  int hasprofbounus = -1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Persuasion]?.hasprofbounus += 1; // Повышаем бонус убеждения.
    stats[StatNames.Insight]?.hasprofbounus += 1; // Повышаем бонус интуиции.
    tools.add(ToolSkill("Инструменты ремесленника", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем ремесленные инструменты.
    Langs ch = Langs(Langs('').pick(context) ?? '', {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}); // Выбираем дополнительный язык.
    langs.add(ch); // Добавляем новый язык.
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Persuasion]?.hasprofbounus -= 1;
    stats[StatNames.Insight]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG); // Удаляем дополнительные языки, относящиеся к данному фону.
  }
}

// Реализация фона "Моряк"
final class Sailor implements Background {
  @override
  int hasprofbounus = -1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus += 1; // Повышаем бонус атлетизма.
    stats[StatNames.Perception]?.hasprofbounus += 1; // Повышаем бонус восприятия.
    tools.add(ToolSkill('Навигационные инструменты', {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем навигационный инструмент.
    tools.add(ToolSkill('Водный транспорт', {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем умение водить судно.
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -= 1;
    stats[StatNames.Perception]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
  }
}

// Реализация фона "Учёный"
final class Sage implements Background {
  @override
  int hasprofbounus = -1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus += 1; // Повышаем бонус истории.
    stats[StatNames.Arcana]?.hasprofbounus += 1; // Повышаем бонус тайн.
    Set<String>? r = Langs('').pickmany(context); // Выбираем сразу несколько языков.
    for (String s in r!) {
      langs.add(Langs(s)); // Добавляем новые языки.
    }
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -= 1;
    stats[StatNames.Arcana]?.hasprofbounus -= 1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG); // Удаляем дополнительные языки, относящиеся к данному фону.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
  }
}
<<<<<<< HEAD
final class Folk_Hero implements Background{
  Folk_Hero(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Survival]?.hasprofbounus +=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus +=1;
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Survival]?.hasprofbounus -=1;
    stats[StatNames.Animal_Handling]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Hermit implements Background {
  Hermit(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }


  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Medicine]?.hasprofbounus+=1;
    stats[StatNames.Religion]?.hasprofbounus+=1;
    tools.add(ToolSkill("Набор травника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);

  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Medicine]?.hasprofbounus-=1;
    stats[StatNames.Religion]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

final class Pirate implements Background{
  Pirate(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus+=1;
    stats[StatNames.Perception]?.hasprofbounus+=1;
    tools.add(ToolSkill("инструменты навигатора",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("водный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus-=1;
    stats[StatNames.Perception]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);


  }

}
final class Criminal implements Background{
  Criminal(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Stealth]?.hasprofbounus+=1;
    stats[StatNames.Deception]?.hasprofbounus+=1;
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
   stats[StatNames.Stealth]?.hasprofbounus-=1;
    stats[StatNames.Deception]?.hasprofbounus-=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Acolyte implements Background{
  Acolyte(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Insight]?.hasprofbounus +=1;
    stats[StatNames.Religion]?.hasprofbounus +=1;
    Set<String>? r =Langs('').pickmany(context);
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));

    }

  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Insight]?.hasprofbounus -=1;
    stats[StatNames.Religion]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Soldier implements Background{
  Soldier(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Intimidation]?.hasprofbounus +=1;
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Intimidation]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }

}
final class Outlander implements Background{
  Outlander(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    stats[StatNames.Survival]?.hasprofbounus +=1;
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    stats[StatNames.Survival]?.hasprofbounus -=1;
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
  }
  final class Charlatan implements Background{
    Charlatan(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    stats[StatNames.Deception]?.hasprofbounus +=1;
    tools.add(ToolSkill("набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    tools.add(ToolSkill("набор для фальсификации",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }
  
  @override
  void delete(Map<StatNames, ModifierStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    stats[StatNames.Deception]?.hasprofbounus -=1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);

  }
  }
=======

// Реализация фона "Народный Герой"
final class Folk_Hero implements Background {
  @override
  int hasprofbounus = -1;

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Survival]?.hasprofbounus += 1; // Повышаем бонус выживания.
    stats[StatNames.Animal_Handling]?.hasprofbounus += 1; // Повышаем бонус ухода за животными.
    tools.add(ToolSkill("Инструменты ремесленника", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем ремесленный инструмент.
    tools.add(ToolSkill("Наземный транспорт", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем наземный транспорт.
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.Survival]?.hasprofbounus -= 1;
    stats[StatNames.Animal_Handling]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
  }
}
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
