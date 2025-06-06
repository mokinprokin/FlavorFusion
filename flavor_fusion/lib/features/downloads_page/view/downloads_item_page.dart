import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flavor_fusion/features/downloads_page/widgets/carousel_download_item.dart';
import 'package:flavor_fusion/features/downloads_page/widgets/stack_download_image.dart';
import 'package:flavor_fusion/features/food_item_page/widgets/energy_value_widget.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flavor_fusion/features/food_home_page/widgets/widgets.dart';
import 'package:flavor_fusion/features/food_item_page/bloc/dishes_item_bloc.dart';
import 'package:flavor_fusion/features/food_item_page/widgets.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get_it/get_it.dart';

class DownloadsItemPage extends StatefulWidget {
  const DownloadsItemPage({super.key});

  @override
  State<DownloadsItemPage> createState() => _DownloadsItemPageState();
}

class _DownloadsItemPageState extends State<DownloadsItemPage> {
  late dynamic arguments;
  late Map args;
  late DishDownloadModel dish;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments;
      args = arguments as Map;
      dish = args["dish"];
      setState(() {});
    });
  }

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    late String urlImage = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Блюдо"),
      ),
      body: Builder(builder: (context) {
        final rate = dish.rating.replaceAll('\n', '').replaceAll(" ", "");
        return ListView(children: [
          Column(children: [
            StackDownloadWidget(
              width: screenWidth,
              height: screenHeight,
              dish: dish,
              args: args,
            ),
            PaddingAlignText(
                weight: FontWeight.w600,
                fontSize: screenWidth * .042,
                text: dish.name,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: screenWidth * .05, top: 15, bottom: 2.5)),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .05),
              child: Row(
                children: [
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
                          width: screenWidth * .045,
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text(rate,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: screenWidth * .045,
                                fontWeight: FontWeight.w700)),
                      )),
                ],
              ),
            ),
            PaddingAlignText(
                weight: FontWeight.w400,
                fontSize: screenWidth * .04,
                text: dish.bigDescription,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: screenWidth * .05, top: 8, right: 20, bottom: 25)),
            if (dish.energyValueModel.calories != "none")
              EnergyValueWidget(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  energyValueModel: dish.energyValueModel),
            PaddingAlignText(
                weight: FontWeight.w600,
                fontSize: screenWidth * .05,
                text: "Состав / Ингредиенты:",
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: screenWidth * .05)),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(dish.structureRecipe.length, (index) {
                  final ingredient = dish.structureRecipe[index];
                  final nameIngredient =
                      (ingredient.nameIngredient).replaceAll('\n', '').trim();
                  final countIngredient =
                      ingredient.countIngredient.replaceAll('\n', '').trim();
                  return SizedBox(
                    width: screenWidth * .95,
                    child: Card(
                      shadowColor: const Color.fromARGB(164, 204, 204, 204),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaxSymbolsText(
                              maxCharacters: 27,
                              weight: FontWeight.w600,
                              fontSize: screenWidth * .04,
                              text: nameIngredient,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(
                                  left: 14, top: 8, bottom: 4)),
                          PaddingAlignText(
                              weight: FontWeight.w600,
                              fontSize: screenWidth * .04,
                              text: countIngredient,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(
                                  right: 14, top: 8, bottom: 4)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            FlutterCarousel(
              options: CarouselOptions(
                height: screenHeight * .73,
                enableInfiniteScroll: true,
                showIndicator: true,
                controller: carouselController,
                slideIndicator: const CircularSlideIndicator(
                    slideIndicatorOptions: SlideIndicatorOptions(
                      currentIndicatorColor: Colors.red,
                      indicatorBackgroundColor:  Color.fromARGB(255, 196, 196, 196)),
                    ),
              ),
              items: List.generate(dish.cookingSteps.length, (index) {
                final cookingStep = dish.cookingSteps[index].imageUrl;
                final stepDescription =
                    dish.cookingSteps[index].stepDescription;

                return CarouselDownloadItem(
                    width: screenWidth,
                    height: screenHeight,
                    stepDescription: stepDescription,
                    cookingStep: cookingStep);
              }),
            ),
          ])
        ]);
      }),
    );
  }
}

Future<String> saveImage(String imageUrl) async {
  // Скачиваем изображение
  try {
    // Скачиваем изображение
    final response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));

    // Преобразуем данные в Uint8List
    Uint8List bytes = response.data;

    // Кодируем в Base64 и возвращаем строку
    return base64Encode(bytes);
  } catch (e) {
    print('Ошибка при получении изображения: $e');
    return '';
  }
}
