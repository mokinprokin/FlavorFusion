// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishModelAdapter extends TypeAdapter<DishModel> {
  @override
  final int typeId = 1;

  @override
  DishModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DishModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      description: fields[2] as String,
      rating: fields[3] as String,
      cookingTime: fields[4] as String,
      recipeLink: fields[5] as String,
      date: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DishModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.cookingTime)
      ..writeByte(5)
      ..write(obj.recipeLink)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
