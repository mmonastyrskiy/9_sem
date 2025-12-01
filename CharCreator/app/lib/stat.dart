// ignore_for_file: constant_identifier_names, non_constant_identifier_names

// Импорт необходимых библиотек и модулей
import 'tool.dart';
import 'langs.dart';
import 'dice.dart';
import 'items/item.dart';
import 'meta.dart';
import 'ui/modal_service.dart';

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
  ToolSkills;

  static StatNames fromSkill(Skills skillToAdd) {
    switch (skillToAdd) {
      case Skills.Athletics: return StatNames.Athletics;
      case Skills.Acrobatics: return StatNames.Acrobatics;
      case Skills.Sleight_of_Hand: return StatNames.Sleight_of_Hand;
      case Skills.Stealth: return StatNames.Stealth;
      case Skills.Investigation: return StatNames.Investigation;
      case Skills.History: return StatNames.History;
      case Skills.Arcana: return StatNames.Arcana;
      case Skills.Nature: return StatNames.Nature;
      case Skills.Religion: return StatNames.Religion;
      case Skills.Perception: return StatNames.Perception;
      case Skills.Survival: return StatNames.Survival;
      case Skills.Medicine: return StatNames.Medicine;
      case Skills.Insight: return StatNames.Insight;
      case Skills.Animal_Handling: return StatNames.Animal_Handling;
      case Skills.Performance: return StatNames.Performance;
      case Skills.Intimidation: return StatNames.Intimidation;
      case Skills.Deception: return StatNames.Deception;
      case Skills.Persuasion: return StatNames.Persuasion;
    }

  }         // Владение инструментами
}

// Перечисление только базовых характеристик (без навыков)
enum BasicStatNames {
  STR,  // Сила
  DEX,  // Ловкость
  CON,  // Телосложение
  INT,  // Интеллект
  WIS,  // Мудрость
  CHR,  // Харизма
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

// Extension для удобного получения отображаемых имен навыков
extension SkillsExtension on Skills {
  String get displayName {
    switch (this) {
      case Skills.Athletics: return 'атлетика';
      case Skills.Acrobatics: return 'акробатика';
      case Skills.Sleight_of_Hand: return 'ловкость рук';
      case Skills.Stealth: return 'скрытность';
      case Skills.Investigation: return 'анализ';
      case Skills.History: return 'история';
      case Skills.Arcana: return 'магия';
      case Skills.Nature: return 'природа';
      case Skills.Religion: return 'религия';
      case Skills.Perception: return 'восприятие';
      case Skills.Survival: return 'выживание';
      case Skills.Medicine: return 'медицина';
      case Skills.Insight: return 'проницательность';
      case Skills.Animal_Handling: return 'уход за животными';
      case Skills.Performance: return 'выступление';
      case Skills.Intimidation: return 'запугивание';
      case Skills.Deception: return 'обман';
      case Skills.Persuasion: return 'убеждение';
    }
  }
}

// Extension для преобразования Skills в StatNames
extension SkillsToStatNames on Skills {
  StatNames get toStatName {
    switch (this) {
      case Skills.Athletics: return StatNames.Athletics;
      case Skills.Acrobatics: return StatNames.Acrobatics;
      case Skills.Sleight_of_Hand: return StatNames.Sleight_of_Hand;
      case Skills.Stealth: return StatNames.Stealth;
      case Skills.Investigation: return StatNames.Investigation;
      case Skills.History: return StatNames.History;
      case Skills.Arcana: return StatNames.Arcana;
      case Skills.Nature: return StatNames.Nature;
      case Skills.Religion: return StatNames.Religion;
      case Skills.Perception: return StatNames.Perception;
      case Skills.Survival: return StatNames.Survival;
      case Skills.Medicine: return StatNames.Medicine;
      case Skills.Insight: return StatNames.Insight;
      case Skills.Animal_Handling: return StatNames.Animal_Handling;
      case Skills.Performance: return StatNames.Performance;
      case Skills.Intimidation: return StatNames.Intimidation;
      case Skills.Deception: return StatNames.Deception;
      case Skills.Persuasion: return StatNames.Persuasion;
    }
  }
}

// Extension для преобразования StatNames в Skills
extension StatNamesToSkills on StatNames {
  Skills? get toSkill {
    switch (this) {
      case StatNames.Athletics: return Skills.Athletics;
      case StatNames.Acrobatics: return Skills.Acrobatics;
      case StatNames.Sleight_of_Hand: return Skills.Sleight_of_Hand;
      case StatNames.Stealth: return Skills.Stealth;
      case StatNames.Investigation: return Skills.Investigation;
      case StatNames.History: return Skills.History;
      case StatNames.Arcana: return Skills.Arcana;
      case StatNames.Nature: return Skills.Nature;
      case StatNames.Religion: return Skills.Religion;
      case StatNames.Perception: return Skills.Perception;
      case StatNames.Survival: return Skills.Survival;
      case StatNames.Medicine: return Skills.Medicine;
      case StatNames.Insight: return Skills.Insight;
      case StatNames.Animal_Handling: return Skills.Animal_Handling;
      case StatNames.Performance: return Skills.Performance;
      case StatNames.Intimidation: return Skills.Intimidation;
      case StatNames.Deception: return Skills.Deception;
      case StatNames.Persuasion: return Skills.Persuasion;
      default: return null;
    }
  }
}

// Базовый интерфейс для всех объектов, которые влияют на статистики
abstract interface class AffectsStat {}

// Интерфейс для объектов, влияющих на статистики через предысторию (Background)
abstract interface class AffectsStatBackground implements AffectsStat {
  // Применяет эффекты предыстории к статистикам, инструментам и языкам
  Future<void> apply(
    Map<StatNames, ProfBonusStat> stats, 
    Set<ToolSkill> tools, 
    Set<Langs> langs,
    ModalService modalService
  );
  // Удаляет эффекты предыстории
  void delete(
    Map<StatNames, ProfBonusStat> stats, 
    Set<ToolSkill> tools, 
    Set<Langs> langs
  );
}

// Интерфейс для объектов, влияющих на статистики через класс (Class)
abstract interface class AffectsStatClass implements AffectsStat {
  // Применяет эффекты класса к здоровью, характеристикам, навыкам, броне, оружию и инструментам
  Future<void> apply(
    Health charHeath, 
    Map<BasicStatNames, BasicStat> stats, 
    Map<StatNames, Skill> skills, 
    Set<AbstractArmor> canUseArmor, 
    Set<AbstractWeapon> canUseWeapon, 
    Set<ToolSkill> tools,
    ModalService modalService
  );
  // Удаляет эффекты класса
  void delete(
    Health charHeath, 
    Map<BasicStatNames, BasicStat> stats, 
    Map<StatNames, Skill> skills,
    Set<AbstractArmor> canUseArmor, 
    Set<AbstractWeapon> canUseWeapon, 
    Set<ToolSkill> tools
  );
}

// Интерфейс для объектов, влияющих на статистики через расу (Race)
abstract interface class AffectsStatRace implements AffectsStat {
  // Применяет эффекты расы к характеристикам, размеру, скорости, языкам, инструментам, броне и здоровью
  Future<void> apply(
    Map<BasicStatNames, BasicStat> stats,
    Size? size,
    int? speed,
    Set<Langs> langs,
    Set<ToolSkill> tools,
    Set<AbstractArmor> canUseArmor,
    Health health,
    Map<StatNames, Skill> skills,
    ModalService modalService,
    Set<AbstractWeapon> canUseWeapon,
  );
  // Удаляет эффекты расы
  void delete(
    Map<BasicStatNames, BasicStat> stats, 
    Size? size, 
    int? speed, 
    Set<Langs> langs, 
    Set<ToolSkill> tools, 
    Set<AbstractArmor> canUseArmor, 
    Health health,
    Map<StatNames, Skill> skills,
    Set<AbstractWeapon> canUseWeapon
  ); 
}

// Базовый интерфейс для всех статистик
abstract interface class Stat {}

// Интерфейс для объектов, которые могут быть обновлены (имеют модификаторы)
abstract interface class Updateable {
  // Список модификаторов, влияющих на этот объект
  List<Modifier> get affectedby;
  // Обновляет значение с указанным эффектом и флагами
  void update(int effect, Set<MetaFlags> flags);
  // Удаляет модификаторы по указанному мета-флагу
  void deletebyMeta(MetaFlags m);
}

// Интерфейс для статистик, которые могут иметь бонус владения
abstract interface class ProfBonusStat implements Stat {
  // Уровень бонуса владения (0 - нет владения, 1+ - есть владение)
  int get hasprofbounus;
  set hasprofbounus(int value);
}

// Интерфейс для объектов, которые можно выбирать
abstract interface class Pickable {
  Future<String?> pick(ModalService modalService);
  Future<Set<String>> pickmany(
    ModalService modalService, 
    [List<String>? initialSelections, 
    int howmany = 2,
    Set<Skills>? includeSkills
  ]);
}

// Класс для базовых характеристик (сила, ловкость, телосложение, интеллект, мудрость, харизма)
class BasicStat implements Stat, Updateable, Pickable {
  late int value;        // Базовое значение характеристики (например, 15 для силы)
  int mod = 0;           // Модификатор характеристики (рассчитывается из value)
  int savingthrow = 0;   // Бонус спасброска (0 - нет, 1 - есть)
  int savingthrowvalue = 0;
  
  @override
  final List<Modifier> affectedby = [];  // Список модификаторов, влияющих на эту характеристику

  // Метод для расчета модификатора характеристики по D&D правилам: (value - 10) / 2 с округлением вниз
  int stat2Modifier() => mod = ((value - 10) / 2).floor();
  
  BasicStat generate() {
    final tosser = ThrowObject();
    tosser.add(6, ammount: 4);
    tosser.DoRoll();
    tosser.strip(1);
    value = tosser.total();
    stat2Modifier();
    return this;
  }
  
  // Конструктор базовой характеристики
  BasicStat([int val = 10]) {
    value = val;          // Устанавливаем базовое значение
    mod = stat2Modifier(); // Рассчитываем модификатор
  }
  
  @override
  void update(int effect, Set<MetaFlags> flags) {
    value += effect;                    // Изменяем значение характеристики
    mod = stat2Modifier();              // Пересчитываем модификатор
    affectedby.add(Modifier(effect, flags)); // Добавляем модификатор в список
  }
  
  @override
  void deletebyMeta(MetaFlags m) {
    if (affectedby.isEmpty) return;
    
    // Проходим по всем модификаторам
    for (Modifier l in List.from(affectedby)) {
      // Если модификатор имеет указанный мета-флаг
      if (l.metadata.MetaFlags_.contains(m)) {
        value -= l.value;          // Отменяем эффект модификатора 
        mod = stat2Modifier();     // Пересчитываем модификатор
        affectedby.remove(l);      // Удаляем модификатор из списка
      }
    }
  }

  Set<String> get menu => str2BasicStat().keys.toSet();
  
  Set get ret => str2BasicStat().values.toSet();
  
  @override
  Future<String?> pick(ModalService modalService) async {
    final items = str2BasicStat();
    return await modalService.showListPicker(items);
  }
  
  @override
  Future<Set<String>> pickmany(
    ModalService modalService, 
    [List<String>? initialSelections, 
    int howmany = 2,
    Set<Skills>? includeSkills
  ]) async {
    final items = str2BasicStat();
    final selectedKeys = await modalService.showMultiSelectListPicker(
      items: items.keys.toSet(),
      initialSelections: initialSelections,
    );
    return selectedKeys;
  }
  
  static Map<String, BasicStatNames> str2BasicStat() {
    return {
      "сила": BasicStatNames.STR,
      "ловкость": BasicStatNames.DEX,
      "телосложение": BasicStatNames.CON,
      "интеллект": BasicStatNames.INT,
      "мудрость": BasicStatNames.WIS,
      "харизма": BasicStatNames.CHR
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
  @override
  int hasprofbounus = 0;   // Бонус владения навыком

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
      default: bs = BasicStatNames.NULL;
    }
    if (flags != null) {
      metadata.MetaFlags_ = flags;
    }
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

  static Map<Skills, StatNames> skillToStatName() {
    return {
      Skills.Athletics: StatNames.Athletics,
      Skills.Acrobatics: StatNames.Acrobatics,
      Skills.Sleight_of_Hand: StatNames.Sleight_of_Hand,
      Skills.Stealth: StatNames.Stealth,
      Skills.Investigation: StatNames.Investigation,
      Skills.History: StatNames.History,
      Skills.Arcana: StatNames.Arcana,
      Skills.Nature: StatNames.Nature,
      Skills.Religion: StatNames.Religion,
      Skills.Perception: StatNames.Perception,
      Skills.Survival: StatNames.Survival,
      Skills.Medicine: StatNames.Medicine,
      Skills.Insight: StatNames.Insight,
      Skills.Animal_Handling: StatNames.Animal_Handling,
      Skills.Performance: StatNames.Performance,
      Skills.Intimidation: StatNames.Intimidation,
      Skills.Deception: StatNames.Deception,
      Skills.Persuasion: StatNames.Persuasion  
    };
  }

  // Статический метод для удаления бонусов владения по мета-флагу
  static void deletebyMeta(Map<StatNames, Skill> skills, MetaFlags flag) {
    for (final s in skills.values) {
      if (s.metadata.MetaFlags_.contains(flag)) {
        s.hasprofbounus -= 1;  // Уменьшаем бонус владения
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED_ON_CLASS);  // Удаляем флаг выбора на классе
        s.metadata.MetaFlags_.remove(MetaFlags.IS_PICKED);           // Удаляем общий флаг выбора
      }
    }
  }

  Set<String> get menu => string2skill().keys.toSet();
  
  Set get ret => string2skill().values.toSet();
  
  @override
  Future<String?> pick(ModalService modalService) async {
    final items = string2skill();
    return await modalService.showListPicker(items);
  }

  @override
  Future<Set<String>> pickmany(
    ModalService modalService, 
    [List<String>? initialSelections, 
    int howmany = 2,
    Set<Skills>? includeSkills
  ]) async {
    Map<String, Skills> availableSkills = string2skill();
    
    // Если указан набор для включения, фильтруем только эти элементы
    if (includeSkills != null) {
      availableSkills.removeWhere((key, value) => !includeSkills.contains(value));
    }
    
    final selectedSkills = await modalService.showMultiSelectListPicker(
      items: availableSkills.keys.toSet(),
      initialSelections: initialSelections,
    );
    
    return selectedSkills;
  }
}

// Класс для представления здоровья персонажа
class Health implements Updateable {
  int max_health = 0;      // Максимальное здоровье
  int current_health = 0;  // Текущее здоровье
  DiceType? hitDice;       // Тип кости хитов (D6, D8, D10, D12)
  
  @override
  final List<Modifier> affectedby = [];  // Список модификаторов здоровья
  
  @override
  void deletebyMeta(MetaFlags m) {
    for (Modifier l in List.from(affectedby)) {
      if (l.metadata.MetaFlags_.contains(m)) {
        max_health -= l.value;          // Отменяем эффект модификатора
        affectedby.remove(l);           // Удаляем модификатор
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