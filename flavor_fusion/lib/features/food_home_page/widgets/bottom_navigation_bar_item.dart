import 'package:flutter/material.dart';

final bottomNavigationItem = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Главная',
  ),
  const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_sharp), label: 'Избранное'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.save_alt_sharp), label: 'Скачанное')
];
