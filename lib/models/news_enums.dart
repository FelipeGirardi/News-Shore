// ignore_for_file: constant_identifier_names

enum NewsCategory {
  business,
  entertainment,
  health,
  politics,
  science,
  sports,
  technology,
  world,
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
  Canada,
  China,
  Colombia,
  Egypt,
  France,
  Germany,
  Hungary,
  India,
  Indonesia,
  Israel,
  Italy,
  Japan,
  Mexico,
  Netherlands,
  Pakistan,
  Poland,
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
        return '';
      case NewsCountry.Argentina:
        return 'ar';
      case NewsCountry.Australia:
        return 'au';
      case NewsCountry.Belgium:
        return 'be';
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
      case NewsCountry.Indonesia:
        return 'id';
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
        return '';
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
      case NewsCountry.Indonesia:
        return 'indonesia';
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
        return '';
      case NewsCountry.Argentina:
        return 'assets/images/flags/ar.svg';
      case NewsCountry.Australia:
        return 'assets/images/flags/au.svg';
      case NewsCountry.Belgium:
        return 'assets/images/flags/be.svg';
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
      case NewsCountry.Hungary:
        return 'assets/images/flags/hu.svg';
      case NewsCountry.SaudiArabia:
        return 'assets/images/flags/sa.svg';
      case NewsCountry.Japan:
        return 'assets/images/flags/jp.svg';
      case NewsCountry.Thailand:
        return 'assets/images/flags/th.svg';
      case NewsCountry.Indonesia:
        return 'assets/images/flags/id.svg';
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
  Hungarian,
  Arabic,
  Japanese,
  Thai,
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
      case NewsLanguage.Italian:
        return 'it';
      case NewsLanguage.Dutch:
        return 'nl';
      case NewsLanguage.Polish:
        return 'pl';
      case NewsLanguage.Hungarian:
        return 'hu';
      case NewsLanguage.Arabic:
        return 'in';
      case NewsLanguage.Japanese:
        return 'jp';
      case NewsLanguage.Thai:
        return 'th';
      case NewsLanguage.Indonesian:
        return 'in';
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
      case NewsLanguage.Hungarian:
        return 'assets/images/flags/hu.svg';
      case NewsLanguage.Arabic:
        return 'assets/images/flags/sa.svg';
      case NewsLanguage.Japanese:
        return 'assets/images/flags/jp.svg';
      case NewsLanguage.Thai:
        return 'assets/images/flags/th.svg';
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
        return [NewsCountry.All, NewsCountry.Poland];
      case NewsLanguage.Hungarian:
        return [NewsCountry.All, NewsCountry.Hungary];
      case NewsLanguage.Arabic:
        return [
          NewsCountry.All,
          NewsCountry.Egypt,
          NewsCountry.UAE,
          NewsCountry.SaudiArabia
        ];
      case NewsLanguage.Japanese:
        return [NewsCountry.All, NewsCountry.Japan];
      case NewsLanguage.Thai:
        return [NewsCountry.All, NewsCountry.Thailand];
      case NewsLanguage.Indonesian:
        return [NewsCountry.All, NewsCountry.Indonesia];
      default:
        return [];
    }
  }
}
