import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: deviceSize.width,
          height: 100,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            'Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Theme.of(context).colorScheme.background),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            shrinkWrap: true,
            children: const [
              ListTile(
                  leading: Icon(
                    Icons.bookmark,
                    size: 18,
                  ),
                  title: Text('Bookmarked news')),
              Divider(
                thickness: 2,
              ),
              ListTile(
                  leading: Icon(
                    Icons.language,
                    size: 18,
                  ),
                  title: Text('Languages')),
            ],
          ),
        )
      ],
    );
  }
}
