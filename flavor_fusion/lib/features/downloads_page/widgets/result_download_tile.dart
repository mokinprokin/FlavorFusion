import 'dart:convert';
import 'dart:typed_data';

import 'package:flavor_fusion/repositories/dish_favorites_repository/dish_favorites_repository.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ResultDownloadTile extends StatefulWidget {
  final double width;
  final double height;
  final String time;
  final String name;
  final String rating;
  final String description;
  final String date;
  final String imageUrl;
  final DishDownloadModel dish;
  final String recipeLink;
  final double leftMargin;
  final double rightMargin;

  const ResultDownloadTile({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.rating,
    required this.description,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.recipeLink,
    required this.leftMargin,
    required this.rightMargin,
    required this.dish,
  });

  @override
  State<ResultDownloadTile> createState() => _ResultDownloadTileState();
}

class _ResultDownloadTileState extends State<ResultDownloadTile> {
  @override
  Widget build(BuildContext context) {
    final rate = widget.rating.replaceAll('\n', '').replaceAll(" ", "");
    final dating = widget.date.trim().replaceAll('\n', '').split(' ');
    final recordingDate = dating[dating.length - 1];
    return FutureBuilder<bool>(
        future: _inFavorites(DishModel(
          name: widget.name,
          imageUrl: widget.imageUrl,
          description: widget.description,
          rating: widget.rating.replaceAll('\n', '').replaceAll(" ", ""),
          cookingTime: widget.time,
          recipeLink: widget.recipeLink,
          date: widget.date,
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final inFavorites = snapshot.data ?? false;
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/dishDownload", arguments: {
                'dish': widget.dish,
              });
            },
            child: Card(
              color: const Color.fromARGB(255, 253, 253, 253),
              margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: widget.leftMargin,
                  right: widget.rightMargin),
              child: Row(
                children: <Widget>[
                  Stack(children: [
                    Container(
                      width: widget.width * .385,
                      height: widget.width * .3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(widget.imageUrl)),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                            onTap: () async {
                              await deleteDish(rate, context);
                              setState(() {});
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.all(3),
                              child: const Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(45)),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 5),
                                    child: Image.network(
                                      "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
                                      width: widget.width * .04,
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Text(
                                      rate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: widget.width * .035,
                                          fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  )),
                            ],
                          ),
                        ))
                  ]),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 2, right: 20, left: 10),
                          child: Text(
                            widget.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: widget.width * .04,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 10),
                          child: Row(
                            children: [
                              Text(
                                "$recordingDate |",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: const Color.fromARGB(129, 0, 0, 0),
                                  fontSize: widget.width * .03,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50)),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/9736/9736173.png",
                                            width: widget.width * .06,
                                          ),
                                        )),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1.5),
                                          child: Text(
                                            widget.time,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    134, 0, 0, 0),
                                                fontSize: widget.width * .032,
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6, right: 20, left: 10),
                          child: Text(
                            widget.description,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: const Color.fromARGB(111, 0, 0, 0),
                              fontSize: widget.width * .03,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> deleteDish(String rate, BuildContext context) async {
    var box = GetIt.I<Box<DishDownloadModel>>();

    for (var key in box.keys) {
      var dish = box.get(key);
      if (dish!.name == widget.name) {
        await box.delete(key); // Удаляем элемент по ключу
        break; // Завершаем цикл после удаления
      }
    }

    setState(() {});
  }

  Future<bool> _inFavorites(DishModel dish) async {
    return DishFavoritesRepository().isDishInFavorites(dish);
  }
}
