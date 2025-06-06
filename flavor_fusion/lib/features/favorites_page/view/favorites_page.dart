import 'package:flavor_fusion/features/search_page/widgets/result_food_tile.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: FutureBuilder(
        future: Hive.openBox<DishModel>('dish_favorites_box'), // Открываем Box
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var box = Hive.box<DishModel>('dish_favorites_box');

            return ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box<DishModel> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('Избранных блюд нет.'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    DishModel dish = box.getAt(box.length-1-index)!; // Получаем элемент по индексу
                    return ResultFoodTile(width: screenWidth, height: screenHeight, name: dish.name, rating: dish.rating, description: dish.description, date: dish.date, time: dish.cookingTime, imageUrl: dish.imageUrl, recipeLink: dish.recipeLink, leftMargin: 10, rightMargin: 10);
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.red,));
          }
        },
      ),
    );
  }
}