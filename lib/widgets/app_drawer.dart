import 'package:flutter/material.dart';

import '/widgets/custom_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 245, 238),
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
