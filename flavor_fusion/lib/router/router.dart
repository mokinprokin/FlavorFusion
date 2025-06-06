import 'package:flavor_fusion/features/downloads_page/view/downloads_item_page.dart';
import 'package:flavor_fusion/features/food_home_page/view/food_home_page.dart';
import 'package:flavor_fusion/features/food_item_page/food_item.dart';

import '../features/favorites_page/favorites.dart';
import '../features/food_home_page/food_home.dart';
import '../features/search_page/search.dart';

final routes = {
  '/': (_) => const NavigationHomePage(),
  '/home': (_) => const FoodHomePage(),
  '/favorites': (_) => const FavoritesPage(),
  '/search': (_) => const SearchPage(),
  '/dish': (_) => const FoodItemPage(),
  '/dishDownload': (_) => const DownloadsItemPage()
};
