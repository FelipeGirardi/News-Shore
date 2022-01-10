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
            primarySwatch: Colors.cyan,
          ),
          home: ScreenNavigator(),
          routes: {
            NewsDetailScreen.routeName: (ctx) => const NewsDetailScreen(),
          },
        ));
  }
}
