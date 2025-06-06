// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_structure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishStructureAdapter extends TypeAdapter<DishStructure> {
  @override
  final int typeId = 4;

  @override
  DishStructure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DishStructure(
      nameIngredient: fields[0] as String,
      countIngredient: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DishStructure obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameIngredient)
      ..writeByte(1)
      ..write(obj.countIngredient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishStructureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
