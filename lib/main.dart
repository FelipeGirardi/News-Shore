import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

import '/providers/news_provider.dart';
import '/screens/screen_navigator.dart';
import '/screens/news_detail_screen.dart';
import '/screens/bookmarks_screen.dart';
import '/widgets/loading_widget.dart';
import '/providers/auth_provider.dart';
import '/models/news_enums.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<InitializationStatus> _initGoogleMobileAds() async {
    return await MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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
      appBarTheme:
          const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      primaryIconTheme: const IconThemeData(color: Colors.white),
    );

    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const LoadingWidget();
                  default:
                    if (!snapshot.hasError) {
                      if (snapshot.data?.getBool('firstOpen') == null) {
                        final String systemLocale = Platform.localeName;
                        snapshot.data?.setBool('firstOpen', true);
                        snapshot.data?.setString(
                            'language', getLanguageFromLocale(systemLocale));
                        snapshot.data?.setString(
                            'country', getCountryFromLocale(systemLocale));
                      }
                      return FutureBuilder<InitializationStatus>(
                          future: _initGoogleMobileAds(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingWidget();
                            } else {
                              if (snapshot.hasData) {
                                return MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider<NewsProvider>(
                                          create: (ctx) => NewsProvider()),
                                      ChangeNotifierProvider(
                                        create: (ctx) =>
                                            AuthProvider(FirebaseAuth.instance),
                                      ),
                                      StreamProvider(
                                        create: (BuildContext context) {
                                          return context
                                              .read<AuthProvider>()
                                              .authStateChanges;
                                        },
                                        initialData: null,
                                      )
                                    ],
                                    child: MaterialApp(
                                      title: 'News Shore',
                                      theme: lightThemeData,
                                      darkTheme: darkThemeData,
                                      localizationsDelegates: AppLocalizations
                                          .localizationsDelegates,
                                      supportedLocales:
                                          AppLocalizations.supportedLocales,
                                      home: const ScreenNavigator(),
                                      routes: {
                                        NewsDetailScreen.routeName: (ctx) =>
                                            const NewsDetailScreen(),
                                        BookmarksScreen.routeName: (ctx) =>
                                            const BookmarksScreen(),
                                      },
                                    ));
                              }
                            }
                            return const LoadingWidget();
                          });
                    }
                }
                return Container();
              });
        });
  }
}
