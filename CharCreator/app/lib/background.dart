// ignore_for_file: constant_identifier_names, non_constant_identifier_names, camel_case_types

import 'package:flutter_application_1/ui/modal_service.dart';
import 'stat.dart';
import 'tool.dart';
import 'langs.dart';
import 'meta.dart';
import 'character.dart';
enum BackgroundNames {
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

// Конфигурация для предысторий
class BackgroundConfig {
  final String name;
  final Set<StatNames> skillProficiencies;
  final Set<String> toolProficiencies;
  final int extraLanguages;

  const BackgroundConfig({
    required this.name,
    required this.skillProficiencies,
    required this.toolProficiencies,
    this.extraLanguages = 0,
  });
}

// Базовый класс для всех предысторий
abstract base class BaseBackground implements Background {
  final BackgroundConfig config;

  @override
  String get BGName => config.name;

  BaseBackground(this.config);

  @override
  Future<void> apply(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService modalService,
  ) async {
    // Применяем бонусы к навыкам
    for (final skill in config.skillProficiencies) {
      stats[skill]?.hasprofbounus += 1;
    }

    // Добавляем инструменты
    for (final tool in config.toolProficiencies) {
      tools.add(ToolSkill(tool,modalService, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_BG
      }));
    }

    // Добавляем языки, если есть
    if (config.extraLanguages > 0) {
      await _addLanguages(langs, modalService, config.extraLanguages);
    }
  }

  @override
  void delete(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
  ) {
    // Убираем бонусы навыков
    for (final skill in config.skillProficiencies) {
      stats[skill]?.hasprofbounus -= 1;
    }

    // Удаляем инструменты
    ToolSkill.deletebyMeta(tools, MetaFlags.IS_PICKED_ON_BG);
    
    // Удаляем языки
    Langs.deletebyMeta(langs, MetaFlags.IS_PICKED_ON_BG);
  }

  Future<void> _addLanguages(
  Set<Langs> langs,
  ModalService modalService,
  int count,
) async {
  if (count == 1) {
    // One language - await the Future
    final chosen = await Langs('').pick();
    
    if (chosen != null) {
      langs.add(Langs(chosen, {
        MetaFlags.IS_PICKED,
        MetaFlags.IS_PICKED_ON_BG
      }, modalService));
    }
  } else {
    // Multiple languages
    final chosen = await Langs('').pickmany();
    
    if (chosen != null) {
      for (final language in chosen) {
        langs.add(Langs(language, {
          MetaFlags.IS_PICKED,
          MetaFlags.IS_PICKED_ON_BG
        }, modalService));
      }
    }
  }
}
}
// Абстрактный интерфейс для предысторий
abstract interface class Background implements AffectsStatBackground, Stat {
  String get BGName;
  
  factory Background.withContext(String chosen, Character char,ModalService modalService) {
    final constructor = _backgroundConstructors[chosen.toLowerCase()];
    if (constructor != null) {
      return constructor(
        char.getskills(),
        char.getToolingskills(),
        char.getLangs(),
        modalService
      );
    }
    return Undefined(
      char.getskills(),
      char.getToolingskills(),
      char.getLangs(),
      modalService
    );
  }
  
  static final _backgroundConstructors = <String, Background Function(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  )>{
    'артист': (stats, tools, langs, context) => 
      Entertainer(stats, tools, langs, context),
    'беспризорник': (stats, tools, langs, context) => 
      Urchin(stats, tools, langs, context),
    'благородный': (stats, tools, langs, context) => 
      Noble(stats, tools, langs, context),
    'гильдейский ремесленник': (stats, tools, langs, context) => 
      GuildArtisan(stats, tools, langs, context),
    'моряк': (stats, tools, langs, context) => 
      Sailor(stats, tools, langs, context),
    'мудрец': (stats, tools, langs, context) => 
      Sage(stats, tools, langs, context),
    'народный герой': (stats, tools, langs, context) => 
      FolkHero(stats, tools, langs, context),
    'отшельник': (stats, tools, langs, context) => 
      Hermit(stats, tools, langs, context),
    'пират': (stats, tools, langs, context) => 
      Pirate(stats, tools, langs, context),
    'преступник': (stats, tools, langs, context) => 
      Criminal(stats, tools, langs, context),
    'прислужник': (stats, tools, langs, context) => 
      Acolyte(stats, tools, langs, context),
    'солдат': (stats, tools, langs, context) => 
      Soldier(stats, tools, langs, context),
    'чужеземец': (stats, tools, langs, context) => 
      Outlander(stats, tools, langs, context),
    'шарлатан': (stats, tools, langs, context) => 
      Charlatan(stats, tools, langs, context),
  };
}

// Конфигурации для всех предысторий
class BackgroundConfigs {
  static const entertainer = BackgroundConfig(
    name: "Артист",
    skillProficiencies: {
      StatNames.Acrobatics,
      StatNames.Performance,
    },
    toolProficiencies: {
      "Набор для грима",
      "музыкальные инструменты",
    },
  );

  static const urchin = BackgroundConfig(
    name: "Беспризорник",
    skillProficiencies: {
      StatNames.Sleight_of_Hand,
      StatNames.Stealth,
    },
    toolProficiencies: {
      "Набор для грима",
      "воровские инструменты",
    },
  );

  static const noble = BackgroundConfig(
    name: "Благородный",
    skillProficiencies: {
      StatNames.History,
      StatNames.Persuasion,
    },
    toolProficiencies: {"игровой набор"},
    extraLanguages: 1,
  );

  static const guildArtisan = BackgroundConfig(
    name: "Гильдейский Ремесленник",
    skillProficiencies: {
      StatNames.Persuasion,
      StatNames.Insight,
    },
    toolProficiencies: {"инструменты ремесленников"},
    extraLanguages: 1,
  );

  static const sailor = BackgroundConfig(
    name: "Моряк",
    skillProficiencies: {
      StatNames.Athletics,
      StatNames.Perception,
    },
    toolProficiencies: {
      "инструменты навигатора",
      "водный транспорт",
    },
  );

  static const sage = BackgroundConfig(
    name: "Мудрец",
    skillProficiencies: {
      StatNames.History,
      StatNames.Arcana,
    },
    toolProficiencies: {},
    extraLanguages: 2,
  );

  static const folkHero = BackgroundConfig(
    name: "Народный герой",
    skillProficiencies: {
      StatNames.Survival,
      StatNames.Animal_Handling,
    },
    toolProficiencies: {
      "инструменты ремесленников",
      "наземный транспорт",
    },
  );

  static const hermit = BackgroundConfig(
    name: "Отшельник",
    skillProficiencies: {
      StatNames.Medicine,
      StatNames.Religion,
    },
    toolProficiencies: {"Набор травника"},
    extraLanguages: 1,
  );

  static const pirate = BackgroundConfig(
    name: "Пират",
    skillProficiencies: {
      StatNames.Athletics,
      StatNames.Perception,
    },
    toolProficiencies: {
      "инструменты навигатора",
      "водный транспорт",
    },
  );

  static const criminal = BackgroundConfig(
    name: "Преступник",
    skillProficiencies: {
      StatNames.Stealth,
      StatNames.Deception,
    },
    toolProficiencies: {
      "воровские инструменты",
      "игровой набор",
    },
  );

  static const acolyte = BackgroundConfig(
    name: "Прислужник",
    skillProficiencies: {
      StatNames.Insight,
      StatNames.Religion,
    },
    toolProficiencies: {},
    extraLanguages: 2,
  );

  static const soldier = BackgroundConfig(
    name: "Солдат",
    skillProficiencies: {
      StatNames.Athletics,
      StatNames.Intimidation,
    },
    toolProficiencies: {
      "наземный транспорт",
      "игровой набор",
    },
  );

  static const outlander = BackgroundConfig(
    name: "Чужеземец",
    skillProficiencies: {
      StatNames.Athletics,
      StatNames.Survival,
    },
    toolProficiencies: {"музыкальные инструменты"},
    extraLanguages: 1,
  );

  static const charlatan = BackgroundConfig(
    name: "Шарлатан",
    skillProficiencies: {
      StatNames.Sleight_of_Hand,
      StatNames.Deception,
    },
    toolProficiencies: {
      "набор для грима",
      "набор для фальсификации",
    },
  );
}
// Класс для неопределенной предыстории
final class Undefined extends BaseBackground {
  Undefined(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(const BackgroundConfig(
    name: "Не выбрано",
    skillProficiencies: {},
    toolProficiencies: {},
  )) {
    apply(stats, tools, langs, context);
  }

  @override
  Future<void> apply(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService modalService,
  ) async {
    // Не применяем никаких изменений
  }
}

// Конкретные классы предысторий
final class Entertainer extends BaseBackground {
  Entertainer(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.entertainer) {
    apply(stats, tools, langs, context);
  }
}

final class Urchin extends BaseBackground {
  Urchin(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.urchin) {
    apply(stats, tools, langs, context);
  }
}

final class Noble extends BaseBackground {
  Noble(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.noble) {
    apply(stats, tools, langs, context);
  }
}

final class GuildArtisan extends BaseBackground {
  GuildArtisan(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.guildArtisan) {
    apply(stats, tools, langs, context);
  }
}

final class Sailor extends BaseBackground {
  Sailor(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.sailor) {
    apply(stats, tools, langs, context);
  }
}

final class Sage extends BaseBackground {
  Sage(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.sage) {
    apply(stats, tools, langs, context);
  }
}

final class FolkHero extends BaseBackground {
  FolkHero(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.folkHero) {
    apply(stats, tools, langs, context);
  }
}

final class Hermit extends BaseBackground {
  Hermit(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.hermit) {
    apply(stats, tools, langs, context);
  }
}

final class Pirate extends BaseBackground {
  Pirate(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.pirate) {
    apply(stats, tools, langs, context);
  }
}

final class Criminal extends BaseBackground {
  Criminal(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.criminal) {
    apply(stats, tools, langs, context);
  }
}

final class Acolyte extends BaseBackground {
  Acolyte(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.acolyte) {
    apply(stats, tools, langs, context);
  }
}

final class Soldier extends BaseBackground {
  Soldier(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.soldier) {
    apply(stats, tools, langs, context);
  }
}

final class Outlander extends BaseBackground {
  Outlander(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.outlander) {
    apply(stats, tools, langs, context);
  }
}

final class Charlatan extends BaseBackground {
  Charlatan(
    Map<StatNames, ProfBonusStat> stats,
    Set<ToolSkill> tools,
    Set<Langs> langs,
    ModalService context,
  ) : super(BackgroundConfigs.charlatan) {
    apply(stats, tools, langs, context);
  }
}