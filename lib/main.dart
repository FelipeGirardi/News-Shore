import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/screens/screen_navigator.dart';
import '/screens/news_detail_screen.dart';
import '/screens/bookmarks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData lightThemeData = ThemeData(
      fontFamily: 'Objectivity',
      primaryTextTheme: const TextTheme().apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 21, 45, 121),
        secondary: Color.fromARGB(255, 255, 245, 238),
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
        secondary: Color.fromARGB(255, 51, 49, 47),
      ),
      appBarTheme:
          const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      primaryIconTheme: const IconThemeData(color: Colors.white),
    );
    return ChangeNotifierProvider<NewsProvider>(
        create: (ctx) => NewsProvider(),
        child: MaterialApp(
          title: 'News Shore',
          theme: lightThemeData,
          darkTheme: darkThemeData,
          home: const ScreenNavigator(),
          routes: {
            NewsDetailScreen.routeName: (ctx) => const NewsDetailScreen(),
            BookmarksScreen.routeName: (ctx) => const BookmarksScreen(),
          },
        ));
  }
}
