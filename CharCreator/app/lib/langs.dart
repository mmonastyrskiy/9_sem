// ignore_for_file: constant_identifier_names
// Игнорируем нарушения соглашения об именовании Dart.

// Импортируем нужные библиотеки и компоненты.
import 'package:flutter/material.dart'; // Для визуализации интерфейса.
import 'stat.dart'; // Характеристики персонажа.
import 'ui/uicore.dart'; // Ядро графического интерфейса.
import 'snippets.dart'; // Различные вспомогательные методы.
import 'ui/uisnippets.dart'; // Вспомогательные методы для интерфейса.
import 'meta.dart'; // Метаданные игровых объектов.

// Перечисление возможных языков для персонажа.
enum LangsNames {
  Common, // Общий язык
  Dwarvish, // Дварфийский
  Elvish, // Эльфийский
  Giant, // Великанский
  Gnomish, // Гномий
  Goblin, // Гоблинский
  Halfling, // Полуросликовый
  Orc, // Орочий
  Abyssal, // Из бездны
  Celestial, // Небесный
  Draconic, // Драконий
  Deep_Speech, // Глубинная речь
  Infernal, // Инферальный
  Primordial, // Первородный
  Sylvan, // Силван
  Undercommon, // Подземный
}

// Класс языка персонажа, реализует характеристики и способность выбора языка.
final class Langs implements Stat, Pickable {
  late final LangsNames lang; // Хранится фактическое значение языка.
  Meta metadata = Meta(); // Метаданные языка.

  // Уровень бонусных очков, используемых языком (-1 означает отсутствие бонусов).
  @override
  int hasprofbounus = -1;

  // Конструктор языка, принимающий наименование языка и необязательную метку.
  Langs(String l, [Set<MetaFlags>? metadata]) {
    // Установка наименования языка в зависимости от переданного названия.
    switch (l.toLowerCase()) {
      case "общий":
        lang = LangsNames.Common;
        break;
      case "дварфийский":
        lang = LangsNames.Dwarvish;
        break;
      case "эльфийский":
        lang = LangsNames.Elvish;
        break;
      case "великаний":
        lang = LangsNames.Giant;
        break;
      case "гномий":
        lang = LangsNames.Gnomish;
        break;
      case "гоблинский":
        lang = LangsNames.Goblin;
        break;
      case "полуросликов":
        lang = LangsNames.Halfling;
        break;
      case "орочий":
        lang = LangsNames.Orc;
        break;
      case "бездны":
        lang = LangsNames.Abyssal;
        break;
      case "небесный":
        lang = LangsNames.Celestial;
        break;
      case "драконий":
        lang = LangsNames.Draconic;
        break;
      case "глубинная речь":
        lang = LangsNames.Deep_Speech;
        break;
      case "инферальный":
        lang = LangsNames.Infernal;
        break;
      case "первичный":
        lang = LangsNames.Primordial;
        break;
      case "силван":
        lang = LangsNames.Sylvan;
        break;
      case "подземный":
        lang = LangsNames.Undercommon;
        break;
      default:
        lang = LangsNames.Common; // Значение по умолчанию
    }
    this.metadata.MetaFlags_ = metadata!; // Присваиваем метаданные языку.
  }

  // Метод удаления языков по определённой метке.
  static void deletebyMeta(Set<Langs>? langs, MetaFlags m) {
    for (Langs l in langs!) {
      if (l.metadata.MetaFlags_.contains(m)) {
        langs.remove(l); // Удаляем язык, если у него присутствует нужная метка.
      }
    }
  }

  // Доступные варианты языков для выбора.
  @override
  Set<String> menu = {"общий", "дварфийский", "эльфийский", "великаний", "гномий", "гоблинский", "полуросликов", "орочий", "бездны",
    "небесный", "драконий", "глубинная речь", "инферальный", "первичный", "силван", "подземный"};

  // Все возможные значения языков.
  @override
  Set ret = {LangsNames.Common, LangsNames.Dwarvish, LangsNames.Elvish, LangsNames.Giant, LangsNames.Gnomish, LangsNames.Goblin,
    LangsNames.Halfling, LangsNames.Orc, LangsNames.Abyssal, LangsNames.Celestial, LangsNames.Draconic, LangsNames.Deep_Speech,
    LangsNames.Infernal, LangsNames.Primordial, LangsNames.Sylvan, LangsNames.Undercommon};

  // Выбор одного языка.
  @override
  String? pick(BuildContext context) {
    Map<String, dynamic> c = CoupleMaker.CMtoMap(menu, ret); // Создаём сопоставленную карту.
    String chosen = ModalDispatcher.showListPicker(context, c); // Показываем диалог выбора языка.
    return chosen;
  }

  // Выбор нескольких языков одновременно.
  @override
  Set<String>? pickmany(BuildContext context, [List<String>? initialSelections, int howmany = 2]) {
    Map<String, dynamic> c = CoupleMaker.CMtoMap(menu, ret); // Готовим сопоставленную карту.
    Set<String> opt = {};
    Set<String> res =
        ModalDispatcher.showMultiSelectListPicker(context: context, items: c, initialSelections: initialSelections) as Set<String>; // Показываем многоэлементный селектор.
    if (res.length != howmany) {
      while (opt.length != howmany) {
        // Повторяем выбор пока не выбраны нужное количество языков.
        print("Выберите $howmany языка(-ов)");
        opt = ModalDispatcher.showMultiSelectListPicker(context: context, items: c, initialSelections: res.toList()) as Set<String>;
      }
      return opt;
    }
    return res;
  }
}