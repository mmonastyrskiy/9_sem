// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterViewAdapter extends TypeAdapter<CharacterView> {
  @override
  final int typeId = 1;

  @override
  CharacterView read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterView()
      ..name = fields[1] as String
      ..race = fields[2] as String
      ..bg = fields[3] as String
      ..class_ = fields[4] as String
      ..STR = fields[5] as String
      ..DEX = fields[6] as String
      ..CON = fields[7] as String
      ..INT = fields[8] as String
      ..WIS = fields[9] as String
      ..CHR = fields[10] as String
      ..Acrobatics = fields[11] as String
      ..Animal_Handling = fields[12] as String
      ..Arcana = fields[13] as String
      ..Athletics = fields[14] as String
      ..Deception = fields[15] as String
      ..History = fields[16] as String
      ..Insight = fields[17] as String
      ..Intimidation = fields[18] as String
      ..Investigation = fields[19] as String
      ..Medicine = fields[20] as String
      ..Nature = fields[21] as String
      ..Perception = fields[22] as String
      ..Performance = fields[23] as String
      ..Persuasion = fields[24] as String
      ..Religion = fields[25] as String
      ..Sleight_of_Hand = fields[26] as String
      ..Stealth = fields[27] as String
      ..Survaival = fields[43] as String
      ..ProfBonus = fields[28] as int
      ..lvl = fields[29] as int
      ..exp = fields[30] as int
      ..PassiveInsight = fields[31] as int?
      ..InitiativeBonus = fields[32] as int?
      ..armor = fields[33] as int?
      ..tools = (fields[34] as List).cast<String>()
      ..langs = (fields[35] as List).cast<String>()
      ..health = fields[36] as String
      ..usearmor = (fields[37] as List).cast<String>()
      ..useweapon = (fields[38] as List).cast<String>()
      ..copperMoney = fields[39] as int
      ..size = fields[40] as String
      ..speed = fields[41] as int
      ..PortraitURL = fields[42] as String;
  }

  @override
  void write(BinaryWriter writer, CharacterView obj) {
    writer
      ..writeByte(43)
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
      ..writeByte(43)
      ..write(obj.Survaival)
      ..writeByte(28)
      ..write(obj.ProfBonus)
      ..writeByte(29)
      ..write(obj.lvl)
      ..writeByte(30)
      ..write(obj.exp)
      ..writeByte(31)
      ..write(obj.PassiveInsight)
      ..writeByte(32)
      ..write(obj.InitiativeBonus)
      ..writeByte(33)
      ..write(obj.armor)
      ..writeByte(34)
      ..write(obj.tools)
      ..writeByte(35)
      ..write(obj.langs)
      ..writeByte(36)
      ..write(obj.health)
      ..writeByte(37)
      ..write(obj.usearmor)
      ..writeByte(38)
      ..write(obj.useweapon)
      ..writeByte(39)
      ..write(obj.copperMoney)
      ..writeByte(40)
      ..write(obj.size)
      ..writeByte(41)
      ..write(obj.speed)
      ..writeByte(42)
      ..write(obj.PortraitURL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterViewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
