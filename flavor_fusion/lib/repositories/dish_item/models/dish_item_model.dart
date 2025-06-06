import 'package:flavor_fusion/repositories/dish_item/models/cooking_stap.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_structure.dart';
import 'package:flavor_fusion/repositories/dish_item/models/energy_value_model.dart';
import 'package:hive_flutter/adapters.dart';
part 'dish_item_model.g.dart';

@HiveType(typeId: 2)
class DishItemModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String bigDescription;
  @HiveField(2)
  String date;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String cookingTime;
  @HiveField(5)
  String rating;
  @HiveField(6)
  List<DishStructure> structureRecipe;
  @HiveField(7)
  List<CookingStap> cookingSteps;
  @HiveField(8)
  EnergyValueModel energyValueModel;
  @HiveField(9)
  DishItemModel(
      {required this.name,
      required this.bigDescription,
      required this.date,
      required this.imageUrl,
      required this.cookingTime,
      required this.rating,
      required this.structureRecipe,
      required this.cookingSteps,
      required this.energyValueModel});
}
