import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

import '/models/news_response.dart';
import '/models/news_data.dart';
import '/helpers/sql_helper.dart';

String apiKey = "pub_3162ee115d2cfdf10b4bb42c76aca12b66fd";

class NewsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<NewsData> _newsList = [];
  int _totalNews = 0;
  int _nextPage = 0;
  bool _isLastPage = false;
  List<String> filtersSelected = [];
  bool _isFilterSelected = false;
  bool isLoadingNews = false;
  // ignore: prefer_final_fields
  List<NewsData> _searchNewsList = [];
  int _searchTotalNews = 0;
  int _searchNextPage = 0;
  bool _isLastSearchPage = false;
  // ignore: prefer_final_fields
  List<NewsData> _bookmarkedNewsList = [];
  String? currentLang;
  String? currentCountry;

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

  void clearNews() {
    _newsList.clear();
    _totalNews = 0;
    _nextPage = 0;
  }

  Future<void> didCloseFiltersDrawer() async {
    if (filtersSelected.isNotEmpty ||
        (filtersSelected.isEmpty && _isFilterSelected)) {
      _newsList.clear();
      _totalNews = 0;
      _nextPage = 0;
      filtersSelected.isEmpty
          ? _isFilterSelected = false
          : _isFilterSelected = true;
      isLoadingNews = true;
      notifyListeners();
      await fetchNewsPage();
    }
  }

  Future<void> fetchNewsPage() async {
    print('Is fetching');
    final prefs = await SharedPreferences.getInstance();
    final String language = prefs.getString('language') ?? '';
    final String country = prefs.getString('country') ?? '';
    if (_newsList.length <= _totalNews) {
      final String urlString = country == 'all'
          ? (_isFilterSelected
              ? 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&page=$nextPage&category=' +
                  filtersSelected.join(',')
              : 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&page=$nextPage&category=top')
          : (_isFilterSelected
              ? 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&country=$country&page=$nextPage&category=' +
                  filtersSelected.join(',')
              : 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&country=$country&page=$nextPage&category=top');
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final initialNewsResponse = NewsResponse.fromJson(decoded);
        _totalNews = initialNewsResponse.totalResults ?? 0;
        if (initialNewsResponse.nextPage == null) {
          _isLastPage = true;
        }
        _nextPage = initialNewsResponse.nextPage ?? _nextPage;
        _newsList.addAll(initialNewsResponse.results!
            .map((i) => NewsData.fromJson(i))
            .toList());
        isLoadingNews = false;
        inspect(_newsList);
        notifyListeners();
      } else {
        throw Exception('Failed to load news');
      }
    }
  }

  Future<List<NewsData?>?> fetchSearchNewsPage(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final String language = prefs.getString('language') ?? '';
    final String country = prefs.getString('country') ?? '';
    if (_searchNewsList.length <= _searchTotalNews) {
      final String urlString = country == 'all'
          ? 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&page=$_searchNextPage&qInTitle=$query'
          : 'https://newsdata.io/api/1/news?apikey=$apiKey&language=$language&country=$country&page=$_searchNextPage&qInTitle=$query';
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final initialNewsResponse = NewsResponse.fromJson(decoded);
        _searchTotalNews = initialNewsResponse.totalResults ?? 0;
        if (initialNewsResponse.nextPage == null) {
          _isLastSearchPage = true;
        }
        _searchNextPage = initialNewsResponse.nextPage ?? _searchNextPage;
        _searchNewsList.addAll(initialNewsResponse.results!
            .map((i) => NewsData.fromJson(i))
            .toList());
        notifyListeners();
        return _searchNewsList;
      } else {
        throw Exception('Failed to load news');
      }
    }
    return null;
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

  void setLanguagePref(SharedPreferences prefs, String langName) {
    prefs.setString('language', langName);
    prefs.setString('country', 'all');
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
