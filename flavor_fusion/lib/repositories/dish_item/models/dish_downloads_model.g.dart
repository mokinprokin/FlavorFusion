// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_downloads_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishDownloadModelAdapter extends TypeAdapter<DishDownloadModel> {
  @override
  final int typeId = 3;

  @override
  DishDownloadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DishDownloadModel(
      name: fields[0] as String,
      bigDescription: fields[1] as String,
      date: fields[2] as String,
      image: fields[3] as String,
      cookingTime: fields[4] as String,
      rating: fields[5] as String,
      structureRecipe: (fields[6] as List).cast<DishStructure>(),
      cookingSteps: (fields[7] as List).cast<CookingStap>(),
      energyValueModel: fields[8] as EnergyValueModel,
    );
  }

  @override
  void write(BinaryWriter writer, DishDownloadModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.bigDescription)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.cookingTime)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.structureRecipe)
      ..writeByte(7)
      ..write(obj.cookingSteps)
      ..writeByte(8)
      ..write(obj.energyValueModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishDownloadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
