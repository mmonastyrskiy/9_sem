// ignore_for_file: constant_identifier_names, non_constant_identifier_names

// Импорт необходимых библиотек Flutter и пользовательских модулей
import 'package:flutter/material.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'meta.dart';
import 'character.dart';

// Перечисление названий предысторий на английском языке
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
}

// TODO: У большинства статов не прописана Мета, на тот момент класса Modifier не было. Надо адаптировать через вызов поля metadata у Stats

// Абстрактный класс Background, реализующий два интерфейса
// Использует фабричный конструктор для создания конкретных предысторий
abstract class Background implements AffectsStatBackground, Stat {
  // Фабричный конструктор для создания объектов предысторий по названию
  // Аргументы: chosen - название предыстории, char - объект персонажа
  factory Background(String chosen, Character char) {
    // Получаем навыки персонажа
    Map<StatNames,ProfBonusStat> stats = char.getskills(); 
    // Получаем инструменты персонажа
    Set<ToolSkill> tools = char.getToolingskills();
    // Получаем языки персонажа
    Set<Langs> langs = char.getLangs();
    // Получаем контекст UI из персонажа
    BuildContext context = char.UIContext;
    
    // Создаем конкретную предысторию based на переданном названии
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
      
      // Если предыстория не найдена, выбрасываем исключение
      default: throw ArgumentError('Unknown background name');
    }
  }
}

// Класс предыстории "Артист"
final class Entertainer implements Background {
  // Применяет бонусы предыстории к персонажу
  @override
  void apply(Map<StatNames,ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs,BuildContext context) {
    // Добавляем бонус к навыку Акробатики
    stats[StatNames.Acrobatics]?.hasprofbounus += 1;
    // Добавляем бонус к навыку Выступления
    stats[StatNames.Performance]?.hasprofbounus += 1;
    // Добавляем набор для грима с меткой выбора на предыстории
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем музыкальные инструменты с меткой выбора на предыстории
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории у персонажа
  @override
  void delete(Map<StatNames,ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Акробатики
    stats[StatNames.Acrobatics]?.hasprofbounus -= 1;
    // Убираем бонус от навыка Выступления
    stats[StatNames.Performance]?.hasprofbounus -= 1;
    // Удаляем все инструменты, помеченные как выбранные на предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  
  // Конструктор - автоматически применяет бонусы при создании
  Entertainer(Map<StatNames,ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
    apply(stats, tools,langs,context);
  }
}

// Класс предыстории "Беспризорник"
final class Urchin implements Background {
  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Ловкости рук
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Скрытности
    stats[StatNames.Stealth]?.hasprofbounus +=1;
    // Добавляем набор для грима
    tools.add(ToolSkill("Набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем воровские инструменты
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    // Убираем бонус от навыка Ловкости рук
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    // Убираем бонус от навыка Скрытности
    stats[StatNames.Stealth]?.hasprofbounus -=1;
    // Удаляем инструменты, помеченные для этой предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
  
  // Конструктор
  Urchin(Map<StatNames,ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs,BuildContext context){
    apply(stats,tools,langs,context);
  }
}

// Класс предыстории "Благородный"
final class Noble implements Background {
  // Конструктор
  Noble(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Истории
    stats[StatNames.History]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Убеждения
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    // Добавляем игровой набор
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Позволяем выбрать дополнительный язык через UI
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools,Set<Langs> langs) {
    // Убираем бонус от навыка Истории
    stats[StatNames.History]?.hasprofbounus -=1;
    // Убираем бонус от навыка Убеждения
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Гильдейский ремесленник"
final class Guild_artisan implements Background{
  // Конструктор
  Guild_artisan(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Убеждения
    stats[StatNames.Persuasion]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Проницательности
    stats[StatNames.Insight]?.hasprofbounus +=1;
    // Добавляем инструменты ремесленников
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Позволяем выбрать дополнительный язык
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Убеждения
    stats[StatNames.Persuasion]?.hasprofbounus -=1;
    // Убираем бонус от навыка Проницательности
    stats[StatNames.Insight]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools,MetaFlags.IS_PICKED_ON_BG);
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Моряк"
final class Sailor implements Background{
  // Конструктор
  Sailor(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Атлетики
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Внимательности
    stats[StatNames.Perception]?.hasprofbounus +=1;
    // Добавляем инструменты навигатора
    tools.add(ToolSkill('инструменты навигатора',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем умение управлять водным транспортом
    tools.add(ToolSkill('водный транспорт',{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Атлетики
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    // Убираем бонус от навыка Внимательности
    stats[StatNames.Perception]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Мудрец"
final class Sage implements Background{
  // Конструктор
  Sage(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Истории
    stats[StatNames.History]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Магии
    stats[StatNames.Arcana]?.hasprofbounus +=1;
    
    // Позволяем выбрать несколько дополнительных языков
    Set<String>? r = Langs('').pickmany(context);
    // Добавляем выбранные языки в список персонажа
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));
    }
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Истории
    stats[StatNames.History]?.hasprofbounus -=1;
    // Убираем бонус от навыка Магии
    stats[StatNames.Arcana]?.hasprofbounus -=1;
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Народный герой"
final class Folk_Hero implements Background{
  // Конструктор
  Folk_Hero(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Выживания
    stats[StatNames.Survival]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Ухода за животными
    stats[StatNames.Animal_Handling]?.hasprofbounus +=1;
    // Добавляем инструменты ремесленников
    tools.add(ToolSkill("инструменты ремесленников",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем умение управлять наземным транспортом
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Выживания
    stats[StatNames.Survival]?.hasprofbounus -=1;
    // Убираем бонус от навыка Ухода за животными
    stats[StatNames.Animal_Handling]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Отшельник"
final class Hermit implements Background {
  // Конструктор
  Hermit(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Медицины
    stats[StatNames.Medicine]?.hasprofbounus+=1;
    // Добавляем бонус к навыку Религии
    stats[StatNames.Religion]?.hasprofbounus+=1;
    // Добавляем набор травника
    tools.add(ToolSkill("Набор травника",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Позволяем выбрать дополнительный язык
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Медицины
    stats[StatNames.Medicine]?.hasprofbounus-=1;
    // Убираем бонус от навыка Религии
    stats[StatNames.Religion]?.hasprofbounus-=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Пират"
final class Pirate implements Background{
  // Конструктор
  Pirate(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Атлетики
    stats[StatNames.Athletics]?.hasprofbounus+=1;
    // Добавляем бонус к навыку Внимательности
    stats[StatNames.Perception]?.hasprofbounus+=1;
    // Добавляем инструменты навигатора
    tools.add(ToolSkill("инструменты навигатора",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем умение управлять водным транспортом
    tools.add(ToolSkill("водный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Атлетики
    stats[StatNames.Athletics]?.hasprofbounus-=1;
    // Убираем бонус от навыка Внимательности
    stats[StatNames.Perception]?.hasprofbounus-=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Преступник"
final class Criminal implements Background{
  // Конструктор
  Criminal(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Скрытности
    stats[StatNames.Stealth]?.hasprofbounus+=1;
    // Добавляем бонус к навыку Обмана
    stats[StatNames.Deception]?.hasprofbounus+=1;
    // Добавляем воровские инструменты
    tools.add(ToolSkill("воровские инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем игровой набор
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Скрытности
    stats[StatNames.Stealth]?.hasprofbounus-=1;
    // Убираем бонус от навыка Обмана
    stats[StatNames.Deception]?.hasprofbounus-=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Прислужник"
final class Acolyte implements Background{
  // Конструктор
  Acolyte(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Проницательности
    stats[StatNames.Insight]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Религии
    stats[StatNames.Religion]?.hasprofbounus +=1;
    // Позволяем выбрать несколько дополнительных языков
    Set<String>? r = Langs('').pickmany(context);
    // Добавляем выбранные языки
    for (String s in r!){
      langs.add(Langs(s,{MetaFlags.IS_PICKED_ON_BG}));
    }
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Проницательности
    stats[StatNames.Insight]?.hasprofbounus -=1;
    // Убираем бонус от навыка Религии
    stats[StatNames.Religion]?.hasprofbounus -=1;
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Солдат"
final class Soldier implements Background{
  // Конструктор
  Soldier(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Атлетики
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Запугивания
    stats[StatNames.Intimidation]?.hasprofbounus +=1;
    // Добавляем умение управлять наземным транспортом
    tools.add(ToolSkill("наземный транспорт",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем игровой набор
    tools.add(ToolSkill("игровой набор",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }

  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Атлетики
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    // Убираем бонус от навыка Запугивания
    stats[StatNames.Intimidation]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Чужеземец"
final class Outlander implements Background{
  // Конструктор
  Outlander(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Атлетики
    stats[StatNames.Athletics]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Выживания
    stats[StatNames.Survival]?.hasprofbounus +=1;
    // Добавляем музыкальные инструменты
    tools.add(ToolSkill("музыкальные инструменты",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Позволяем выбрать дополнительный язык
    Langs ch = Langs(Langs('').pick(context) ?? '',{MetaFlags.IS_PICKED,MetaFlags.IS_PICKED_ON_BG});
    langs.add(ch);
  }
  
  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Атлетики
    stats[StatNames.Athletics]?.hasprofbounus -=1;
    // Убираем бонус от навыка Выживания
    stats[StatNames.Survival]?.hasprofbounus -=1;
    // Удаляем языки предыстории
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }
}

// Класс предыстории "Шарлатан"
final class Charlatan implements Background{
  // Конструктор
  Charlatan(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context){
    apply(stats, tools, langs, context);
  }

  // Применяет бонусы предыстории
  @override
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    // Добавляем бонус к навыку Ловкости рук
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus +=1;
    // Добавляем бонус к навыку Обмана
    stats[StatNames.Deception]?.hasprofbounus +=1;
    // Добавляем набор для грима
    tools.add(ToolSkill("набор для грима",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
    // Добавляем набор для фальсификации
    tools.add(ToolSkill("набор для фальсификации",{MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}));
  }
  
  // Удаляет бонусы предыстории
  @override
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    // Убираем бонус от навыка Ловкости рук
    stats[StatNames.Sleight_of_Hand]?.hasprofbounus -=1;
    // Убираем бонус от навыка Обмана
    stats[StatNames.Deception]?.hasprofbounus -=1;
    // Удаляем инструменты предыстории
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
  }
}