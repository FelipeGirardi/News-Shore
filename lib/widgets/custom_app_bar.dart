import 'package:flutter/material.dart';

import '/helpers/news_search.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool showSearchIcon;

  CustomAppBar({Key? key, required this.title, required this.showSearchIcon})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface),
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      title: Text(
        title,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      automaticallyImplyLeading: true,
      actions: showSearchIcon
          ? [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: NewsSearch());
                },
              ),
            ]
          : [],
    );
  }
}
