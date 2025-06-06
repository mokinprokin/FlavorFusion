import 'package:hive_flutter/adapters.dart';
part 'dish_structure.g.dart';
@HiveType(typeId: 4)
class DishStructure {
  @HiveField(0)
  final String nameIngredient;
  @HiveField(1)
  final String countIngredient;
  DishStructure({required this.nameIngredient, required this.countIngredient});
}
