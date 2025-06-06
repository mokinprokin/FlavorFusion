import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flavor_fusion/repositories/dishes_list/models/dish_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DishFavoritesRepository {
  Future<bool> isDishInFavorites(DishModel dish) async {
    var box = await Hive.openBox<DishModel>('dish_favorites_box');

    return box.values.any((item) => item.name == dish.name);
  }

  Future<bool> isDishInDownloads(DishDownloadModel dish) async {
    var box = await Hive.openBox<DishDownloadModel>('dish_download_box');

    return box.values.any((item) => item.name == dish.name);
  }
}
