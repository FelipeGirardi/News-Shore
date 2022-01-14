import 'package:flutter/material.dart';
import '/screens/main_feed_screen.dart';

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
    MainFeedScreen(),
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
      body: Center(child: _bottomNavBarOptions.elementAt(_selectedOption)),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black45,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.black45,
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
          selectedItemColor: const Color.fromARGB(255, 21, 45, 121),
          onTap: _onOptionTapped,
        ),
      ),
    );
  }
}
