import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/custom_app_bar.dart';
import '/widgets/app_drawer.dart';
import '/providers/news_provider.dart';
import '/screens/main_feed_screen.dart';
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
  static const List<Widget> _bottomNavBarOptions = <Widget>[
    MainFeedScreen(),
    BookmarksScreen(),
    LanguagesScreen(),
    AuthScreen()
  ];

  void _onOptionTapped(int index) {
    setState(() {
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
        //unselectedItemColor: Theme.of(context).colorScheme.background,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Languages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
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
        return 'Bookmarks';
      case 2:
        return 'Languages';
      case 3:
        return 'Account';
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
      body: IndexedStack(
          //alignment: Alignment.center,
          index: _selectedOption,
          children: _bottomNavBarOptions),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
