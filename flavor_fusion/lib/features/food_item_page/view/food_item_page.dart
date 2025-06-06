import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flavor_fusion/features/food_item_page/widgets/energy_value_widget.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:flavor_fusion/features/food_home_page/widgets/widgets.dart';
import 'package:flavor_fusion/features/food_item_page/bloc/dishes_item_bloc.dart';
import 'package:flavor_fusion/features/food_item_page/widgets.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../../repositories/dish_favorites_repository/dish_favorites_repository.dart';

class FoodItemPage extends StatefulWidget {
  const FoodItemPage({super.key});

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  late dynamic arguments;
  late Map args;
  final _dishBloc = DishBloc(GetIt.I<DishItemRepository>());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)?.settings.arguments;
      args = arguments as Map;
      _dishBloc.add(LoadDish(
          args["recipeLink"], args["rate"], args["time"], args["date"]));
    });
  }

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    late DishItemModel dish;
    late String urlImage = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Блюдо"),
        actions: [
          InkWell(
              onTap: () async {
                if (urlImage != "") {
                  final response = await http.get(Uri.parse(urlImage));
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/image.png';
                  File(path).writeAsBytesSync(bytes);
                  await Share.shareXFiles([XFile(path)],
                      text:
                          "https://flavorfusion-9ea2d.web.app/search?query=${args["name"].toString().replaceAll("'", "").replaceAll('"', "").replaceAll(' ', '+')}+[only]");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Что-то пошло не так'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Padding(
                  padding: EdgeInsets.all(15), child: Icon(Icons.share_sharp))),
          InkWell(
              onTap: () async {
                if (urlImage != "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Идёт скачивание....'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Box box = GetIt.I<Box<DishDownloadModel>>();
                  String downloadImage = await saveImage(dish.imageUrl);
                  final cookingSteps = dish.cookingSteps;
                  for (var i in cookingSteps) {
                    i.imageUrl = await saveImage(i.imageUrl);
                  }
                  final downloadDish = DishDownloadModel(
                      name: dish.name,
                      bigDescription: dish.bigDescription,
                      date: dish.date,
                      image: downloadImage,
                      cookingTime: dish.cookingTime,
                      rating: dish.rating,
                      structureRecipe: dish.structureRecipe,
                      cookingSteps: dish.cookingSteps,
                      energyValueModel: dish.energyValueModel);
                  if (!await DishFavoritesRepository()
                      .isDishInDownloads(downloadDish)) {
                    await box.add(downloadDish);
                  } else {
                    for (var key in box.keys) {
                      var dish = box.get(key);
                      if (dish!.name == downloadDish.name) {
                        await box.delete(key); // Удаляем элемент по ключу
                        break; // Завершаем цикл после удаления
                      }
                    }
                  }
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Что-то пошло не так'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Padding(
                  padding: EdgeInsets.all(15), child: Icon(Icons.save_alt)))
        ],
      ),
      body: BlocBuilder<DishBloc, DishState>(
        builder: (context, state) {
          if (state is DishLoaded) {
            final rate =
                state.dish[0].rating.replaceAll('\n', '').replaceAll(" ", "");
            urlImage = state.dish[0].imageUrl;
            dish = state.dish[0];
            return ListView(children: [
              Column(children: [
                StackImageWidget(
                  width: screenWidth,
                  height: screenHeight,
                  dish: state.dish,
                  args: args,
                ),
                PaddingAlignText(
                    weight: FontWeight.w600,
                    fontSize: screenWidth * .042,
                    text: state.dish[0].name,
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
                    text: state.dish[0].bigDescription,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: screenWidth * .05,
                        top: 8,
                        right: 20,
                        bottom: 25)),
                if (state.dish[0].energyValueModel.calories != "none")
                  EnergyValueWidget(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      energyValueModel: state.dish[0].energyValueModel),
                PaddingAlignText(
                    weight: FontWeight.w600,
                    fontSize: screenWidth * .05,
                    text: "Состав / Ингредиенты:",
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: screenWidth * .05)),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(
                        state.dish[0].structureRecipe.length, (index) {
                      final ingredient = state.dish[0].structureRecipe[index];
                      final nameIngredient = (ingredient.nameIngredient)
                          .replaceAll('\n', '')
                          .trim();
                      final countIngredient = ingredient.countIngredient
                          .replaceAll('\n', '')
                          .trim();
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
                          indicatorBackgroundColor:
                              Color.fromARGB(255, 196, 196, 196)),
                    ),
                  ),
                  items:
                      List.generate(state.dish[0].cookingSteps.length, (index) {
                    final cookingStep =
                        state.dish[0].cookingSteps[index].imageUrl;
                    final stepDescription =
                        state.dish[0].cookingSteps[index].stepDescription;

                    return CarouselItem(
                        width: screenWidth,
                        height: screenHeight,
                        stepDescription: stepDescription,
                        cookingStep: cookingStep);
                  }),
                ),
              ])
            ]);
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        },
        bloc: _dishBloc,
      ),
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
