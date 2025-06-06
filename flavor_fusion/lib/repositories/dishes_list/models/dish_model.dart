import 'package:hive_flutter/hive_flutter.dart';
part 'dish_model.g.dart';
@HiveType(typeId: 1)
class DishModel{
  @HiveField(0)
  String name;
  @HiveField(1)  
  String imageUrl;
  @HiveField(2)
  String description;
  @HiveField(3)
  String rating;
  @HiveField(4)
  String cookingTime;
  @HiveField(5)
  String recipeLink;
  @HiveField(6)
  String date;
  DishModel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.cookingTime,
    required this.recipeLink,
    required this.date     
  });
}