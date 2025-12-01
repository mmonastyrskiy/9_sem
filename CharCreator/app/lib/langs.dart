// ignore_for_file: constant_identifier_names


import 'stat.dart';
import 'snippets.dart';
import 'ui/modal_service.dart';
import 'meta.dart';

enum LangsNames {
  Common,
  Dwarvish,
  Elvish,
  Giant,
  Gnomish,
  Goblin,
  Halfling,
  Orc,
  Abyssal,
  Celestial,
  Draconic,
  Deep_Speech,
  Infernal,
  Primordial,
  Sylvan,
  Undercommon,
}

final class Langs implements Stat {
  late final LangsNames lang;
  Meta metadata = Meta();
  ModalService? modalService;

  Langs(String l, [Set<MetaFlags>? metadata, this.modalService]) {
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
    if (metadata != null) {
      this.metadata.MetaFlags_ = metadata;
    }
  }

  static void deletebyMeta(Set<Langs>? langs, MetaFlags m) {
    if (langs == null) return;
    langs.removeWhere((l) => l.metadata.MetaFlags_.contains(m));
  }

  Set<String> menu = {
    "общий",
    "дварфийский",
    "эльфийский",
    "великаний",
    "гномий",
    "гоблинский",
    "полуросликов",
    "орочий",
    "бездны",
    "небесный",
    "драконий",
    "глубинная речь",
    "инферальный",
    "первичный",
    "силван",
    "подземный"
  };

  Set ret = {
    LangsNames.Common,
    LangsNames.Dwarvish,
    LangsNames.Elvish,
    LangsNames.Giant,
    LangsNames.Gnomish,
    LangsNames.Goblin,
    LangsNames.Halfling,
    LangsNames.Orc,
    LangsNames.Abyssal,
    LangsNames.Celestial,
    LangsNames.Draconic,
    LangsNames.Deep_Speech,
    LangsNames.Infernal,
    LangsNames.Primordial,
    LangsNames.Sylvan,
    LangsNames.Undercommon
  };

  Future<String?> pick() async {
    Map<String, dynamic> c = CoupleMaker.CMtoMap(menu, ret);
    final chosen = await modalService?.showListPicker(c);
    return chosen;
  }

  Future<Set<String>?>? pickmany([List<String>? initialSelections, int howmany = 2]) async {
    final selections = await modalService?.showMultiSelectListPicker(
      items: menu,
      initialSelections: initialSelections,
    );
    return selections;
  }

  // Вспомогательные методы для работы с языками
  String get displayName {
    switch (lang) {
      case LangsNames.Common:
        return "Общий";
      case LangsNames.Dwarvish:
        return "Дварфийский";
      case LangsNames.Elvish:
        return "Эльфийский";
      case LangsNames.Giant:
        return "Великаний";
      case LangsNames.Gnomish:
        return "Гномий";
      case LangsNames.Goblin:
        return "Гоблинский";
      case LangsNames.Halfling:
        return "Полуросликов";
      case LangsNames.Orc:
        return "Орочий";
      case LangsNames.Abyssal:
        return "Бездны";
      case LangsNames.Celestial:
        return "Небесный";
      case LangsNames.Draconic:
        return "Драконий";
      case LangsNames.Deep_Speech:
        return "Глубинная речь";
      case LangsNames.Infernal:
        return "Инферальный";
      case LangsNames.Primordial:
        return "Первичный";
      case LangsNames.Sylvan:
        return "Силван";
      case LangsNames.Undercommon:
        return "Подземный";
    }
  }

  // Статические методы для работы с коллекциями языков
  static Set<String> toDisplayNames(Set<Langs> langs) {
    return langs.map((lang) => lang.displayName).toSet();
  }

  static Set<Langs> fromDisplayNames(Set<String> names, ModalService modalService) {
    return names.map((name) => Langs(name,{}, modalService)).toSet();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Langs && runtimeType == other.runtimeType && lang == other.lang;

  @override
  int get hashCode => lang.hashCode;

  @override
  String toString() => displayName;
}