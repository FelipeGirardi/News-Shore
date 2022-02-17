import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_enums.dart';
import '/providers/news_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider =
        Provider.of<NewsProvider>(context, listen: false);

    void _setCategoryState(String categoryName, bool newValue) {
      !newValue
          ? setState(() {
              newsProvider.selectedFilter = '';
            })
          : setState(() {
              newsProvider.selectedFilter = categoryName;
            });
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        children: [
          const ListTile(
            title: Text(
              'Filter news by:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ...NewsCategory.values.map((NewsCategory category) {
            return CheckboxListTile(
              title: Text(category.name.capitalize()),
              value: newsProvider.selectedFilter == category.name,
              onChanged: (bool? newValue) {
                _setCategoryState(category.name, newValue!);
              },
              activeColor: Colors.green,
              checkColor: Colors.white,
            );
          }).toList(),
        ],
      ),
    );
  }
}
