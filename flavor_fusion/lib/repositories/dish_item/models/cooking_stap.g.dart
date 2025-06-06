// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooking_stap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CookingStapAdapter extends TypeAdapter<CookingStap> {
  @override
  final int typeId = 5;

  @override
  CookingStap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CookingStap(
      imageUrl: fields[0] as String,
      stepDescription: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CookingStap obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.stepDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookingStapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
