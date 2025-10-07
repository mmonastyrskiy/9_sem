// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// Игнорируем нарушение соглашений об именовании Dart.

// Импортируем необходимые пакеты и модули.
import 'package:flutter/material.dart'; // Для использования базовых компонентов Flutter.
import 'stat.dart'; // Содержит модели характеристик персонажа.
import 'tool.dart'; // Навыки и инструменты персонажа.
import 'langs.dart'; // Модель владения языками.
import 'meta.dart'; // Метаданные и константы игры.

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

// Базовый абстрактный класс фона персонажа, реализующий два интерфейса: изменение статистики и хранение статической информации.
abstract class Background implements AffectsStat, Stat {
  // Фабрика для создания конкретного экземпляра фона персонажа.
  factory Background(String chosen, Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    switch (chosen.toLowerCase()) {
      case "артист":
        return Entertainer(stats, tools, langs, context); // Выбор артиста.
      default:
        return Noble(stats, tools, langs, context); // По умолчанию дворянин.
    }
  }
}

// Реализация фона "Артист"
final class Entertainer implements Background {
  // Применяет эффекты фона к характеристикам и инструментам персонажа.
  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.Acrobatics]?.hasprofbounus += 1; // Повышаем бонус акробатики.
    stats[StatNames.Performance]?.hasprofbounus += 1; // Повышаем бонус выступления.
    tools.add(ToolSkill("Набор для грима", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем инструмент набора для грима.
    tools.add(ToolSkill("Музыкальные инструменты", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем музыкальный инструмент.
  }

  // Убирает ранее применённые бонусы и удаляет инструменты, привязанные к этому фону.
  @override
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
}

// Реализация фона "Беспризорник"
final class Urchin implements Background {
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
  }
}

// Реализация фона "Дворянин"
final class Noble implements Background {
  @override
  int hasprofbounus = -1;

  Noble(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    apply(stats, tools, langs, context);
  }

  @override
  void apply(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context) {
    stats[StatNames.History]?.hasprofbounus += 1; // Повышаем бонус истории.
    stats[StatNames.Persuasion]?.hasprofbounus += 1; // Повышаем бонус убеждения.
    tools.add(ToolSkill("Игровой набор", {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG})); // Добавляем игровой набор инструментов.
    Langs ch = Langs(Langs('').pick(context) ?? '', {MetaFlags.IS_PICKED, MetaFlags.IS_PICKED_ON_BG}); // Выбираем дополнительный язык.
    langs.add(ch); // Добавляем новый язык.
  }

  @override
  void delete(Map<StatNames, Stat> stats, Set<ToolSkill> tools, Set<Langs> langs) {
    stats[StatNames.History]?.hasprofbounus -= 1;
    stats[StatNames.Persuasion]?.hasprofbounus -= 1;
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG); // Удаляем инструменты, относящиеся к данному фону.
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG); // Удаляем дополнительные языки, относящиеся к данному фону.
  }
}

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
  }
}

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