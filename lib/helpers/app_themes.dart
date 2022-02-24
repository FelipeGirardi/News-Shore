import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightThemeData = ThemeData(
  fontFamily: 'Objectivity',
  primaryTextTheme: const TextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 21, 45, 121),
    primaryContainer: Color.fromARGB(255, 182, 237, 232),
    secondary: Color.fromARGB(255, 255, 245, 238),
    secondaryContainer: Color.fromARGB(255, 51, 49, 47),
  ),
  appBarTheme:
      const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  primaryIconTheme: const IconThemeData(color: Colors.black),
);

final ThemeData darkThemeData = ThemeData(
  fontFamily: 'Objectivity',
  primaryTextTheme: const TextTheme()
      .apply(bodyColor: Colors.white, displayColor: Colors.white),
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 182, 237, 232),
    primaryContainer: Color.fromARGB(255, 21, 45, 121),
    secondary: Color.fromARGB(255, 51, 49, 47),
    secondaryContainer: Color.fromARGB(255, 255, 245, 238),
  ),
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  primaryIconTheme: const IconThemeData(color: Colors.white),
);
