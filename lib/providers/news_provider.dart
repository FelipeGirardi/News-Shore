// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '/models/news_response.dart';
import '/models/news_data.dart';
import '/models/news_api_response.dart';
import '/models/news_api_data.dart';
import '/models/news_enums.dart';
import '/helpers/api_data.dart';
import '/helpers/sql_helper.dart';
import '/helpers/image_helper.dart';

class NewsProvider with ChangeNotifier {
  List<NewsData> _newsList = [];
  int _totalNews = 0;
  String _nextPage = '';
  int _nextPageCounter = 0;
  int _nextPageNewsAPICounter = 0;
  bool _isLastPage = false;

  String selectedFilter = '';
  bool _isFilterSelected = false;
  bool isLoadingNews = false;

  List<NewsData> _searchNewsList = [];
  int _searchTotalNews = 0;
  String _searchNextPage = '';
  int _searchnextPageNewsAPICounter = 0;
  bool _isLastSearchPage = false;

  List<NewsData> _bookmarkedNewsList = [];
  String? currentLang;
  String? currentCountry;

  List<NewsData> get newsList {
    return [..._newsList];
  }

  int get totalNews {
    return _totalNews;
  }

  String get nextPage {
    return _nextPage;
  }

  int get nextPageCounter {
    return _nextPageCounter;
  }

  int get nextPageNewsAPICounter {
    return _nextPageNewsAPICounter;
  }

  bool get isLastPage {
    return _isLastPage;
  }

  List<NewsData> get searchNewsList {
    return [..._searchNewsList];
  }

  String get searchNextPage {
    return _searchNextPage;
  }

  int get searchnextPageNewsAPICounter {
    return _searchnextPageNewsAPICounter;
  }

  bool get isLastSearchPage {
    return _isLastSearchPage;
  }

  List<NewsData> get bookmarkedNewsList {
    return [..._bookmarkedNewsList];
  }

  bool get shouldFetchNewsAPI {
    return newsAPILangs.contains(currentLang) ||
        newsAPICountries.contains(currentCountry);
  }

  void clearNews() {
    _newsList.clear();
    _totalNews = 0;
    _nextPage = '';
    _nextPageCounter = 0;
    _nextPageNewsAPICounter = 0;
  }

  Future<void> didCloseFiltersDrawer() async {
    if (selectedFilter.isNotEmpty ||
        (selectedFilter.isEmpty && _isFilterSelected)) {
      _newsList.clear();
      _totalNews = 0;
      _nextPage = '';
      _nextPageCounter = 0;
      _nextPageNewsAPICounter = 0;
      selectedFilter.isEmpty
          ? _isFilterSelected = false
          : _isFilterSelected = true;
      isLoadingNews = true;
      notifyListeners();
      await fetchNews();
    }
  }

  Future<void> fetchNews() async {
    final prefs = await SharedPreferences.getInstance();
    if (currentLang == null || currentCountry == null) {
      currentLang = prefs.getString('language') ?? 'en';
      currentCountry = prefs.getString('country') ?? 'us';
    }
    if (_newsList.length <= _totalNews) {
      if (!shouldFetchNewsAPI) {
        for (var i = 0; i < 2; i++) {
          await fetchNewsPage(currentLang!, currentCountry!);
          _nextPageCounter += 1;
        }
      } else {
        await fetchNewsAPIPage(currentCountry!);
        _nextPageNewsAPICounter += 2;
      }
      if (newsList.length % 10 != 0) {
        _isLastPage = true;
        if (shouldFetchNewsAPI) {
          _nextPageNewsAPICounter -= (newsList.length % 20 != 0) ? 1 : 0;
        }
        _newsList =
            _newsList.sublist(0, newsList.length - (newsList.length % 10));
      }
      isLoadingNews = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> fetchNewsPage(String language, String country) async {
    final String apiKeyNewsData = APIData.apiKeyNewsData;
    String uriString = country == 'all'
        ? (_isFilterSelected
            ? (nextPage.isEmpty
                ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&category=' +
                    selectedFilter
                : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=${nextPage}&category=' +
                    selectedFilter)
            : (nextPage.isEmpty
                ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&category=top'
                : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=${nextPage}&category=top'))
        : (_isFilterSelected
            ? (nextPage.isEmpty
                ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&category=' +
                    selectedFilter
                : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=${nextPage}&category=' +
                    selectedFilter)
            : (nextPage.isEmpty
                ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&category=top'
                : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=${nextPage}&category=top'));
    final Uri url = Uri.parse(uriString);
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsResponse.fromJson(decoded);
      _totalNews = initialNewsResponse.totalResults ?? 0;
      _nextPage = initialNewsResponse.nextPage ?? '';
      if (initialNewsResponse.nextPage == null) {
        _isLastPage = true;
      }

      var newsFuture = initialNewsResponse.results!.map((i) async {
        NewsData nData = NewsData.fromJson(i);
        nData.showImage = await ImageHelper.shouldShowImage(nData.imageUrl);
        return nData;
      }).toList();
      _newsList.addAll(await Future.wait(newsFuture));
    }
  }

  Future<void> fetchNewsAPIPage(String country) async {
    final String apiKeyNewsApi = APIData.apiKeyNewsApi;
    final Uri url = Uri.parse(_isFilterSelected
        ? 'https://newsapi.org/v2/top-headlines?apiKey=$apiKeyNewsApi&country=$country&page=$nextPageNewsAPICounter&category=' +
            selectedFilter
        : 'https://newsapi.org/v2/top-headlines?apiKey=$apiKeyNewsApi&country=$country&page=$nextPageNewsAPICounter');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsAPIResponse.fromJson(decoded);
      _totalNews = initialNewsResponse.totalResults ?? 0;

      var newsFuture = initialNewsResponse.articles!.map((i) async {
        NewsData nData = NewsAPIData.fromJson(i).toNewsData();
        nData.showImage = await ImageHelper.shouldShowImage(nData.imageUrl);
        return nData;
      }).toList();
      _newsList.addAll(await Future.wait(newsFuture));
    }
  }

  Future<List<NewsData?>?> fetchSearchNews(String query) async {
    if (_searchNewsList.length <= _searchTotalNews) {
      if (!shouldFetchNewsAPI) {
        for (var i = 0; i < 2; i++) {
          await fetchSearchNewsPage(
              currentLang ?? 'en', currentCountry ?? 'all', query);
          // _searchNextPage += 1;
        }
        isLoadingNews = false;
        notifyListeners();
        return _searchNewsList;
      } else {
        await fetchSearchNewsAPIPage(currentCountry ?? 'br', query);
        _searchnextPageNewsAPICounter += 2;
        isLoadingNews = false;
        notifyListeners();
        return _searchNewsList;
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> fetchSearchNewsPage(
      String language, String country, String query) async {
    final String apiKeyNewsData = APIData.apiKeyNewsData;
    final String urlString = country == 'all'
        ? searchNextPage.isEmpty
            ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&qInTitle=$query'
            : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=$searchNextPage&qInTitle=$query'
        : searchNextPage.isEmpty
            ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&qInTitle=$query'
            : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=$searchNextPage&qInTitle=$query';
    final response = await http.get(Uri.parse(urlString));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsResponse.fromJson(decoded);
      _searchTotalNews = initialNewsResponse.totalResults ?? 0;
      _searchNextPage = initialNewsResponse.nextPage ?? '';
      if (initialNewsResponse.nextPage == null) {
        _isLastSearchPage = true;
      }
      var newsFuture = initialNewsResponse.results!.map((i) async {
        NewsData nData = NewsData.fromJson(i);
        nData.showImage = await ImageHelper.shouldShowImage(nData.imageUrl);
        return nData;
      }).toList();
      _searchNewsList.addAll(await Future.wait(newsFuture));
    }
  }

  Future<void> fetchSearchNewsAPIPage(String country, String query) async {
    final String apiKeyNewsApi = APIData.apiKeyNewsApi;
    final Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?apiKey=$apiKeyNewsApi&country=$country&page=$searchnextPageNewsAPICounter&q=query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsAPIResponse.fromJson(decoded);
      _searchTotalNews = initialNewsResponse.totalResults ?? 0;
      _searchNewsList.addAll(initialNewsResponse.articles!
          .map((i) => NewsAPIData.fromJson(i).toNewsData())
          .toList());
    }
  }

  void clearSearchNewsList() {
    _searchNewsList.clear();
    _searchTotalNews = 0;
    _searchNextPage = '';
    _searchnextPageNewsAPICounter = 0;
  }

  Future<void> addBookmark(NewsData newsData) async {
    _bookmarkedNewsList.add(newsData);
    notifyListeners();
    Map<String, Object> newsDataMap = newsData.toMap();
    await SQLHelper.insertBookmark('bookmarked_news', newsDataMap);
  }

  Future<void> removeBookmark(NewsData newsData) async {
    _bookmarkedNewsList.removeWhere((item) => item.id == newsData.id);
    notifyListeners();
    await SQLHelper.removeBookmark('bookmarked_news', newsData.id!);
  }

  Future<void> fetchBookmarks() async {
    final bookmarks = await SQLHelper.getBookmarks('bookmarked_news');
    _bookmarkedNewsList =
        bookmarks.map((newsData) => NewsData.fromMap(newsData)).toList();
    notifyListeners();
  }

  void setLanguagePref(
      SharedPreferences prefs, String langName, String countryName) {
    prefs.setString('language', langName);
    prefs.setString('country', countryName);
    currentLang = langName;
    currentCountry = countryName;
    clearNews();
    notifyListeners();
  }

  void setCountryPref(SharedPreferences prefs, String countryName) {
    prefs.setString('country', countryName);
    currentCountry = countryName;
    clearNews();
    notifyListeners();
  }
}
