// ignore_for_file: constant_identifier_names

import 'stat.dart';
import 'meta.dart';
import 'ui/modal_service.dart';

enum ToolsNames {
  Thieves_Tools,
  Gaming_Set,
  Nav_Tools,
  Poisoning_Tools,
  Artisans_Tools,
  Musical_Instruments,
  Disguise_Kit,
  Forgery_Kit,
  Herbalism_Kit,
  Water_Transport,
  Ground_Transport
}

final class ToolSkill implements Stat, Pickable {
  late final ToolsNames tooltype;
  Meta metadata = Meta();
  final ModalService modalService;

  ToolSkill(String sk, this.modalService, [Set<MetaFlags>? meta]) {
    switch (sk.toLowerCase()) {
      case "воровские инструменты": tooltype = ToolsNames.Thieves_Tools;
      case "игровой набор": tooltype = ToolsNames.Gaming_Set;
      case "инструменты навигатора": tooltype = ToolsNames.Nav_Tools;
      case "инструменты отравителя": tooltype = ToolsNames.Poisoning_Tools;
      case "инструменты ремесленников": tooltype = ToolsNames.Artisans_Tools;
      case "музыкальные инструменты": tooltype = ToolsNames.Musical_Instruments;
      case "набор для грима": tooltype = ToolsNames.Disguise_Kit;
      case "набор для фальсификации": tooltype = ToolsNames.Forgery_Kit;
      case "водный транспорт": tooltype = ToolsNames.Water_Transport;
      case "наземный транспорт": tooltype = ToolsNames.Ground_Transport;
      case "набор травника": tooltype = ToolsNames.Herbalism_Kit;
      default: throw ArgumentError('Unknown tool type: $sk');
    }
    if (meta != null) {
      metadata.MetaFlags_ = meta;
    }
  }

  static void deletebyMeta(Set<ToolSkill>? tools, MetaFlags m) {
    if (tools == null) return;
    tools.removeWhere((tool) => tool.metadata.MetaFlags_.contains(m));
  }

  static Map<String, ToolsNames> str2toolskill() {
    return {
      "воровские инструменты": ToolsNames.Thieves_Tools,
      "инструменты навигатора": ToolsNames.Nav_Tools,
      "игровой набор": ToolsNames.Gaming_Set,
      "инструменты отравителя": ToolsNames.Poisoning_Tools,
      "инструменты ремесленников": ToolsNames.Artisans_Tools,
      "музыкальные инструменты": ToolsNames.Musical_Instruments,
      "набор для грима": ToolsNames.Disguise_Kit,
      "набор для фальсификации": ToolsNames.Forgery_Kit,
      "водный транспорт": ToolsNames.Water_Transport,
      "наземный транспорт": ToolsNames.Ground_Transport,
      "набор травника": ToolsNames.Herbalism_Kit
    };
  }

  // Вспомогательный метод для получения отображаемого имени инструмента
  String get displayName {
    switch (tooltype) {
      case ToolsNames.Thieves_Tools: return "воровские инструменты";
      case ToolsNames.Gaming_Set: return "игровой набор";
      case ToolsNames.Nav_Tools: return "инструменты навигатора";
      case ToolsNames.Poisoning_Tools: return "инструменты отравителя";
      case ToolsNames.Artisans_Tools: return "инструменты ремесленников";
      case ToolsNames.Musical_Instruments: return "музыкальные инструменты";
      case ToolsNames.Disguise_Kit: return "набор для грима";
      case ToolsNames.Forgery_Kit: return "набор для фальсификации";
      case ToolsNames.Water_Transport: return "водный транспорт";
      case ToolsNames.Ground_Transport: return "наземный транспорт";
      case ToolsNames.Herbalism_Kit: return "набор травника";
    }
  }

  Set<String> get menu => str2toolskill().keys.toSet();

  Set get ret => str2toolskill().values.toSet();

  @override
  Future<String?> pick(ModalService modalService, [Set<dynamic>? include]) async {
    Map<String, ToolsNames> availableTools = str2toolskill();
    
    // Если указан набор для включения, фильтруем только эти элементы
    if (include != null) {
      // Преобразуем include в Set<ToolsNames> если нужно
      final includeTools = include.whereType<ToolsNames>().toSet();
      if (includeTools.isNotEmpty) {
        availableTools.removeWhere((key, value) => !includeTools.contains(value));
      }
    }
    
    final Map<String, dynamic> toolMap = {};
    availableTools.forEach((key, value) {
      toolMap[key] = value;
    });
    
    return await modalService.showListPicker(toolMap);
  }

  @override
  Future<Set<String>> pickmany(
    ModalService modalService, 
    [List<String>? initialSelections, 
    int howmany = 2, 
    Set<dynamic>? include
  ]) async {
    Set<String> availableTools = menu;
    
    // Если указан набор для включения, фильтруем только эти элементы
    if (include != null) {
      // Обрабатываем разные типы в include
      if (include is Set<ToolsNames>) {
        final includedNames = include.map((tool) {
          switch (tool) {
            case ToolsNames.Thieves_Tools: return "воровские инструменты";
            case ToolsNames.Gaming_Set: return "игровой набор";
            case ToolsNames.Nav_Tools: return "инструменты навигатора";
            case ToolsNames.Poisoning_Tools: return "инструменты отравителя";
            case ToolsNames.Artisans_Tools: return "инструменты ремесленников";
            case ToolsNames.Musical_Instruments: return "музыкальные инструменты";
            case ToolsNames.Disguise_Kit: return "набор для грима";
            case ToolsNames.Forgery_Kit: return "набор для фальсификации";
            case ToolsNames.Water_Transport: return "водный транспорт";
            case ToolsNames.Ground_Transport: return "наземный транспорт";
            case ToolsNames.Herbalism_Kit: return "набор травника";
          }
        }).toSet();
        
        availableTools = availableTools.intersection(includedNames);
      } else if (include is Set<String>) {
        availableTools = availableTools.intersection(include);
      }
    }
    
    final selectedTools = await modalService.showMultiSelectListPicker(
      items: availableTools,
      initialSelections: initialSelections,
    );
    
    // Проверяем количество выбранных инструментов
    if (selectedTools.length != howmany) {
      modalService.showErrorDialog("Выберите ровно $howmany инструмента(ов)");
      return await pickmany(modalService, initialSelections, howmany, include);
    }
    
    return selectedTools;
  }

  // Вспомогательные методы для работы с конкретными типами инструментов
  Future<String?> pickWithToolsFilter(ModalService modalService, Set<ToolsNames> include) async {
    return pick(modalService, include);
  }

  Future<Set<String>> pickmanyWithToolsFilter(
    ModalService modalService, 
    [List<String>? initialSelections, 
    int howmany = 2, 
    Set<ToolsNames>? include
  ]) async {
    return pickmany(modalService, initialSelections, howmany, include);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolSkill && runtimeType == other.runtimeType && tooltype == other.tooltype;

  @override
  int get hashCode => tooltype.hashCode;

  @override
  String toString() => displayName;
}

// Вспомогательный класс для работы с коллекциями инструментов
class ToolSkillCollection {
  static Set<String> toDisplayNames(Set<ToolSkill> tools) {
    return tools.map((tool) => tool.displayName).toSet();
  }

  static Set<ToolSkill> fromDisplayNames(Set<String> names, ModalService modalService) {
    return names.map((name) => ToolSkill(name, modalService)).toSet();
  }

  static Set<ToolSkill> filterByMeta(Set<ToolSkill> tools, MetaFlags metaFlag) {
    return tools.where((tool) => tool.metadata.MetaFlags_.contains(metaFlag)).toSet();
  }
}