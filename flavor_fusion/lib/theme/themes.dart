import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 0, 0),
    titleTextStyle: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600,fontFamily: 'main_font'),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white)

  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(foregroundColor: Colors.white,backgroundColor: Colors.white),
  colorScheme:  ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 19, 19, 19),fontWeight: FontWeight.w600,fontSize: 40,fontFamily: 'main_font'),
    bodyMedium: TextStyle(color: Color.fromARGB(160, 19, 19, 19),fontWeight: FontWeight.w400,fontSize: 23,fontFamily: 'main_font')
  ),
  
  useMaterial3: true,
);