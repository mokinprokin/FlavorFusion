import 'package:hive_flutter/adapters.dart';
part 'energy_value_model.g.dart';
@HiveType(typeId: 6)
class EnergyValueModel {
  @HiveField(0)
  String calories;
  @HiveField(1)
  String protein;
  @HiveField(2)
  String fat;
  @HiveField(3)
  String carbs;
  @HiveField(4)
  EnergyValueModel(
      {required this.calories,
      required this.protein,
      required this.fat,
      required this.carbs});
}
