// ignore_for_file: constant_identifier_names

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

enum NewsCountry {
  All,
  Argentina,
  Australia,
  Belgium,
  Brazil,
  Canada,
  China,
  Colombia,
  Egypt,
  France,
  Germany,
  Hungary,
  India,
  Israel,
  Italy,
  Japan,
  Mexico,
  Netherlands,
  Pakistan,
  Poland,
  Portugal,
  SaudiArabia,
  Singapore,
  Spain,
  Thailand,
  UAE,
  UK,
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
      case NewsCountry.Egypt:
        return 'eg';
      case NewsCountry.France:
        return 'fr';
      case NewsCountry.Germany:
        return 'de';
      case NewsCountry.Hungary:
        return 'hu';
      case NewsCountry.India:
        return 'in';
      case NewsCountry.Israel:
        return 'il';
      case NewsCountry.Italy:
        return 'it';
      case NewsCountry.Japan:
        return 'jp';
      case NewsCountry.Mexico:
        return 'mx';
      case NewsCountry.Netherlands:
        return 'nl';
      case NewsCountry.Pakistan:
        return 'pk';
      case NewsCountry.Poland:
        return 'pl';
      case NewsCountry.Portugal:
        return 'pt';
      case NewsCountry.SaudiArabia:
        return 'sa';
      case NewsCountry.Singapore:
        return 'sg';
      case NewsCountry.Spain:
        return 'es';
      case NewsCountry.Thailand:
        return 'th';
      case NewsCountry.UAE:
        return 'ae';
      case NewsCountry.UK:
        return 'gb';
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
      case NewsCountry.Egypt:
        return 'Egypt';
      case NewsCountry.France:
        return 'France';
      case NewsCountry.Germany:
        return 'Germany';
      case NewsCountry.Hungary:
        return 'Hungary';
      case NewsCountry.India:
        return 'India';
      case NewsCountry.Israel:
        return 'Israel';
      case NewsCountry.Italy:
        return 'Italy';
      case NewsCountry.Japan:
        return 'Japan';
      case NewsCountry.Mexico:
        return 'Mexico';
      case NewsCountry.Netherlands:
        return 'Netherlands';
      case NewsCountry.Pakistan:
        return 'Pakistan';
      case NewsCountry.Poland:
        return 'Poland';
      case NewsCountry.Portugal:
        return 'Portugal';
      case NewsCountry.SaudiArabia:
        return 'Saudi Arabia';
      case NewsCountry.Singapore:
        return 'Singapore';
      case NewsCountry.Spain:
        return 'Spain';
      case NewsCountry.Thailand:
        return 'Thailand';
      case NewsCountry.UAE:
        return 'United Arab Emirates';
      case NewsCountry.UK:
        return 'United Kingdom';
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
      case NewsCountry.Egypt:
        return 'assets/images/flags/eg.svg';
      case NewsCountry.India:
        return 'assets/images/flags/in.svg';
      case NewsCountry.Israel:
        return 'assets/images/flags/il.svg';
      case NewsCountry.Mexico:
        return 'assets/images/flags/mx.svg';
      case NewsCountry.Pakistan:
        return 'assets/images/flags/pk.svg';
      case NewsCountry.Singapore:
        return 'assets/images/flags/sg.svg';
      case NewsCountry.UAE:
        return 'assets/images/flags/ae.svg';
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

enum NewsLanguage {
  English,
  Spanish,
  German,
  French,
  Italian,
  Dutch,
  Polish,
  Portuguese,
  Hungarian,
  Arabic,
  Japanese,
  Thai,
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
      case NewsLanguage.Italian:
        return 'it';
      case NewsLanguage.Dutch:
        return 'nl';
      case NewsLanguage.Polish:
        return 'pl';
      case NewsLanguage.Portuguese:
        return 'pt';
      case NewsLanguage.Hungarian:
        return 'hu';
      case NewsLanguage.Arabic:
        return 'ar';
      case NewsLanguage.Japanese:
        return 'jp';
      case NewsLanguage.Thai:
        return 'th';
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
      case NewsLanguage.Italian:
        return 'assets/images/flags/it.svg';
      case NewsLanguage.Dutch:
        return 'assets/images/flags/nl.svg';
      case NewsLanguage.Polish:
        return 'assets/images/flags/pl.svg';
      case NewsLanguage.Portuguese:
        return 'assets/images/flags/pt.svg';
      case NewsLanguage.Hungarian:
        return 'assets/images/flags/hu.svg';
      case NewsLanguage.Arabic:
        return 'assets/images/flags/sa.svg';
      case NewsLanguage.Japanese:
        return 'assets/images/flags/jp.svg';
      case NewsLanguage.Thai:
        return 'assets/images/flags/th.svg';
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
          NewsCountry.Australia,
          NewsCountry.Israel,
          NewsCountry.India,
          NewsCountry.Pakistan,
          NewsCountry.China,
          NewsCountry.Singapore
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
        return [NewsCountry.All, NewsCountry.Germany];
      case NewsLanguage.French:
        return [NewsCountry.All, NewsCountry.France, NewsCountry.Belgium];
      case NewsLanguage.Italian:
        return [NewsCountry.All, NewsCountry.Italy];
      case NewsLanguage.Dutch:
        return [NewsCountry.All, NewsCountry.Netherlands, NewsCountry.Belgium];
      case NewsLanguage.Polish:
        return [NewsCountry.Poland];
      case NewsLanguage.Portuguese:
        return [NewsCountry.Brazil, NewsCountry.Portugal];
      case NewsLanguage.Hungarian:
        return [NewsCountry.Hungary];
      case NewsLanguage.Arabic:
        return [
          NewsCountry.All,
          NewsCountry.Egypt,
          NewsCountry.UAE,
          NewsCountry.SaudiArabia
        ];
      case NewsLanguage.Japanese:
        return [NewsCountry.Japan];
      case NewsLanguage.Thai:
        return [NewsCountry.Thailand];
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
    case 'it':
      return 4;
    case 'nl':
      return 5;
    case 'pl':
      return 6;
    case 'pt':
      return 7;
    case 'hu':
      return 8;
    case 'ar':
      return 9;
    case 'jp':
      return 10;
    case 'th':
      return 11;
    case 'in':
      return 12;
    default:
      return 0;
  }
}

String getLangNameFromCode(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'es':
      return 'Spanish';
    case 'de':
      return 'German';
    case 'fr':
      return 'Frech';
    case 'it':
      return 'Italian';
    case 'nl':
      return 'Dutch';
    case 'pl':
      return 'Polish';
    case 'pt':
      return 'Portuguese';
    case 'hu':
      return 'Hungarian';
    case 'ar':
      return 'Arabic';
    case 'jp':
      return 'Japanese';
    case 'th':
      return 'Thai';
    default:
      return 'English';
  }
}

String getCountryNameFromCode(String code) {
  switch (code) {
    case 'all':
      return 'All';
    case 'ar':
      return 'Argentina';
    case 'au':
      return 'Australia';
    case 'be':
      return 'Belgium';
    case 'br':
      return 'Brazil';
    case 'ca':
      return 'Canada';
    case 'cn':
      return 'China';
    case 'co':
      return 'Colombia';
    case 'eg':
      return 'Egypt';
    case 'fr':
      return 'France';
    case 'de':
      return 'Germany';
    case 'hu':
      return 'Hungary';
    case 'in':
      return 'India';
    case 'il':
      return 'Israel';
    case 'it':
      return 'Italy';
    case 'jp':
      return 'Japan';
    case 'mx':
      return 'Mexico';
    case 'nl':
      return 'Netherlands';
    case 'pk':
      return 'Pakistan';
    case 'pl':
      return 'Poland';
    case 'pt':
      return 'Portugal';
    case 'sa':
      return 'Saudi Arabia';
    case 'sg':
      return 'Singapore';
    case 'es':
      return 'Spain';
    case 'th':
      return 'Thailand';
    case 'ae':
      return 'UAE';
    case 'uk':
      return 'United Kingdom';
    case 'us':
      return 'United States';
    default:
      return 'All';
  }
}
