// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      fields[0] as BuildContext,
    )
      ..name = fields[1] as String
      ..race = fields[2] as Race?
      ..bg = fields[3] as Background?
      ..class_ = fields[4] as CharClass?
      ..STR = fields[5] as BasicStat
      ..DEX = fields[6] as BasicStat
      ..CON = fields[7] as BasicStat
      ..INT = fields[8] as BasicStat
      ..WIS = fields[9] as BasicStat
      ..CHR = fields[10] as BasicStat
      ..Acrobatics = fields[11] as Skill?
      ..Animal_Handling = fields[12] as Skill?
      ..Arcana = fields[13] as Skill?
      ..Athletics = fields[14] as Skill?
      ..Deception = fields[15] as Skill?
      ..History = fields[16] as Skill?
      ..Insight = fields[17] as Skill?
      ..Intimidation = fields[18] as Skill?
      ..Investigation = fields[19] as Skill?
      ..Medicine = fields[20] as Skill?
      ..Nature = fields[21] as Skill?
      ..Perception = fields[22] as Skill?
      ..Performance = fields[23] as Skill?
      ..Persuasion = fields[24] as Skill?
      ..Religion = fields[25] as Skill?
      ..Sleight_of_Hand = fields[26] as Skill?
      ..Stealth = fields[27] as Skill?
      ..Survival = fields[28] as Skill?
      ..ProfBonus = fields[29] as int
      ..lvl = fields[30] as int
      ..exp = fields[31] as int
      ..PassiveInsight = fields[32] as int
      ..InitiativeBonus = fields[33] as int
      ..armor = fields[34] as int
      ..tools = (fields[35] as Set).cast<ToolSkill>()
      ..langs = (fields[36] as Set).cast<Langs>()
      ..health = fields[37] as Health
      ..CanUseArmor = (fields[38] as Set).cast<AbstractArmor>()
      ..canUseWeapon = (fields[39] as Set).cast<AbstractWeapon>()
      ..wallet = fields[40] as Money
      ..inventory = fields[41] as InventorySystem
      ..size = fields[42] as Size?
      ..speed = fields[43] as int?;
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(44)
      ..writeByte(0)
      ..write(obj.UIContext)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.race)
      ..writeByte(3)
      ..write(obj.bg)
      ..writeByte(4)
      ..write(obj.class_)
      ..writeByte(5)
      ..write(obj.STR)
      ..writeByte(6)
      ..write(obj.DEX)
      ..writeByte(7)
      ..write(obj.CON)
      ..writeByte(8)
      ..write(obj.INT)
      ..writeByte(9)
      ..write(obj.WIS)
      ..writeByte(10)
      ..write(obj.CHR)
      ..writeByte(11)
      ..write(obj.Acrobatics)
      ..writeByte(12)
      ..write(obj.Animal_Handling)
      ..writeByte(13)
      ..write(obj.Arcana)
      ..writeByte(14)
      ..write(obj.Athletics)
      ..writeByte(15)
      ..write(obj.Deception)
      ..writeByte(16)
      ..write(obj.History)
      ..writeByte(17)
      ..write(obj.Insight)
      ..writeByte(18)
      ..write(obj.Intimidation)
      ..writeByte(19)
      ..write(obj.Investigation)
      ..writeByte(20)
      ..write(obj.Medicine)
      ..writeByte(21)
      ..write(obj.Nature)
      ..writeByte(22)
      ..write(obj.Perception)
      ..writeByte(23)
      ..write(obj.Performance)
      ..writeByte(24)
      ..write(obj.Persuasion)
      ..writeByte(25)
      ..write(obj.Religion)
      ..writeByte(26)
      ..write(obj.Sleight_of_Hand)
      ..writeByte(27)
      ..write(obj.Stealth)
      ..writeByte(28)
      ..write(obj.Survival)
      ..writeByte(29)
      ..write(obj.ProfBonus)
      ..writeByte(30)
      ..write(obj.lvl)
      ..writeByte(31)
      ..write(obj.exp)
      ..writeByte(32)
      ..write(obj.PassiveInsight)
      ..writeByte(33)
      ..write(obj.InitiativeBonus)
      ..writeByte(34)
      ..write(obj.armor)
      ..writeByte(35)
      ..write(obj.tools.toList())
      ..writeByte(36)
      ..write(obj.langs.toList())
      ..writeByte(37)
      ..write(obj.health)
      ..writeByte(38)
      ..write(obj.CanUseArmor.toList())
      ..writeByte(39)
      ..write(obj.canUseWeapon.toList())
      ..writeByte(40)
      ..write(obj.wallet)
      ..writeByte(41)
      ..write(obj.inventory)
      ..writeByte(42)
      ..write(obj.size)
      ..writeByte(43)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
