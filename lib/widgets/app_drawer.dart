import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri(host: url))) {
      await launchUrl(Uri(host: url));
    } else {
      throw "Could not launch $url";
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
          const Divider(
            thickness: 2,
          ),
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
              checkColor: Theme.of(context).colorScheme.onPrimary,
            );
          }).toList(),
          const Divider(
            thickness: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.appBy,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Felipe Girardi - ',
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  InkWell(
                    child: Text(
                      'GitHub',
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue),
                    ),
                    onTap: () => _launchUrl('https://github.com/FelipeGirardi'),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'felipegirardifg@gmail.com',
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 15),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.newsBy,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 25),
              InkWell(
                child: Text(
                  'newsdata.io',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
                onTap: () => _launchUrl('https://newsdata.io'),
              ),
              const SizedBox(height: 15),
              Text(
                'contact@newsdata.io',
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 25),
              InkWell(
                child: Text(
                  'newsapi.org',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
                onTap: () => _launchUrl('https://newsapi.org'),
              ),
              const SizedBox(height: 15),
              Text(
                'contact@newsdata.io',
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
