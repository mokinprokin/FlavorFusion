import 'package:hive_flutter/adapters.dart';
part 'cooking_stap.g.dart';
@HiveType(typeId: 5)
class CookingStap {
  @HiveField(0)
  String imageUrl;
  @HiveField(1)
  String stepDescription;
  CookingStap({required this.imageUrl, required this.stepDescription});
}
