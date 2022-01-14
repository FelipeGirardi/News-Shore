import 'package:flutter/material.dart';
import '/screens/mock_main_feed_screen.dart';

import '/widgets/custom_app_bar.dart';
import '/widgets/app_drawer.dart';

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
      'Index 1: Settings',
    ),
    Text(
      'Index 2: Account',
    ),
  ];

  void _onOptionTapped(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('News Shore'),
      drawer: const AppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(child: _bottomNavBarOptions.elementAt(_selectedOption)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 0.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
        child: BottomNavigationBar(
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
      ),
    );
  }
}
