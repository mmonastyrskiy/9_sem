// ignore_for_file: constant_identifier_names, non_constant_identifier_names

// Импорт необходимых библиотек и модулей
import 'ui/uicore.dart';
import 'package:flutter/material.dart';
import 'tool.dart';
import 'langs.dart';
import 'dice.dart';
import 'items.dart';
import 'meta.dart';
import 'ui/uisnippets.dart';

// Перечисление всех имен статистик в системе (базовые характеристики + навыки + прочее)
enum StatNames {
  Background,        // Предыстория
  STR,               // Сила (базовая характеристика)
  DEX,               // Ловкость (базовая характеристика)
  CON,               // Телосложение (базовая характеристика)
  INT,               // Интеллект (базовая характеристика)
  WIS,               // Мудрость (базовая характеристика)
  CHR,               // Харизма (базовая характеристика)
  Acrobatics,        // Акробатика (навык)
  Animal_Handling,   // Уход за животными (навык)
  Arcana,            // Магия (навык)
  Athletics,         // Атлетика (навык)
  Deception,         // Обман (навык)
  History,           // История (навык)
  Insight,           // Проницательность (навык)
  Intimidation,      // Запугивание (навык)
  Investigation,     // Расследование (навык)
  Medicine,          // Медицина (навык)
  Nature,            // Природа (навык)
  Perception,        // Внимательность (навык)
  Performance,       // Выступление (навык)
  Persuasion,        // Убеждение (навык)
  Religion,          // Религия (навык)
  Sleight_of_Hand,   // Ловкость рук (навык)
  Stealth,           // Скрытность (навык)
  Survival,          // Выживание (навык)
  ToolSkills         // Владение инструментами
}

// Перечисление только базовых характеристик (без навыков)
enum BasicStatNames {
  STR,  // Сила
  DEX,  // Ловкость
  CON,  // Телосложение
  INT,  // Интеллект
  WIS,  // Мудрость
  CHR,   // Харизма
  NULL
}

// Перечисление всех навыков персонажа
enum Skills {
  Acrobatics,        // Акробатика
  Animal_Handling,   // Уход за животными
  Arcana,            // Магия
  Athletics,         // Атлетика
  Deception,         // Обман
  History,           // История
  Insight,           // Проницательность
  Intimidation,      // Запугивание
  Investigation,     // Расследование
  Medicine,          // Медицина
  Nature,            // Природа
  Perception,        // Внимательность
  Performance,       // Выступление
  Persuasion,        // Убеждение
  Religion,          // Религия
  Sleight_of_Hand,   // Ловкость рук
  Stealth,           // Скрытность
  Survival           // Выживание
}

// Базовый интерфейс для всех объектов, которые влияют на статистики
abstract interface class AffectsStat {}

// Интерфейс для объектов, влияющих на статистики через предысторию (Background)
abstract interface class AffectsStatBackground implements AffectsStat {
  // Применяет эффекты предыстории к статистикам, инструментам и языкам
  void apply(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs, BuildContext context);
  // Удаляет эффекты предыстории
  void delete(Map<StatNames, ProfBonusStat> stats, Set<ToolSkill> tools, Set<Langs> langs);
}

// Интерфейс для объектов, влияющих на статистики через класс (Class)
abstract interface class AffectsStatClass implements AffectsStat {
  // Применяет эффекты класса к здоровью, характеристикам, навыкам, броне, оружию и инструментам
  void apply(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills, 
             Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools, BuildContext context);
  // Удаляет эффекты класса
  void delete(Health charHeath, Map<BasicStatNames, BasicStat> stats, Map<StatNames, Skill> skills,
              Set<Armor> canUseArmor, Set<Weapon> canUseWeapon, Set<ToolSkill> tools);
}

// Интерфейс для объектов, влияющих на статистики через расу (Race)
abstract interface class AffectsStatRace implements AffectsStat {
  // Применяет эффекты расы к характеристикам, размеру, скорости, языкам, инструментам, броне и здоровью
  void apply(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, 
             Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health,Map<StatNames, Skill> skills,BuildContext context,Set<Weapon> canUseWeapon);
  // Удаляет эффекты расы
  void delete(Map<BasicStatNames, BasicStat> stats, Size? size, int? speed, Set<Langs> langs, 
              Set<ToolSkill> tools, Set<Armor> canUseArmor, Health health,Map<StatNames, Skill> skills,Set<Weapon> canUseWeapon); // TODO: унификация?
}

// Базовый интерфейс для всех статистик
abstract interface class Stat {}

// Интерфейс для объектов, которые могут быть обновлены (имеют модификаторы)
abstract interface class Updateable {
  // Список модификаторов, влияющих на этот объект
  List<Modifier> affectedby = [];
  // Обновляет значение с указанным эффектом и флагами
  void update(int effect, Set<MetaFlags> flags);
  // Удаляет модификаторы по указанному мета-флагу
  void deletebyMeta(MetaFlags m);
}

// Интерфейс для статистик, которые могут иметь бонус владения
abstract interface class ProfBonusStat implements Stat {
  // Уровень бонуса владения (0 - нет владения, 1+ - есть владение)
  int hasprofbounus = 0;  // Опечатка: должно быть hasproficiencybonus
}

// Класс для базовых характеристик (сила, ловкость, телосложение, интеллект, мудрость, харизма)
class BasicStat implements Stat, Updateable,Pickable {
  late int value;        // Базовое значение характеристики (например, 15 для силы)
  int mod = 0;           // Модификатор характеристики (рассчитывается из value)
  int savingthrow = 0;   // Бонус спасброска (0 - нет, 1 - есть)
  int savingthrowvalue = 0;
  @override
  List<Modifier> affectedby = [];  // Список модификаторов, влияющих на эту характеристику

  // Метод для расчета модификатора характеристики по D&D правилам: (value - 10) / 2 с округлением вниз
  int Stat2Modifier() => mod = ((value - 10) / 2).floor();
  BasicStat generate(){
    ThrowObject tosser = ThrowObject();
    tosser.add(6,ammount: 4);
    tosser.DoRoll();
    print(tosser.tostr());
    print("------------------------------");
    tosser.strip(1);
    print(tosser.tostr());
    print("------------------------------");
    value = tosser.total();
    Stat2Modifier();
    return this;
  }
  
  // Конструктор базовой характеристики
  BasicStat([int val=10]) {
    value = val;          // Устанавливаем базовое значение
    mod = Stat2Modifier(); // Рассчитываем модификатор
  }
  
  @override
  void update(int effect, Set<MetaFlags> flags) {
    value += effect;                    // Изменяем значение характеристики
    mod = Stat2Modifier();              // Пересчитываем модификатор
    affectedby.add(Modifier(effect, flags)); // Добавляем модификатор в список
    // TODO: Надо еще пересчитывать статы зависимые от базовых статов (навыки и т.д.)
  }
  
  @override
  void deletebyMeta(MetaFlags m) {
    print(affectedby.length);
    if(affectedby.isEmpty){
      return;
    }
    // Проходим по всем модификаторам
    for (Modifier l in affectedby) {
      // Если модификатор имеет указанный мета-флаг
      if (l.metadata.MetaFlags_.contains(m)) {
        value -= l.value;          // Отменяем эффект модификатора 
        mod = Stat2Modifier();          // Пересчитываем модификатор
        affectedby.remove(l);           // Удаляем модификатор из списка
        // TODO: Надо еще пересчитывать статы зависимые от базовых статов
      }
    }
  }
  


  @override
  Set<String> menu=str2BasicStat().keys.toSet();
  
  @override
  Set ret=str2BasicStat().values.toSet();
  
  @override
  String? pick(BuildContext bc) {
    // TODO: implement pick
    throw UnimplementedError();
  }
  
  @override
  Future<Set<String>> pickmany(BuildContext bc, [List<String>? initialSelections, int howmany = 2]) {
    // TODO: implement pickmany
    throw UnimplementedError();
  }
 static Map<String,BasicStatNames> str2BasicStat(){
  return {
  "сила" :BasicStatNames.STR,  // Сила
  "ловкость":BasicStatNames.DEX,  // Ловкость
  "телосложение":BasicStatNames.CON,  // Телосложение
  "интеллект":BasicStatNames.INT,  // Интеллект
  "мудрость":BasicStatNames.WIS,  // Мудрость
  "харизма":BasicStatNames.CHR   // Харизма
};
}
}

// Класс для представления модификатора (изменения значения)
class Modifier {
  int value = 0;         // Величина модификатора (может быть положительной или отрицательной)
  Meta metadata = Meta(); // Метаданные модификатора (источник, тип и т.д.)
  
  // Конструктор модификатора
  Modifier(this.value, Set<MetaFlags> flags) {
    metadata.MetaFlags_ = flags;  // Устанавливаем флаги метаданных
  }
}

// Extension для удобного преобразования int в BasicStat
extension IntToBasicStat on int {
  BasicStat toBasicStat() => BasicStat(this);
}

// Класс для навыков персонажа (акробатика, скрытность, убеждение и т.д.)
final class Skill implements ProfBonusStat, Pickable {
  late BasicStatNames bs;  // Базовая характеристика, от которой зависит этот навык
  Meta metadata = Meta();   // Метаданные навыка

  // Конструктор навыка
  Skill(String bsn, {Set<MetaFlags>? flags}) {
    // Определяем базовую характеристику based на переданной строке
    switch (bsn.toLowerCase()) {
      case "сила": bs = BasicStatNames.STR;
      case "ловкость": bs = BasicStatNames.DEX;
      case "телосложение": bs = BasicStatNames.CON;
      case "интеллект": bs = BasicStatNames.INT;  
      case "мудрость": bs = BasicStatNames.WIS;
      case "харизма": bs = BasicStatNames.CHR;
      default: bs =BasicStatNames.NULL;
    }
    if(flags != null){
      metadata.MetaFlags_ = flags;
    } // Устанавливаем флаги метаданных
  }
  
  // Метод для добавления мета-флага к навыку
  void addMeta(MetaFlags flag) {
    metadata.MetaFlags_.add(flag);
  }

  // Статический метод для преобразования русских названий навыков в enum значения
  static Map<String, Skills> string2skill() {
    return {
      'атлетика': Skills.Athletics,
      'акробатика': Skills.Acrobatics,
      'ловкость рук': Skills.Sleight_of_Hand,
      'скрытность': Skills.Stealth,
      'анализ': Skills.Investigation,
      'история': Skills.History,
      'магия': Skills.Arcana,
      'природа': Skills.Nature,
      'религия': Skills.Religion,
      'восприятие': Skills.Perception,
      'выживание': Skills.Survival,
      'медицина': Skills.Medicine,
      'проницательность': Skills.Insight,
      'уход за животными': Skills.Animal_Handling,
      'выступление': Skills.Performance,
      'запугивание': Skills.Intimidation,
      'обман': Skills.Deception,
      'убеждение': Skills.Persuasion  
    };
  }





 static Map<Skills,StatNames> S2SN() {
    return {
      Skills.Athletics:StatNames.Athletics,
      Skills.Acrobatics:StatNames.Acrobatics,
      Skills.Sleight_of_Hand:StatNames.Sleight_of_Hand,
      Skills.Stealth:StatNames.Stealth,
      Skills.Investigation:StatNames.Investigation,
      Skills.History:StatNames.History,
      Skills.Arcana:StatNames.Arcana,
      Skills.Nature:StatNames.Nature,
      Skills.Religion:StatNames.Religion,
      Skills.Perception:StatNames.Perception,
      Skills.Survival:StatNames.Survival,
      Skills.Medicine:StatNames.Medicine,
      Skills.Insight:StatNames.Insight,
      Skills.Animal_Handling:StatNames.Animal_Handling,
      Skills.Performance:StatNames.Performance,
      Skills.Intimidation:StatNames.Intimidation,
      Skills.Deception:StatNames.Deception,
      Skills.Persuasion:StatNames.Persuasion  
    };
  }




  // Статический метод для удаления бонусов владения по мета-флагу
  static void deletebyMeta(Map<StatNames, Skill> skills, MetaFlags flag) {
    for (Skill s in skills.values) {
      if (s.metadata.MetaFlags_.contains(flag)) {
        s.hasprofbounus -= 1;  // Уменьшаем бонус владения
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED_ON_CLASS);  // Удаляем флаг выбора на классе
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED);           // Удаляем общий флаг выбора
      }
    }
  }

  @override
  int hasprofbounus = 0;  // Бонус владения навыком
  
  @override
  Set<String> menu = string2skill().keys.toSet();  // Меню для выбора (русские названия)
  
  @override
  Set ret = string2skill().values.toSet();  // Соответствующие enum значения
  
  @override
  String? pick(BuildContext bc) {
    // TODO: implement pick - должен быть реализован для одиночного выбора
    throw UnimplementedError();
  }
  

Future<Set<String>> pickmany(BuildContext bc, [List<String>? initialSelections, int? howmany = 2, Set? include]) async {
  print("RAN pickmany");
  Set<String> menu = string2skill().keys.toSet();
  // Если указан набор для включения, фильтруем только эти элементы
if (include != null) {
  print("Removed");
  menu.removeWhere((val) => !include.contains(val));
}
  
  Set<String> res = await ModalDispatcher.showMultiSelectListPicker(
    context: bc, 
    items: string2skill().keys.toSet(), // TODO фильтр по данным не будет работать т к в include не строки, а Skill
    initialSelections: initialSelections
  );
  

  return res;
}
}

// Класс для представления здоровья персонажа
class Health implements Updateable {
  int max_health = 0;      // Максимальное здоровье
  int current_health = 0;  // Текущее здоровье
  DiceType? HitDice;       // Тип кости хитов (D6, D8, D10, D12)
  
  @override
  List<Modifier> affectedby = [];  // Список модификаторов здоровья
  
  @override
  void deletebyMeta(MetaFlags m) {
    for (Modifier l in affectedby) {
      if (l.metadata.MetaFlags_.contains(m)) {
        affectedby.remove(l);           // Удаляем модификатор
        max_health -= l.value;     // Отменяем эффект модификатора
      }
    }
  }
  
  @override
  void update(int effect, Set<MetaFlags> flags) {
    max_health += effect;                    // Изменяем максимальное здоровье
    affectedby.add(Modifier(effect, flags)); // Добавляем модификатор
  }
}

// Перечисление мировоззрений по D&D системе (моральная ось + этическая ось)
enum MindSets {
  LG,   // Lawful Good - Законно-добрый
  NG,   // Neutral Good - Нейтрально-добрый
  CG,   // Chaotic Good - Хаотично-добрый
  LN,   // Lawful Neutral - Законно-нейтральный
  N,    // True Neutral - Истинно нейтральный
  CN,   // Chaotic Neutral - Хаотично-нейтральный
  LE,   // Lawful Evil - Законно-злой
  NE,   // Neutral Evil - Нейтрально-злой
  CE,   // Chaotic Evil - Хаотично-злой
  ALL   // Любое мировоззрение
}

// Перечисление размеров существ
enum Size {
  SMALL,   // Маленький (гномы, полурослики)
  MEDIUM,  // Средний (люди, эльфы, дварфы)
  LARGE    // Большой (огры, великаны)
}