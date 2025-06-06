import 'package:flavor_fusion/features/downloads_page/widgets/result_download_tile.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final box = Hive.box<DishDownloadModel>('dish_download_box');
          await box.clear();
          setState(() {});
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.clear,
          color: Colors.white,
        ), // Цвет FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FutureBuilder(
        future: Hive.openBox<DishDownloadModel>(
            'dish_download_box'), // Открываем Box
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var box = Hive.box<DishDownloadModel>('dish_download_box');

            return ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box<DishDownloadModel> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('Скачанных блюд нет.'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    DishDownloadModel dish = box.getAt(
                        box.length - 1 - index)!; // Получаем элемент по индексу
                    return ResultDownloadTile(
                        width: screenWidth,
                        height: screenHeight,
                        name: dish.name,
                        rating: dish.rating,
                        description: dish.bigDescription,
                        date: dish.date,
                        time: dish.cookingTime,
                        imageUrl: dish.image,
                        dish: dish,
                        recipeLink: "",
                        leftMargin: 10,
                        rightMargin: 10);
                  },
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
        },
      ),
    );
  }
}
