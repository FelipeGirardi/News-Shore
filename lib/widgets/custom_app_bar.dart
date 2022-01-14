import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
