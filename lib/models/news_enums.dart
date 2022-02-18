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
        return 'ie';
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
    case 'in':
      return 21;
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
    case 'pt':
      return 'Portuguese';
    case 'it':
      return 'Italian';
    case 'nl':
      return 'Dutch';
    case 'se':
      return 'Swedish';
    case 'ru':
      return 'Russian';
    case 'pl':
      return 'Polish';
    case 'cz':
      return 'Czech';
    case 'ua':
      return 'Ukrainian';
    case 'hu':
      return 'Hungarian';
    case 'gr':
      return 'Greek';
    case 'tr':
      return 'Turkish';
    case 'ar':
      return 'Arabic';
    case 'cn':
      return 'Chinese';
    case 'jp':
      return 'Japanese';
    case 'kr':
      return 'Korean';
    case 'th':
      return 'Thai';
    case 'my':
      return 'Malay';
    case 'id':
      return 'Indonesian';
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
    case 'at':
      return 'Austria';
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
    case 'cz':
      return 'Czechia';
    case 'eg':
      return 'Egypt';
    case 'fr':
      return 'France';
    case 'de':
      return 'Germany';
    case 'gr':
      return 'Greece';
    case 'hu':
      return 'Hungary';
    case 'in':
      return 'India';
    case 'id':
      return 'Indonesia';
    case 'ie':
      return 'Ireland';
    case 'il':
      return 'Israel';
    case 'it':
      return 'Italy';
    case 'jp':
      return 'Japan';
    case 'my':
      return 'Malaysia';
    case 'mx':
      return 'Mexico';
    case 'ma':
      return 'Morocco';
    case 'nl':
      return 'Netherlands';
    case 'nz':
      return 'New Zealand';
    case 'ng':
      return 'Nigeria';
    case 'pk':
      return 'Pakistan';
    case 'pl':
      return 'Poland';
    case 'pt':
      return 'Portugal';
    case 'ru':
      return 'Russia';
    case 'sa':
      return 'Saudi Arabia';
    case 'sg':
      return 'Singapore';
    case 'za':
      return 'South Africa';
    case 'kr':
      return 'South Korea';
    case 'es':
      return 'Spain';
    case 'se':
      return 'Sweden';
    case 'ch':
      return 'Switzerland';
    case 'th':
      return 'Thailand';
    case 'tr':
      return 'Turkey';
    case 'ae':
      return 'UAE';
    case 'uk':
      return 'United Kingdom';
    case 'ua':
      return 'Ukraine';
    case 'us':
      return 'United States';
    default:
      return 'All';
  }
}

final List<String> newsAPILangs = [
  'cn',
  'cz',
  'gr',
  'id',
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
