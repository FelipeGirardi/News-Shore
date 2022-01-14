import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            ListTile(
              title: const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'All News',
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'World',
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Technology',
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}
