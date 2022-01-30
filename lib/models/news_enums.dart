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

String getLanguageCode(NewsLanguage lang) {
  switch (lang) {
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
  Saudi_Arabia,
  Singapore,
  Spain,
  Thailand,
  UAE,
  UK,
  USA
}

String getCountryCode(NewsCountry country) {
  switch (country) {
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
    case NewsCountry.Saudi_Arabia:
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
      return 'us';
  }
}

Map<NewsLanguage, List<NewsCountry>> countryLanguages = {
  NewsLanguage.English: [
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
  ],
  NewsLanguage.Spanish: [
    NewsCountry.All,
    NewsCountry.Spain,
    NewsCountry.Mexico,
    NewsCountry.Argentina,
    NewsCountry.Colombia
  ],
  NewsLanguage.German: [NewsCountry.All, NewsCountry.Germany],
  NewsLanguage.French: [
    NewsCountry.All,
    NewsCountry.France,
    NewsCountry.Belgium
  ],
  NewsLanguage.Italian: [NewsCountry.All, NewsCountry.Italy],
  NewsLanguage.Dutch: [
    NewsCountry.All,
    NewsCountry.Netherlands,
    NewsCountry.Belgium
  ],
  NewsLanguage.Polish: [NewsCountry.All, NewsCountry.Poland],
  NewsLanguage.Hungarian: [NewsCountry.All, NewsCountry.Hungary],
  NewsLanguage.Arabic: [
    NewsCountry.All,
    NewsCountry.Egypt,
    NewsCountry.UAE,
    NewsCountry.Saudi_Arabia
  ],
  NewsLanguage.Japanese: [NewsCountry.All, NewsCountry.Japan],
  NewsLanguage.Thai: [NewsCountry.All, NewsCountry.Thailand],
  NewsLanguage.Indonesian: [NewsCountry.All, NewsCountry.Indonesia],
};
