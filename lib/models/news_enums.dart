// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum NewsCategory {
  business,
  entertainment,
  health,
  science,
  sports,
  technology,
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// NEWS COUNTRY

enum NewsCountry {
  All,
  Argentina,
  Australia,
  Austria,
  Belgium,
  Brazil,
  Canada,
  China,
  Colombia,
  Czechia,
  Egypt,
  France,
  Germany,
  Greece,
  Hungary,
  India,
  Indonesia,
  Ireland,
  Israel,
  Italy,
  Japan,
  Malaysia,
  Mexico,
  Morocco,
  Netherlands,
  NewZealand,
  Nigeria,
  Pakistan,
  Philippines,
  Poland,
  Portugal,
  Russia,
  SaudiArabia,
  Singapore,
  SouthAfrica,
  SouthKorea,
  Spain,
  Sweden,
  Switzerland,
  Thailand,
  Turkey,
  UAE,
  UK,
  Ukraine,
  USA
}

extension NewsCountryExtension on NewsCountry {
  String get countryCode {
    switch (this) {
      case NewsCountry.All:
        return 'all';
      case NewsCountry.Argentina:
        return 'ar';
      case NewsCountry.Australia:
        return 'au';
      case NewsCountry.Austria:
        return 'at';
      case NewsCountry.Belgium:
        return 'be';
      case NewsCountry.Brazil:
        return 'br';
      case NewsCountry.Canada:
        return 'ca';
      case NewsCountry.China:
        return 'cn';
      case NewsCountry.Colombia:
        return 'co';
      case NewsCountry.Czechia:
        return 'cz';
      case NewsCountry.Egypt:
        return 'eg';
      case NewsCountry.France:
        return 'fr';
      case NewsCountry.Germany:
        return 'de';
      case NewsCountry.Greece:
        return 'gr';
      case NewsCountry.Hungary:
        return 'hu';
      case NewsCountry.India:
        return 'in';
      case NewsCountry.Indonesia:
        return 'id';
      case NewsCountry.Ireland:
        return 'ie';
      case NewsCountry.Israel:
        return 'il';
      case NewsCountry.Italy:
        return 'it';
      case NewsCountry.Japan:
        return 'jp';
      case NewsCountry.Malaysia:
        return 'my';
      case NewsCountry.Mexico:
        return 'mx';
      case NewsCountry.Morocco:
        return 'ma';
      case NewsCountry.Netherlands:
        return 'nl';
      case NewsCountry.NewZealand:
        return 'nz';
      case NewsCountry.Nigeria:
        return 'ng';
      case NewsCountry.Pakistan:
        return 'pk';
      case NewsCountry.Philippines:
        return 'ph';
      case NewsCountry.Poland:
        return 'pl';
      case NewsCountry.Portugal:
        return 'pt';
      case NewsCountry.Russia:
        return 'ru';
      case NewsCountry.SaudiArabia:
        return 'sa';
      case NewsCountry.Singapore:
        return 'sg';
      case NewsCountry.SouthAfrica:
        return 'za';
      case NewsCountry.SouthKorea:
        return 'kr';
      case NewsCountry.Spain:
        return 'es';
      case NewsCountry.Sweden:
        return 'se';
      case NewsCountry.Switzerland:
        return 'ch';
      case NewsCountry.Thailand:
        return 'th';
      case NewsCountry.Turkey:
        return 'tr';
      case NewsCountry.UAE:
        return 'ae';
      case NewsCountry.UK:
        return 'gb';
      case NewsCountry.Ukraine:
        return 'ua';
      case NewsCountry.USA:
        return 'us';
      default:
        return 'all';
    }
  }

  String get fullCountryName {
    switch (this) {
      case NewsCountry.All:
        return 'All';
      case NewsCountry.Argentina:
        return 'Argentina';
      case NewsCountry.Australia:
        return 'Australia';
      case NewsCountry.Austria:
        return 'Austria';
      case NewsCountry.Belgium:
        return 'Belgium';
      case NewsCountry.Brazil:
        return 'Brazil';
      case NewsCountry.Canada:
        return 'Canada';
      case NewsCountry.China:
        return 'China';
      case NewsCountry.Colombia:
        return 'Colombia';
      case NewsCountry.Czechia:
        return 'Czechia';
      case NewsCountry.Egypt:
        return 'Egypt';
      case NewsCountry.France:
        return 'France';
      case NewsCountry.Germany:
        return 'Germany';
      case NewsCountry.Greece:
        return 'Greece';
      case NewsCountry.Hungary:
        return 'Hungary';
      case NewsCountry.India:
        return 'India';
      case NewsCountry.Indonesia:
        return 'Indonesia';
      case NewsCountry.Ireland:
        return 'Ireland';
      case NewsCountry.Israel:
        return 'Israel';
      case NewsCountry.Italy:
        return 'Italy';
      case NewsCountry.Japan:
        return 'Japan';
      case NewsCountry.Malaysia:
        return 'Malaysia';
      case NewsCountry.Mexico:
        return 'Mexico';
      case NewsCountry.Morocco:
        return 'Morocco';
      case NewsCountry.Netherlands:
        return 'Netherlands';
      case NewsCountry.NewZealand:
        return 'New Zealand';
      case NewsCountry.Nigeria:
        return 'Nigeria';
      case NewsCountry.Pakistan:
        return 'Pakistan';
      case NewsCountry.Philippines:
        return 'Philippines';
      case NewsCountry.Poland:
        return 'Poland';
      case NewsCountry.Portugal:
        return 'Portugal';
      case NewsCountry.Russia:
        return 'Russia';
      case NewsCountry.SaudiArabia:
        return 'Saudi Arabia';
      case NewsCountry.Singapore:
        return 'Singapore';
      case NewsCountry.SouthAfrica:
        return 'South Africa';
      case NewsCountry.SouthKorea:
        return 'South Korea';
      case NewsCountry.Spain:
        return 'Spain';
      case NewsCountry.Sweden:
        return 'Sweden';
      case NewsCountry.Switzerland:
        return 'Switzerland';
      case NewsCountry.Thailand:
        return 'Thailand';
      case NewsCountry.Turkey:
        return 'Turkey';
      case NewsCountry.UAE:
        return 'United Arab Emirates';
      case NewsCountry.UK:
        return 'United Kingdom';
      case NewsCountry.Ukraine:
        return 'Ukraine';
      case NewsCountry.USA:
        return 'United States';
      default:
        return 'All';
    }
  }

  String get countryIcon {
    switch (this) {
      case NewsCountry.All:
        return 'assets/images/flags/globe.svg';
      case NewsCountry.Argentina:
        return 'assets/images/flags/ar.svg';
      case NewsCountry.Australia:
        return 'assets/images/flags/au.svg';
      case NewsCountry.Austria:
        return 'assets/images/flags/at.svg';
      case NewsCountry.Belgium:
        return 'assets/images/flags/be.svg';
      case NewsCountry.Brazil:
        return 'assets/images/flags/br.svg';
      case NewsCountry.Canada:
        return 'assets/images/flags/ca.svg';
      case NewsCountry.China:
        return 'assets/images/flags/cn.svg';
      case NewsCountry.Colombia:
        return 'assets/images/flags/co.svg';
      case NewsCountry.Czechia:
        return 'assets/images/flags/cz.svg';
      case NewsCountry.Egypt:
        return 'assets/images/flags/eg.svg';
      case NewsCountry.Greece:
        return 'assets/images/flags/gr.svg';
      case NewsCountry.India:
        return 'assets/images/flags/in.svg';
      case NewsCountry.Indonesia:
        return 'assets/images/flags/id.svg';
      case NewsCountry.Ireland:
        return 'assets/images/flags/ie.svg';
      case NewsCountry.Israel:
        return 'assets/images/flags/il.svg';
      case NewsCountry.Malaysia:
        return 'assets/images/flags/my.svg';
      case NewsCountry.Mexico:
        return 'assets/images/flags/mx.svg';
      case NewsCountry.Morocco:
        return 'assets/images/flags/ma.svg';
      case NewsCountry.NewZealand:
        return 'assets/images/flags/nz.svg';
      case NewsCountry.Nigeria:
        return 'assets/images/flags/ng.svg';
      case NewsCountry.Pakistan:
        return 'assets/images/flags/pk.svg';
      case NewsCountry.Philippines:
        return 'assets/images/flags/ph.svg';
      case NewsCountry.Russia:
        return 'assets/images/flags/ru.svg';
      case NewsCountry.Singapore:
        return 'assets/images/flags/sg.svg';
      case NewsCountry.SouthAfrica:
        return 'assets/images/flags/za.svg';
      case NewsCountry.SouthKorea:
        return 'assets/images/flags/kr.svg';
      case NewsCountry.Sweden:
        return 'assets/images/flags/se.svg';
      case NewsCountry.Switzerland:
        return 'assets/images/flags/ch.svg';
      case NewsCountry.UAE:
        return 'assets/images/flags/ae.svg';
      case NewsCountry.Ukraine:
        return 'assets/images/flags/ua.svg';
      case NewsCountry.USA:
        return 'assets/images/flags/us.svg';
      case NewsCountry.UK:
        return 'assets/images/flags/gb.svg';
      case NewsCountry.Spain:
        return 'assets/images/flags/es.svg';
      case NewsCountry.Germany:
        return 'assets/images/flags/de.svg';
      case NewsCountry.France:
        return 'assets/images/flags/fr.svg';
      case NewsCountry.Italy:
        return 'assets/images/flags/it.svg';
      case NewsCountry.Netherlands:
        return 'assets/images/flags/nl.svg';
      case NewsCountry.Poland:
        return 'assets/images/flags/pl.svg';
      case NewsCountry.Portugal:
        return 'assets/images/flags/pt.svg';
      case NewsCountry.Hungary:
        return 'assets/images/flags/hu.svg';
      case NewsCountry.SaudiArabia:
        return 'assets/images/flags/sa.svg';
      case NewsCountry.Japan:
        return 'assets/images/flags/jp.svg';
      case NewsCountry.Thailand:
        return 'assets/images/flags/th.svg';
      default:
        return 'assets/images/flags/gb.svg';
    }
  }
}

String getLocalizedCountry(NewsCountry country, BuildContext context) {
  switch (country) {
    case NewsCountry.All:
      return AppLocalizations.of(context)!.all;
    case NewsCountry.Argentina:
      return AppLocalizations.of(context)!.argentina;
    case NewsCountry.Australia:
      return AppLocalizations.of(context)!.australia;
    case NewsCountry.Austria:
      return AppLocalizations.of(context)!.austria;
    case NewsCountry.Belgium:
      return AppLocalizations.of(context)!.belgium;
    case NewsCountry.Brazil:
      return AppLocalizations.of(context)!.brazil;
    case NewsCountry.Canada:
      return AppLocalizations.of(context)!.canada;
    case NewsCountry.China:
      return AppLocalizations.of(context)!.china;
    case NewsCountry.Colombia:
      return AppLocalizations.of(context)!.colombia;
    case NewsCountry.Czechia:
      return AppLocalizations.of(context)!.czechia;
    case NewsCountry.Egypt:
      return AppLocalizations.of(context)!.egypt;
    case NewsCountry.France:
      return AppLocalizations.of(context)!.france;
    case NewsCountry.Germany:
      return AppLocalizations.of(context)!.germany;
    case NewsCountry.Greece:
      return AppLocalizations.of(context)!.greece;
    case NewsCountry.Hungary:
      return AppLocalizations.of(context)!.hungary;
    case NewsCountry.India:
      return AppLocalizations.of(context)!.india;
    case NewsCountry.Indonesia:
      return AppLocalizations.of(context)!.indonesia;
    case NewsCountry.Ireland:
      return AppLocalizations.of(context)!.ireland;
    case NewsCountry.Israel:
      return AppLocalizations.of(context)!.israel;
    case NewsCountry.Italy:
      return AppLocalizations.of(context)!.italy;
    case NewsCountry.Japan:
      return AppLocalizations.of(context)!.japan;
    case NewsCountry.Malaysia:
      return AppLocalizations.of(context)!.malaysia;
    case NewsCountry.Mexico:
      return AppLocalizations.of(context)!.mexico;
    case NewsCountry.Morocco:
      return AppLocalizations.of(context)!.morocco;
    case NewsCountry.Netherlands:
      return AppLocalizations.of(context)!.netherlands;
    case NewsCountry.NewZealand:
      return AppLocalizations.of(context)!.newZealand;
    case NewsCountry.Nigeria:
      return AppLocalizations.of(context)!.nigeria;
    case NewsCountry.Pakistan:
      return AppLocalizations.of(context)!.pakistan;
    case NewsCountry.Philippines:
      return AppLocalizations.of(context)!.philippines;
    case NewsCountry.Poland:
      return AppLocalizations.of(context)!.poland;
    case NewsCountry.Portugal:
      return AppLocalizations.of(context)!.portugal;
    case NewsCountry.Russia:
      return AppLocalizations.of(context)!.russia;
    case NewsCountry.Spain:
      return AppLocalizations.of(context)!.spain;
    case NewsCountry.Sweden:
      return AppLocalizations.of(context)!.sweden;
    case NewsCountry.Switzerland:
      return AppLocalizations.of(context)!.switzerland;
    case NewsCountry.Thailand:
      return AppLocalizations.of(context)!.thailand;
    case NewsCountry.Turkey:
      return AppLocalizations.of(context)!.turkey;
    case NewsCountry.UAE:
      return AppLocalizations.of(context)!.uae;
    case NewsCountry.UK:
      return AppLocalizations.of(context)!.uk;
    case NewsCountry.Ukraine:
      return AppLocalizations.of(context)!.ukraine;
    case NewsCountry.USA:
      return AppLocalizations.of(context)!.usa;
    default:
      return AppLocalizations.of(context)!.all;
  }
}

String getCountryFromLocale(String locale) {
  final langCode = locale.split('_').first;
  final countryCode = locale.substring(locale.length - 2);
  final Map<String, String> firstCountryPerLang = {
    'en': 'all',
    'es': 'all',
    'de': 'all',
    'fr': 'all',
    'pt': 'br',
    'it': 'it',
    'nl': 'nl',
    'sv': 'se',
    'ru': 'ru',
    'pl': 'pl',
    'cs': 'cz',
    'uk': 'ua',
    'el': 'gr',
    'tr': 'tr',
    'ar': 'all',
    'zh': 'cn',
    'ja': 'jp',
    'ko': 'kr',
    'th': 'th',
    'ms': 'my',
    'in': 'id',
  };

  if (locale.length < 4) {
    if (firstCountryPerLang.containsKey(langCode)) {
      return firstCountryPerLang[langCode] ?? 'all';
    } else {
      return 'all';
    }
  }

  switch (countryCode) {
    case 'AR':
    case 'AU':
    case 'AT':
    case 'BR':
    case 'CA':
    case 'CN':
    case 'CO':
    case 'CZ':
    case 'EG':
    case 'FR':
    case 'DE':
    case 'GR':
    case 'HU':
    case 'IN':
    case 'ID':
    case 'IE':
    case 'IT':
    case 'JP':
    case 'MY':
    case 'MX':
    case 'MA':
    case 'NL':
    case 'NZ':
    case 'NG':
    case 'PK':
    case 'PH':
    case 'PL':
    case 'PT':
    case 'RU':
    case 'SA':
    case 'SG':
    case 'ZA':
    case 'KR':
    case 'ES':
    case 'SE':
    case 'TH':
    case 'TR':
    case 'AE':
    case 'UA':
    case 'US':
      return countryCode.toLowerCase();
    case 'BE':
      if (langCode == 'fr' || langCode == 'nl') {
        return countryCode.toLowerCase();
      } else {
        return 'all';
      }
    case 'CH':
      if (langCode == 'de') {
        return countryCode.toLowerCase();
      } else if (langCode == 'it') {
        return 'it';
      } else {
        return 'all';
      }
    case 'GB':
      return 'uk';
    default:
      return 'all';
  }
}

// NEWS LANGUAGE

enum NewsLanguage {
  English,
  Spanish,
  German,
  French,
  Portuguese,
  Italian,
  Dutch,
  Swedish,
  Russian,
  Polish,
  Czech,
  Ukrainian,
  Hungarian,
  Greek,
  Turkish,
  Arabic,
  Chinese,
  Japanese,
  Korean,
  Thai,
  Malay,
  Indonesian
}

extension NewsLanguageExtension on NewsLanguage {
  String get languageCode {
    switch (this) {
      case NewsLanguage.English:
        return 'en';
      case NewsLanguage.Spanish:
        return 'es';
      case NewsLanguage.German:
        return 'de';
      case NewsLanguage.French:
        return 'fr';
      case NewsLanguage.Portuguese:
        return 'pt';
      case NewsLanguage.Italian:
        return 'it';
      case NewsLanguage.Dutch:
        return 'nl';
      case NewsLanguage.Swedish:
        return 'se';
      case NewsLanguage.Russian:
        return 'ru';
      case NewsLanguage.Polish:
        return 'pl';
      case NewsLanguage.Czech:
        return 'cz';
      case NewsLanguage.Ukrainian:
        return 'ua';
      case NewsLanguage.Hungarian:
        return 'hu';
      case NewsLanguage.Greek:
        return 'gr';
      case NewsLanguage.Turkish:
        return 'tr';
      case NewsLanguage.Arabic:
        return 'ar';
      case NewsLanguage.Chinese:
        return 'cn';
      case NewsLanguage.Japanese:
        return 'jp';
      case NewsLanguage.Korean:
        return 'kr';
      case NewsLanguage.Thai:
        return 'th';
      case NewsLanguage.Malay:
        return 'my';
      case NewsLanguage.Indonesian:
        return 'id';
      default:
        return 'en';
    }
  }

  String get languageIcon {
    switch (this) {
      case NewsLanguage.English:
        return 'assets/images/flags/gb.svg';
      case NewsLanguage.Spanish:
        return 'assets/images/flags/es.svg';
      case NewsLanguage.German:
        return 'assets/images/flags/de.svg';
      case NewsLanguage.French:
        return 'assets/images/flags/fr.svg';
      case NewsLanguage.Portuguese:
        return 'assets/images/flags/pt.svg';
      case NewsLanguage.Italian:
        return 'assets/images/flags/it.svg';
      case NewsLanguage.Dutch:
        return 'assets/images/flags/nl.svg';
      case NewsLanguage.Swedish:
        return 'assets/images/flags/se.svg';
      case NewsLanguage.Russian:
        return 'assets/images/flags/ru.svg';
      case NewsLanguage.Polish:
        return 'assets/images/flags/pl.svg';
      case NewsLanguage.Czech:
        return 'assets/images/flags/cz.svg';
      case NewsLanguage.Ukrainian:
        return 'assets/images/flags/ua.svg';
      case NewsLanguage.Hungarian:
        return 'assets/images/flags/hu.svg';
      case NewsLanguage.Greek:
        return 'assets/images/flags/gr.svg';
      case NewsLanguage.Turkish:
        return 'assets/images/flags/tr.svg';
      case NewsLanguage.Arabic:
        return 'assets/images/flags/sa.svg';
      case NewsLanguage.Chinese:
        return 'assets/images/flags/cn.svg';
      case NewsLanguage.Japanese:
        return 'assets/images/flags/jp.svg';
      case NewsLanguage.Korean:
        return 'assets/images/flags/kr.svg';
      case NewsLanguage.Thai:
        return 'assets/images/flags/th.svg';
      case NewsLanguage.Malay:
        return 'assets/images/flags/my.svg';
      case NewsLanguage.Indonesian:
        return 'assets/images/flags/id.svg';
      default:
        return 'assets/images/flags/gb.svg';
    }
  }

  List<NewsCountry> get countryLanguage {
    switch (this) {
      case NewsLanguage.English:
        return [
          NewsCountry.All,
          NewsCountry.USA,
          NewsCountry.Canada,
          NewsCountry.UK,
          NewsCountry.Ireland,
          NewsCountry.Australia,
          NewsCountry.NewZealand,
          NewsCountry.India,
          NewsCountry.Pakistan,
          NewsCountry.Nigeria,
          NewsCountry.SouthAfrica,
          NewsCountry.Israel,
          NewsCountry.China,
          NewsCountry.Singapore,
          NewsCountry.Philippines
        ];
      case NewsLanguage.Spanish:
        return [
          NewsCountry.All,
          NewsCountry.Spain,
          NewsCountry.Mexico,
          NewsCountry.Argentina,
          NewsCountry.Colombia
        ];
      case NewsLanguage.German:
        return [
          NewsCountry.All,
          NewsCountry.Germany,
          NewsCountry.Austria,
          NewsCountry.Switzerland
        ];
      case NewsLanguage.French:
        return [
          NewsCountry.All,
          NewsCountry.France,
          NewsCountry.Belgium,
          NewsCountry.Morocco
        ];
      case NewsLanguage.Portuguese:
        return [NewsCountry.Brazil, NewsCountry.Portugal];
      case NewsLanguage.Italian:
        return [NewsCountry.Italy];
      case NewsLanguage.Dutch:
        return [NewsCountry.Netherlands, NewsCountry.Belgium];
      case NewsLanguage.Swedish:
        return [NewsCountry.Sweden];
      case NewsLanguage.Russian:
        return [NewsCountry.Russia];
      case NewsLanguage.Polish:
        return [NewsCountry.Poland];
      case NewsLanguage.Czech:
        return [NewsCountry.Czechia];
      case NewsLanguage.Ukrainian:
        return [NewsCountry.Ukraine];
      case NewsLanguage.Hungarian:
        return [NewsCountry.Hungary];
      case NewsLanguage.Greek:
        return [NewsCountry.Greece];
      case NewsLanguage.Turkish:
        return [NewsCountry.Turkey];
      case NewsLanguage.Arabic:
        return [
          NewsCountry.All,
          NewsCountry.Egypt,
          NewsCountry.UAE,
          NewsCountry.SaudiArabia
        ];
      case NewsLanguage.Chinese:
        return [NewsCountry.China];
      case NewsLanguage.Japanese:
        return [NewsCountry.Japan];
      case NewsLanguage.Korean:
        return [NewsCountry.SouthKorea];
      case NewsLanguage.Thai:
        return [NewsCountry.Thailand];
      case NewsLanguage.Malay:
        return [NewsCountry.Malaysia];
      case NewsLanguage.Indonesian:
        return [NewsCountry.Indonesia];
      default:
        return [];
    }
  }
}

int languageIndex(String code) {
  switch (code) {
    case 'en':
      return 0;
    case 'es':
      return 1;
    case 'de':
      return 2;
    case 'fr':
      return 3;
    case 'pt':
      return 4;
    case 'it':
      return 5;
    case 'nl':
      return 6;
    case 'se':
      return 7;
    case 'ru':
      return 8;
    case 'pl':
      return 9;
    case 'cz':
      return 10;
    case 'ua':
      return 11;
    case 'hu':
      return 12;
    case 'gr':
      return 13;
    case 'tr':
      return 14;
    case 'ar':
      return 15;
    case 'cn':
      return 16;
    case 'jp':
      return 17;
    case 'kr':
      return 18;
    case 'th':
      return 19;
    case 'my':
      return 20;
    case 'id':
      return 21;
    default:
      return 0;
  }
}

String getLangNameFromCode(String code, BuildContext context) {
  switch (code) {
    case 'en':
      return AppLocalizations.of(context)!.english;
    case 'es':
      return AppLocalizations.of(context)!.spanish;
    case 'de':
      return AppLocalizations.of(context)!.german;
    case 'fr':
      return AppLocalizations.of(context)!.french;
    case 'pt':
      return AppLocalizations.of(context)!.portuguese;
    case 'it':
      return AppLocalizations.of(context)!.italian;
    case 'nl':
      return AppLocalizations.of(context)!.dutch;
    case 'se':
      return AppLocalizations.of(context)!.swedish;
    case 'ru':
      return AppLocalizations.of(context)!.russian;
    case 'pl':
      return AppLocalizations.of(context)!.polish;
    case 'cz':
      return AppLocalizations.of(context)!.czech;
    case 'ua':
      return AppLocalizations.of(context)!.ukrainian;
    case 'hu':
      return AppLocalizations.of(context)!.hungarian;
    case 'gr':
      return AppLocalizations.of(context)!.greek;
    case 'tr':
      return AppLocalizations.of(context)!.turkish;
    case 'ar':
      return AppLocalizations.of(context)!.arabic;
    case 'cn':
      return AppLocalizations.of(context)!.chinese;
    case 'jp':
      return AppLocalizations.of(context)!.japanese;
    case 'kr':
      return AppLocalizations.of(context)!.korean;
    case 'th':
      return AppLocalizations.of(context)!.thai;
    case 'my':
      return AppLocalizations.of(context)!.malay;
    case 'id':
      return AppLocalizations.of(context)!.indonesian;
    default:
      return AppLocalizations.of(context)!.english;
  }
}

String getCountryNameFromCode(String code, BuildContext context) {
  switch (code) {
    case 'all':
      return AppLocalizations.of(context)!.all;
    case 'ar':
      return AppLocalizations.of(context)!.argentina;
    case 'au':
      return AppLocalizations.of(context)!.australia;
    case 'at':
      return AppLocalizations.of(context)!.austria;
    case 'be':
      return AppLocalizations.of(context)!.belgium;
    case 'br':
      return AppLocalizations.of(context)!.brazil;
    case 'ca':
      return AppLocalizations.of(context)!.canada;
    case 'cn':
      return AppLocalizations.of(context)!.china;
    case 'co':
      return AppLocalizations.of(context)!.colombia;
    case 'cz':
      return AppLocalizations.of(context)!.czechia;
    case 'eg':
      return AppLocalizations.of(context)!.egypt;
    case 'fr':
      return AppLocalizations.of(context)!.france;
    case 'de':
      return AppLocalizations.of(context)!.germany;
    case 'gr':
      return AppLocalizations.of(context)!.greece;
    case 'hu':
      return AppLocalizations.of(context)!.hungary;
    case 'in':
      return AppLocalizations.of(context)!.india;
    case 'id':
      return AppLocalizations.of(context)!.indonesia;
    case 'ie':
      return AppLocalizations.of(context)!.ireland;
    case 'il':
      return AppLocalizations.of(context)!.israel;
    case 'it':
      return AppLocalizations.of(context)!.italy;
    case 'jp':
      return AppLocalizations.of(context)!.japan;
    case 'my':
      return AppLocalizations.of(context)!.malaysia;
    case 'mx':
      return AppLocalizations.of(context)!.mexico;
    case 'ma':
      return AppLocalizations.of(context)!.morocco;
    case 'nl':
      return AppLocalizations.of(context)!.netherlands;
    case 'nz':
      return AppLocalizations.of(context)!.newZealand;
    case 'ng':
      return AppLocalizations.of(context)!.nigeria;
    case 'pk':
      return AppLocalizations.of(context)!.pakistan;
    case 'pl':
      return AppLocalizations.of(context)!.poland;
    case 'pt':
      return AppLocalizations.of(context)!.portugal;
    case 'ru':
      return AppLocalizations.of(context)!.russia;
    case 'sa':
      return AppLocalizations.of(context)!.saudiArabia;
    case 'sg':
      return AppLocalizations.of(context)!.singapore;
    case 'za':
      return AppLocalizations.of(context)!.southAfrica;
    case 'kr':
      return AppLocalizations.of(context)!.southKorea;
    case 'es':
      return AppLocalizations.of(context)!.spain;
    case 'se':
      return AppLocalizations.of(context)!.sweden;
    case 'ch':
      return AppLocalizations.of(context)!.switzerland;
    case 'th':
      return AppLocalizations.of(context)!.thailand;
    case 'tr':
      return AppLocalizations.of(context)!.turkey;
    case 'ae':
      return AppLocalizations.of(context)!.uae;
    case 'uk':
      return AppLocalizations.of(context)!.uk;
    case 'ua':
      return AppLocalizations.of(context)!.ukraine;
    case 'us':
      return AppLocalizations.of(context)!.usa;
    default:
      return AppLocalizations.of(context)!.all;
  }
}

String getLocalizedLanguage(NewsLanguage lang, BuildContext context) {
  switch (lang) {
    case NewsLanguage.Arabic:
      return AppLocalizations.of(context)!.arabic;
    case NewsLanguage.Chinese:
      return AppLocalizations.of(context)!.chinese;
    case NewsLanguage.Czech:
      return AppLocalizations.of(context)!.czech;
    case NewsLanguage.Dutch:
      return AppLocalizations.of(context)!.dutch;
    case NewsLanguage.English:
      return AppLocalizations.of(context)!.english;
    case NewsLanguage.French:
      return AppLocalizations.of(context)!.french;
    case NewsLanguage.German:
      return AppLocalizations.of(context)!.german;
    case NewsLanguage.Greek:
      return AppLocalizations.of(context)!.greek;
    case NewsLanguage.Hungarian:
      return AppLocalizations.of(context)!.hungarian;
    case NewsLanguage.Indonesian:
      return AppLocalizations.of(context)!.indonesian;
    case NewsLanguage.Italian:
      return AppLocalizations.of(context)!.italian;
    case NewsLanguage.Japanese:
      return AppLocalizations.of(context)!.japanese;
    case NewsLanguage.Korean:
      return AppLocalizations.of(context)!.korean;
    case NewsLanguage.Malay:
      return AppLocalizations.of(context)!.malay;
    case NewsLanguage.Polish:
      return AppLocalizations.of(context)!.polish;
    case NewsLanguage.Portuguese:
      return AppLocalizations.of(context)!.portuguese;
    case NewsLanguage.Russian:
      return AppLocalizations.of(context)!.russian;
    case NewsLanguage.Spanish:
      return AppLocalizations.of(context)!.spanish;
    case NewsLanguage.Swedish:
      return AppLocalizations.of(context)!.swedish;
    case NewsLanguage.Thai:
      return AppLocalizations.of(context)!.thai;
    case NewsLanguage.Turkish:
      return AppLocalizations.of(context)!.turkish;
    case NewsLanguage.Ukrainian:
      return AppLocalizations.of(context)!.ukrainian;
    default:
      return AppLocalizations.of(context)!.english;
  }
}

String getLanguageFromLocale(String locale) {
  final langCode = locale.split('_').first;
  switch (langCode) {
    case 'en':
    case 'es':
    case 'de':
    case 'fr':
    case 'pt':
    case 'it':
    case 'nl':
    case 'ru':
    case 'pl':
    case 'tr':
    case 'ar':
    case 'th':
      return langCode;
    case 'sv':
      return 'se';
    case 'cs':
      return 'cz';
    case 'uk':
      return 'ua';
    case 'el':
      return 'gr';
    case 'zh':
      return 'cn';
    case 'ja':
      return 'jp';
    case 'ko':
      return 'kr';
    case 'ms':
      return 'my';
    case 'in':
      return 'id';
    default:
      return 'en';
  }
}

// Languages from NewsAPI

final List<String> newsAPILangs = [
  'cn',
  'cz',
  'gr',
  'id',
  'it',
  'my',
  'kr',
  'pt',
  'ru',
  'se',
  'tr',
  'ua'
];
final List<String> newsAPICountries = [
  'at',
  'ch',
  'ie',
  'nz',
  'za',
  'ng',
  'ma',
  'ph'
];
