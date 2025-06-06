import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_fusion/firebase_options.dart';
import 'package:flavor_fusion/food_app.dart';
import 'package:flavor_fusion/repositories/dish_item/models/cooking_stap.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_structure.dart';
import 'package:flavor_fusion/repositories/dish_item/models/energy_value_model.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug("Talker started...");
  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
  Dio().interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printResponseData: false,
          ),
        ),
      );
  GetIt.I.registerLazySingleton(() => DishesListRepository());
  GetIt.I.registerLazySingleton(() => DishItemRepository());
  await Hive.initFlutter();
  Hive.registerAdapter(DishModelAdapter());
  Hive.registerAdapter(DishDownloadModelAdapter());
  Hive.registerAdapter(DishStructureAdapter());
  Hive.registerAdapter(CookingStapAdapter());
  Hive.registerAdapter(EnergyValueModelAdapter());
  final dishFavoritesBox = await Hive.openBox<DishModel>('dish_favorites_box');
  final dishDownloadsBox =
      await Hive.openBox<DishDownloadModel>('dish_download_box');
  GetIt.I.registerSingleton<Box<DishModel>>(dishFavoritesBox);
  GetIt.I.registerSingleton<Box<DishDownloadModel>>(dishDownloadsBox);
  // await UniServices.init();
  runApp(const FoodApp());
}
