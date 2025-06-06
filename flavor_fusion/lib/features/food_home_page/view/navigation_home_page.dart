import 'package:flavor_fusion/features/downloads_page/downloads.dart';
import 'package:flavor_fusion/features/favorites_page/favorites.dart';
import 'package:flavor_fusion/features/food_home_page/view/food_home_page.dart';
import 'package:flavor_fusion/features/food_home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<Widget> pages = const [FoodHomePage(), FavoritesPage(), DownloadsPage()];
  int _selectedIndex = 0;
  String _title = "Главная";
  void _onItemTapped(int index, String title) {
    setState(() {
      _selectedIndex = index;
      _title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationItem,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 253, 36, 47),
        onTap: (index) {
          if (index == 0) {
            _onItemTapped(index, "Главная");
          } else if (index == 1) {
            _onItemTapped(index, "Избранное");
          } else {
            _onItemTapped(index, "Скачанное");
          }
        },
      ),
    );
  }
}
