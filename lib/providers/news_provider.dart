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
import '/helpers/sql_helper.dart';

String apiKeyNewsData = 'pub_3162ee115d2cfdf10b4bb42c76aca12b66fd';
String apiKeyNewsApi = 'c4e583b9475d4ae387011a2cf2c9f951';

class NewsProvider with ChangeNotifier {
  // ** NewsData list **
  List<NewsData> _newsList = [];
  int _totalNews = 0;
  int _nextPage = 0;
  bool _isLastPage = false;

  List<String> filtersSelected = [];
  bool _isFilterSelected = false;
  bool isLoadingNews = false;

  List<NewsData> _searchNewsList = [];
  int _searchTotalNews = 0;
  int _searchNextPage = 0;
  bool _isLastSearchPage = false;

  List<NewsData> _bookmarkedNewsList = [];
  String? currentLang;
  String? currentCountry;

  // ** NewsAPIData list **
  List<NewsAPIData> _newsAPIList = [];
  List<NewsAPIData> _searchNewsAPIList = [];
  List<NewsAPIData> _bookmarkedNewsAPIList = [];

  List<NewsData> get newsList {
    return [..._newsList];
  }

  int get totalNews {
    return _totalNews;
  }

  int get nextPage {
    return _nextPage;
  }

  bool get isLastPage {
    return _isLastPage;
  }

  List<NewsData> get searchNewsList {
    return [..._searchNewsList];
  }

  int get searchNextPage {
    return _searchNextPage;
  }

  bool get isLastSearchPage {
    return _isLastSearchPage;
  }

  List<NewsData> get bookmarkedNewsList {
    return [..._bookmarkedNewsList];
  }

  List<NewsAPIData> get newAPIsList {
    return [..._newsAPIList];
  }

  List<NewsAPIData> get searchNewsAPIList {
    return [..._searchNewsAPIList];
  }

  List<NewsAPIData> get bookmarkedNewsAPIList {
    return [..._bookmarkedNewsAPIList];
  }

  bool get isNewsAPILang {
    return newsAPILangs.contains(currentLang);
  }

  void clearNews() {
    _newsList.clear();
    _newsAPIList.clear();
    _totalNews = 0;
    _nextPage = 0;
  }

  Future<void> didCloseFiltersDrawer() async {
    if (filtersSelected.isNotEmpty ||
        (filtersSelected.isEmpty && _isFilterSelected)) {
      _newsList.clear();
      _newsAPIList.clear();
      _totalNews = 0;
      _nextPage = 0;
      filtersSelected.isEmpty
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
      currentLang = prefs.getString('language') ?? '';
      currentCountry = prefs.getString('country') ?? '';
    }
    if (_newsList.length <= _totalNews) {
      for (var i = 0; i < 2; i++) {
        await fetchNewsPage(currentLang ?? 'en', currentCountry ?? 'all');
        _nextPage += 1;
      }
      isLoadingNews = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> fetchNewsPage(String language, String country) async {
    final Uri url = Uri.parse(country == 'all'
        ? (_isFilterSelected
            ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=$nextPage&category=' +
                filtersSelected.join(',')
            : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=$nextPage&category=top')
        : (_isFilterSelected
            ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=$nextPage&category=' +
                filtersSelected.join(',')
            : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=$nextPage&category=top'));
    print(url);
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      print('Success getting');
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsResponse.fromJson(decoded);
      _totalNews = initialNewsResponse.totalResults ?? 0;
      if (initialNewsResponse.nextPage == null) {
        _isLastPage = true;
      }
      print('Will add news');
      _newsList.addAll(initialNewsResponse.results!
          .map((i) => NewsData.fromJson(i))
          .toList());
    }
  }

  Future<List<NewsData?>?> fetchSearchNews(String query) async {
    if (_searchNewsList.length <= _searchTotalNews) {
      for (var i = 0; i < 2; i++) {
        await fetchSearchNewsPage(
            currentLang ?? 'en', currentCountry ?? 'all', query);
        _searchNextPage += 1;
      }
      notifyListeners();
      print('Will return');
      return _searchNewsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> fetchSearchNewsPage(
      String language, String country, String query) async {
    final String urlString = country == 'all'
        ? 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&page=$_searchNextPage&qInTitle=$query'
        : 'https://newsdata.io/api/1/news?apikey=$apiKeyNewsData&language=$language&country=$country&page=$_searchNextPage&qInTitle=$query';
    final response = await http.get(Uri.parse(urlString));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final initialNewsResponse = NewsResponse.fromJson(decoded);
      _searchTotalNews = initialNewsResponse.totalResults ?? 0;
      if (initialNewsResponse.nextPage == null) {
        _isLastSearchPage = true;
      }
      _searchNewsList.addAll(initialNewsResponse.results!
          .map((i) => NewsData.fromJson(i))
          .toList());
    }
  }

  void clearSearchNewsList() {
    _searchNewsList.clear();
    _searchTotalNews = 0;
    _searchNextPage = 0;
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
    currentCountry = 'all';
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
