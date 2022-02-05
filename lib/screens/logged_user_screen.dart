import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsshore/models/news_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/loading_widget.dart';

class LoggedUserScreen extends StatelessWidget {
  const LoggedUserScreen({Key? key}) : super(key: key);

  void _logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) =>
            Consumer<NewsProvider>(builder: (ctx, provider, child) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const LoadingWidget();
                default:
                  if (!snapshot.hasError && snapshot.data != null) {
                    final SharedPreferences prefs = snapshot.data!;
                    final lang =
                        getLangNameFromCode(prefs.getString('language')!);
                    final country =
                        getCountryNameFromCode(prefs.getString('country')!);
                    return Center(
                      child: Column(
                        children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 8.0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 30),
                                  child: SizedBox(
                                    width: deviceSize.width * 0.75,
                                    child: Align(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.account_circle,
                                                size: 36,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                user?.email ?? 'E-mail',
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.bookmark_border,
                                                size: 24,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text('Total bookmarked news: ' +
                                                  provider
                                                      .bookmarkedNewsList.length
                                                      .toString()),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Divider(thickness: 2),
                                          ),
                                          Text('Current news language: $lang'),
                                          const SizedBox(height: 30),
                                          Text(
                                              'Current news country: $country'),
                                          const SizedBox(height: 50),
                                          ElevatedButton(
                                              onPressed: _logout,
                                              child: const Text('Log out'),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ))),
                          const Spacer(),
                        ],
                      ),
                    );
                  }
              }
              return LoadingWidget();
            }));
  }
}
