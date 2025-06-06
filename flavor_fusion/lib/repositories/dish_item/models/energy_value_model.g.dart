// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_value_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnergyValueModelAdapter extends TypeAdapter<EnergyValueModel> {
  @override
  final int typeId = 6;

  @override
  EnergyValueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnergyValueModel(
      calories: fields[0] as String,
      protein: fields[1] as String,
      fat: fields[2] as String,
      carbs: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EnergyValueModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.carbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyValueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
