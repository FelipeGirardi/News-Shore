import 'package:flutter/material.dart';
import '/screens/main_feed_screen.dart';
import 'package:provider/provider.dart';

import '/widgets/custom_app_bar.dart';
import '/widgets/app_drawer.dart';
import '/providers/news_provider.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int _selectedOption = 0;
  static const List<Widget> _bottomNavBarOptions = <Widget>[
    MainFeedScreen(),
    Text(
      'Sign up or login to bookmark your favorite news!',
    ),
    Text(
      'Index 2: Settings',
    ),
    Text(
      'Index 3: Account',
    ),
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
      appBar: CustomAppBar('News Shore'),
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
