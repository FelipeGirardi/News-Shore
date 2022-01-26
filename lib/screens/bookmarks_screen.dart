import 'package:flutter/material.dart';
import 'package:newsshore/widgets/custom_app_bar.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);
  static const routeName = '/bookmarks-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bookmarks',
        showSearchIcon: false,
      ),
      body: Text('Hi'),
    );
  }
}
