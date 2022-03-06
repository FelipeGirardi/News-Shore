import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/widgets/custom_app_bar.dart';
import '/widgets/app_drawer.dart';
import '/providers/news_provider.dart';
import '/screens/mock_main_feed_screen.dart';
import '/screens/bookmarks_screen.dart';
import '/screens/languages_screen.dart';
import '/screens/auth_screen.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int _selectedOption = 0;
  // ignore: prefer_final_fields
  List<Widget> _bottomNavBarOptions = <Widget>[
    const MockMainFeedScreen(),
    const BookmarksScreen(),
    const LanguagesScreen(),
    const AuthScreen()
  ];

  void _onOptionTapped(int index) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    setState(() {
      if (index == 0 && provider.newsList.isEmpty) {
        provider.fetchNews();
      }
      _selectedOption = index;
    });
  }

  Widget bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.news,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark),
            label: AppLocalizations.of(context)!.bookmarks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.language),
            label: AppLocalizations.of(context)!.languages,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.account,
          ),
        ],
        currentIndex: _selectedOption,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onOptionTapped,
      ),
    );
  }

  String getAppBarTitle() {
    switch (_selectedOption) {
      case 0:
        return 'News Shore';
      case 1:
        return AppLocalizations.of(context)!.bookmarks;
      case 2:
        return AppLocalizations.of(context)!.languages;
      case 3:
        return AppLocalizations.of(context)!.account;
      default:
        return 'News Shore';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getAppBarTitle(),
        showSearchIcon: _selectedOption == 0 ? true : false,
      ),
      drawer: _selectedOption == 0 ? const AppDrawer() : null,
      onDrawerChanged: (isOpen) {
        if (!isOpen) {
          Provider.of<NewsProvider>(context, listen: false)
              .didCloseFiltersDrawer();
        }
      },
      backgroundColor: Theme.of(context).colorScheme.background,
      body:
          IndexedStack(index: _selectedOption, children: _bottomNavBarOptions),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
