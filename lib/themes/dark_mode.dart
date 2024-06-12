import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
        background: Colors.brown.shade200,
        primary: Colors.white,
        brightness: Brightness.dark));

final lightMode = ThemeData(
    colorScheme: ColorScheme.light(
        background: Colors.brown.shade100,
        primary: Colors.brown.withOpacity(0.5),
        brightness: Brightness.light));
