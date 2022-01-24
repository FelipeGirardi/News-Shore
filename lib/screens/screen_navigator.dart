import 'package:flutter/material.dart';
import '/screens/mock_main_feed_screen.dart';
import 'package:provider/provider.dart';

import '/widgets/custom_app_bar.dart';
import '/widgets/app_drawer.dart';
import '/providers/news_provider.dart';
import 'package:newsshore/screens/auth_screen.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int _selectedOption = 0;
  static const List<Widget> _bottomNavBarOptions = <Widget>[
    MockMainFeedScreen(),
    Text(
      'Sign up or login to bookmark your favorite news and to customize your news feed!',
    ),
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
            icon: Icon(Icons.settings),
            label: 'Settings',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'News Shore',
        showSearchIcon: true,
      ),
      drawer: const AppDrawer(),
      onDrawerChanged: (isOpen) {
        if (!isOpen) {
          Provider.of<NewsProvider>(context, listen: false)
              .didCloseFiltersDrawer();
        }
      },
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
          alignment: Alignment.center,
          index: _selectedOption,
          children: _bottomNavBarOptions),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
