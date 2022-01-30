import 'package:flutter/material.dart';

import '/models/news_enums.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    const languagesList = NewsLanguage.values;
    final ScrollController _firstController = ScrollController();
    final ScrollController _secondController = ScrollController();
    return Scaffold(
      body: Column(
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
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
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
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _firstController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 10),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: languagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            horizontalTitleGap: 5,
                            leading: SvgPicture.asset(
                              languagesList[index].languageIcon,
                              width: 25,
                              height: 25,
                            ),
                            trailing: index == 0
                                ? Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  )
                                : null,
                            title: Text(languagesList[index].name),
                            tileColor: index == 0
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            textColor: index == 0
                                ? Theme.of(context).colorScheme.background
                                : null,
                            onTap: () {});
                      }),
                ),
                VerticalDivider(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        controller: _secondController,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemCount: languagesList[0].countryLanguage.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              horizontalTitleGap: 5,
                              leading:
                                  languagesList[0].countryLanguage[index] ==
                                          NewsCountry.All
                                      ? Icon(
                                          Icons.language,
                                          size: 25,
                                          color: index == 0
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .background
                                              : null,
                                        )
                                      : SvgPicture.asset(
                                          languagesList[0]
                                              .countryLanguage[index]
                                              .countryIcon,
                                          width: 25,
                                          height: 25,
                                        ),
                              title: Text(languagesList[0]
                                  .countryLanguage[index]
                                  .fullCountryName),
                              tileColor: index == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              textColor: index == 0
                                  ? Theme.of(context).colorScheme.background
                                  : null,
                              onTap: () {});
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
