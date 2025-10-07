// ignore_for_file: constant_identifier_names
// Игнорируем нарушения соглашений об именовании Dart.

// Импортируем внутренние структуры данных приложения.
import 'stat.dart'; // Класс, содержащий описание характеристик игрока.
import 'meta.dart'; // Метаданные и вспомогательные свойства.

// Перечисление возможных инструментов и способностей персонажа.
enum ToolsNames {
  Thieves_Tools, // Воровые инструменты
  Gaming_Set, // Игра
  Nav_Tools, // Навигационные устройства
  Poisoning_Tools, // Средства отравления
  Artisans_Tools, // Инструменты ремесленника
  Musical_Instruments, // Музыкальные инструменты
  Disguise_Kit, // Комплект маскировки
  Forgery_Kit, // Набор фальшивых документов
  Herbalism_Kit, // Набор травника
  Water_Transport, // Водный транспорт
  Ground_Transport // Наземный транспорт
}

// Класс инструмента или специального навыка персонажа.
final class ToolSkill implements Stat {
  late final ToolsNames tooltype; // Тип инструмента или навыка.
  Meta metadata = Meta(); // Метаданные инструмента.

<<<<<<< HEAD
  ToolSkill(String sk, [Set<MetaFlags>? meta]){
    switch(sk.toLowerCase()){
      case "воровские инструменты": tooltype = ToolsNames.Thieves_Tools;
      case "игровой набор":tooltype = ToolsNames.Gaming_Set;
      case "инструменты навигатора":tooltype = ToolsNames.Nav_Tools;
      case "инструменты отравителя": tooltype =ToolsNames.Poisoning_Tools;
      case "инструменты ремесленников": tooltype = ToolsNames.Artisans_Tools;
      case "музыкальные инструменты": tooltype = ToolsNames.Musical_Instruments;
      case "набор для грима": tooltype = ToolsNames.Disguise_Kit;
      case "набор для фальсификации": tooltype = ToolsNames.Forgery_Kit;
      case "водный транспорт": tooltype = ToolsNames.Water_Transport;
      case "наземный транспорт":tooltype = ToolsNames.Ground_Transport;
      default: throw ArgumentError('Unknown tool type');
    }
    metadata.MetaFlags_ = meta!;
  }

// TODO ML
 
 static void deletebyMeta(Set<ToolSkill>? tools,MetaFlags m){
    for(ToolSkill l in tools!){
      if (l.metadata.MetaFlags_.contains(m)){
        tools.remove(l);
=======
  // Конструктор создает экземпляр инструмента или навыка.
  ToolSkill(String sk, [Set<MetaFlags>? meta]) {
    // Устанавливаем тип инструмента в зависимости от переданной строки.
    switch (sk.toLowerCase()) {
      case "воровские инструменты":
        tooltype = ToolsNames.Thieves_Tools;
        break;
      case "игровой набор":
        tooltype = ToolsNames.Gaming_Set;
        break;
      case "инструменты навигатора":
        tooltype = ToolsNames.Nav_Tools;
        break;
      case "инструменты отравителя":
        tooltype = ToolsNames.Poisoning_Tools;
        break;
      case "инструменты ремесленников":
        tooltype = ToolsNames.Artisans_Tools;
        break;
      case "музыкальные инструменты":
        tooltype = ToolsNames.Musical_Instruments;
        break;
      case "набор для грима":
        tooltype = ToolsNames.Disguise_Kit;
        break;
      case "набор для фальсификации":
        tooltype = ToolsNames.Forgery_Kit;
        break;
      case "водный транспорт":
        tooltype = ToolsNames.Water_Transport;
        break;
      case "наземный транспорт":
        tooltype = ToolsNames.Ground_Transport;
        break;
      default:
        tooltype = ToolsNames.Herbalism_Kit; // Значение по умолчанию
    }
    metadata.MetaFlags_ = meta!; // Сохраняем метаданные.
  }

  // Свойство, которое определяет наличие бонуса за использование инструмента (здесь -1 обозначает отсутствие бонуса).
  @override
  int hasprofbounus = -1;

  // TODO: Здесь можно было бы реализовать обработку машинного обучения (ML) для анализа характеристик инструментов.
  // TODO: Можно также расширить функциональность для обработки разных типов музыкальных инструментов.

  // Статический метод для удаления инструментов по мета-флагу.
  static void deletebyMeta(Set<ToolSkill>? tools, MetaFlags m) {
    for (ToolSkill l in tools!) {
      if (l.metadata.MetaFlags_.contains(m)) {
        tools.remove(l); // Удаляем инструмент, если он помечен соответствующим флагом.
>>>>>>> a369b55968a88d62a58f0a21c32f502b27b3be24
      }
    }
  }
}