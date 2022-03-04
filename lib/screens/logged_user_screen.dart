import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/providers/news_provider.dart';
import '/widgets/loading_widget.dart';
import '/models/news_enums.dart';

class LoggedUserScreen extends StatelessWidget {
  const LoggedUserScreen({Key? key}) : super(key: key);

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext contx,
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
                        getLangNameFromCode(prefs.getString('language')!, ctx);
                    final country = getCountryNameFromCode(
                        prefs.getString('country')!, ctx);
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 8.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: SizedBox(
                              width: deviceSize.width * 0.75,
                              child: Align(
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.account_circle,
                                          size: 36,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          user?.email ??
                                              AppLocalizations.of(context)!
                                                  .email,
                                          maxLines: 2,
                                          presetFontSizes: [18, 16, 14],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                        Flexible(
                                          child: AutoSizeText(
                                            AppLocalizations.of(context)!
                                                    .totalBookmarks +
                                                provider
                                                    .bookmarkedNewsList.length
                                                    .toString(),
                                            maxLines: 1,
                                            presetFontSizes: [14, 13, 12],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Divider(thickness: 2),
                                    ),
                                    AutoSizeText(
                                      AppLocalizations.of(context)!
                                              .currentLanguage +
                                          lang,
                                      maxLines: 2,
                                      presetFontSizes: [14, 13, 12],
                                    ),
                                    const SizedBox(height: 30),
                                    AutoSizeText(
                                      AppLocalizations.of(context)!
                                              .currentCountry +
                                          country,
                                      maxLines: 2,
                                      presetFontSizes: [14, 13, 12],
                                    ),
                                    const SizedBox(height: 50),
                                    SizedBox(
                                      width: deviceSize.width * 0.5,
                                      height: 40,
                                      child: ElevatedButton(
                                          onPressed: _logout,
                                          child: AutoSizeText(
                                            AppLocalizations.of(context)!
                                                .logout,
                                            presetFontSizes: const [16],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                            )));
                  }
              }
              return const LoadingWidget();
            }));
  }
}
