
import 'package:flavor_fusion/features/food_home_page/bloc/dishes_list_bloc.dart';
import 'package:flavor_fusion/features/food_home_page/widgets/Tiles/category_item_banner.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fusion/features/food_home_page/widgets/widgets.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  final _dishesListBloc = DishesListBloc(GetIt.I<DishesListRepository>());
  @override
  void initState() {
    super.initState();

    _dishesListBloc.add(LoadDishesPopularList());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    // final Themes=Theme.of(context);

    Widget scrollWidget;
    if (screenHeight > 825) {
      scrollWidget = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryItemBanner(
                    height: screenHeight * .35,
                    width: screenHeight * .34 * .45,
                    name: "Горячие блюда",
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/2770/2770067.png",
                    leftMargin: 17,
                    rightMargin: 10)
                .build(context),
            CategoryItemBanner(
                    height: screenHeight * .35,
                    width: screenHeight * .34 * .45,
                    name: "Соусы",
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/7951/7951528.png",
                    leftMargin: 17,
                    rightMargin: 10)
                .build(context),
            CategoryItemBanner(
                    height: screenHeight * .35,
                    width: screenHeight * .34 * .45,
                    name: "Заготовки",
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/7371/7371501.png",
                    leftMargin: 17,
                    rightMargin: 10)
                .build(context),
          ],
        ),
      );
    } else {
      scrollWidget = const SizedBox();
    }

    return RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.red,
        onRefresh: () async {
          _dishesListBloc.add(LoadDishesPopularList());
        },
        child: Container(
          child: BlocBuilder<DishesListBloc, DishesListState>(
            builder: (context, state) {
              if (state is DishesListLoaded) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SearchWidget(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 15),
                              borderRadius: 8),
                          PaddingAlignText(
                            text: "Категории",
                            fontSize: screenHeight < 635 ? 20 : 26,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 10, left: 15),
                            weight: FontWeight.w600,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                CategoryItemTile(
                                        height: screenHeight * .33,
                                        width: screenHeight * .34 * .5,
                                        name: "Салаты",
                                        imageUrl:
                                            "https://cdn-icons-png.flaticon.com/512/1205/1205083.png",
                                        leftMargin: 17,
                                        rightMargin: 10)
                                    .build(context),
                                CategoryItemTile(
                                        height: screenHeight * .33,
                                        width: screenHeight * .34 * .5,
                                        name: "Супы",
                                        imageUrl:
                                            "https://cdn-icons-png.flaticon.com/512/11352/11352981.png",
                                        leftMargin: 10,
                                        rightMargin: 10)
                                    .build(context),
                                CategoryItemTile(
                                        height: screenHeight * .33,
                                        width: screenHeight * .34 * .5,
                                        name: "Закуски",
                                        imageUrl:
                                            "https://cdn-icons-png.flaticon.com/512/1051/1051948.png",
                                        leftMargin: 10,
                                        rightMargin: 10)
                                    .build(context),
                                CategoryItemTile(
                                        height: screenHeight * .33,
                                        width: screenHeight * .34 * .5,
                                        name: "Десерты",
                                        imageUrl:
                                            "https://cdn-icons-png.flaticon.com/512/2770/2770077.png",
                                        leftMargin: 10,
                                        rightMargin: 10)
                                    .build(context),
                                CategoryItemTile(
                                        height: screenHeight * .33,
                                        width: screenHeight * .34 * .5,
                                        name: "Напитки",
                                        imageUrl:
                                            "https://cdn-icons-png.flaticon.com/512/2000/2000092.png",
                                        leftMargin: 10,
                                        rightMargin: 10)
                                    .build(context),
                              ],
                            ),
                          ),
                          scrollWidget
                        ],
                      ),
                      Column(
                        children: [
                          PaddingAlignText(
                            text: "Лучшее",
                            fontSize: screenHeight < 635 ? 20 : 26,
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                                top: screenHeight * .01, bottom: 10, left: 15),
                            weight: FontWeight.w600,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  List.generate(state.dishes.length, (index) {
                                final dish = state.dishes[index];
                                return Container(
                                  child: PopularItemTile(
                                      width: screenHeight * .25,
                                      height: screenHeight * .32,
                                      name: dish.name,
                                      description: dish.description,
                                      recipeLink: dish.recipeLink,
                                      date: dish.date,
                                      rating: dish.rating,
                                      time: dish.cookingTime,
                                      imageUrl: dish.imageUrl,
                                      leftMargin: 17,
                                      rightMargin: 10),
                                );
                              }),
                            ),
                          )
                        ],
                      )
                    ]);
              }
              if (state is DishesListError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Something went wrong",
                      ),
                      const Text(
                        "Please try again later",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          child: const Text(
                            "Try again",
                          ),
                          onPressed: () {
                            _dishesListBloc.add(LoadDishesPopularList());
                          })
                    ],
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            },
            bloc: _dishesListBloc,
          ),
        ));
  }
}
