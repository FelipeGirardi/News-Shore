import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/screens/screen_navigator.dart';
import '/screens/news_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsProvider>(
        create: (ctx) => NewsProvider(),
        child: MaterialApp(
          title: 'News Shore',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.cyan).copyWith(
              primary: const Color.fromARGB(255, 21, 45, 121),
              secondary: const Color.fromARGB(255, 255, 245, 238),
            ),
          ),
          home: const ScreenNavigator(),
          routes: {
            NewsDetailScreen.routeName: (ctx) => const NewsDetailScreen(),
          },
        ));
  }
}
