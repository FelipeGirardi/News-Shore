import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/news_enums.dart';
import '/providers/news_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _getLocalizedCategory(NewsCategory category) {
    switch (category) {
      case NewsCategory.business:
        return AppLocalizations.of(context)!.business;
      case NewsCategory.entertainment:
        return AppLocalizations.of(context)!.entertainment;
      case NewsCategory.health:
        return AppLocalizations.of(context)!.health;
      case NewsCategory.science:
        return AppLocalizations.of(context)!.science;
      case NewsCategory.sports:
        return AppLocalizations.of(context)!.sports;
      case NewsCategory.technology:
        return AppLocalizations.of(context)!.technology;
      default:
        return AppLocalizations.of(context)!.business;
    }
  }

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
          ListTile(
            title: AutoSizeText(
              AppLocalizations.of(context)!.filter,
              presetFontSizes: const [20, 18, 16],
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ...NewsCategory.values.map((NewsCategory category) {
            final categoryString = _getLocalizedCategory(category);
            return CheckboxListTile(
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              title: Text(categoryString),
              value: newsProvider.selectedFilter == category.name,
              onChanged: (bool? newValue) {
                _setCategoryState(category.name, newValue!);
              },
              activeColor: Theme.of(context).colorScheme.primary,
              checkColor: Colors.white,
            );
          }).toList(),
        ],
      ),
    );
  }
}
