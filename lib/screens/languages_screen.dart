import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_enums.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final languagesList = NewsLanguage.values;
  final ScrollController _firstController = ScrollController();
  final ScrollController _secondController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) =>
            Consumer<NewsProvider>(
                builder: (ctx, provider, child) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    default:
                      if (!snapshot.hasError && snapshot.data != null) {
                        final SharedPreferences prefs = snapshot.data!;
                        provider.currentLang = prefs.getString('language');
                        provider.currentCountry = prefs.getString('country');
                        int langIndex =
                            languageIndex(provider.currentLang ?? 'en');
                        return Scaffold(
                          body: Column(
                            children: [
                              child ?? const SizedBox(height: 0),
                              Expanded(
                                child: Row(
                                  children: [
                                    LanguagesListWidget(
                                        firstController: _firstController,
                                        languagesList: languagesList,
                                        prefs: prefs,
                                        provider: provider),
                                    VerticalDivider(
                                      width: 1,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    CountriesListWidget(
                                        secondController: _secondController,
                                        languagesList: languagesList,
                                        langIndex: langIndex,
                                        prefs: prefs,
                                        provider: provider),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                  }
                },
                child: LanguageHeader(deviceSize: deviceSize)));
  }
}

class LanguageHeader extends StatelessWidget {
  const LanguageHeader({Key? key, required this.deviceSize}) : super(key: key);
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 60,
            width: deviceSize.width,
            child: Center(
                child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListTile(
                        title: Center(
                      child: Text('Language',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface)),
                    )),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: SizedBox(
                    child: ListTile(
                        title: Center(
                      child: Text('Country',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface)),
                    )),
                  ),
                ),
              ],
            ))),
        Divider(
          //thickness: 2,
          height: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}

class LanguagesListWidget extends StatelessWidget {
  const LanguagesListWidget({
    Key? key,
    required ScrollController firstController,
    required this.languagesList,
    required this.prefs,
    required this.provider,
  })  : _firstController = firstController,
        super(key: key);

  final ScrollController _firstController;
  final List<NewsLanguage> languagesList;
  final SharedPreferences prefs;
  final NewsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: _firstController,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: languagesList.length,
          itemBuilder: (BuildContext context, int index) {
            final lang = languagesList[index];
            return ListTile(
                horizontalTitleGap: 5,
                leading: SvgPicture.asset(
                  lang.languageIcon,
                  width: 25,
                  height: 25,
                ),
                trailing: lang.languageCode == provider.currentLang
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).colorScheme.background,
                      )
                    : null,
                title: Text(languagesList[index].name),
                tileColor: lang.languageCode == provider.currentLang
                    ? Theme.of(context).colorScheme.primary
                    : null,
                textColor: lang.languageCode == provider.currentLang
                    ? Theme.of(context).colorScheme.background
                    : null,
                onTap: () => provider.setLanguagePref(
                    prefs, languagesList[index].languageCode));
          }),
    );
  }
}

class CountriesListWidget extends StatelessWidget {
  const CountriesListWidget({
    Key? key,
    required ScrollController secondController,
    required this.languagesList,
    required this.langIndex,
    required this.prefs,
    required this.provider,
  })  : _secondController = secondController,
        super(key: key);

  final ScrollController _secondController;
  final List<NewsLanguage> languagesList;
  final int langIndex;
  final SharedPreferences prefs;
  final NewsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
            controller: _secondController,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: languagesList[langIndex].countryLanguage.length,
            itemBuilder: (BuildContext context, int index) {
              final country = languagesList[langIndex].countryLanguage[index];
              return ListTile(
                  horizontalTitleGap: 5,
                  leading: SvgPicture.asset(
                    country.countryIcon,
                    width: 25,
                    height: 25,
                  ),
                  title: Text(country.fullCountryName),
                  tileColor: country.countryCode == provider.currentCountry
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  textColor: country.countryCode == provider.currentCountry
                      ? Theme.of(context).colorScheme.background
                      : null,
                  onTap: () =>
                      provider.setCountryPref(prefs, country.countryCode));
            }),
      ),
    );
  }
}
