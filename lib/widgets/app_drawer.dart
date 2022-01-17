import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/news_category.dart';
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

    void _setCategoryState(NewsCategory category) {
      newsProvider.filtersSelected.contains(category.name)
          ? setState(() {
              newsProvider.filtersSelected.remove(category.name);
            })
          : newsProvider.filtersSelected.length < 5
              ? setState(() {
                  newsProvider.filtersSelected.add(category.name);
                })
              : null;
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
            return ListTile(
                title: Text(category.name.capitalize()),
                trailing: Icon(
                    newsProvider.filtersSelected.contains(category.name)
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank,
                    color: newsProvider.filtersSelected.contains(category.name)
                        ? Colors.green
                        : Colors.grey),
                onTap: () => _setCategoryState(category));
          }).toList(),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              'Maximum 5 filters',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
