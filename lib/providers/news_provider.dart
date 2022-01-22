import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/models/news_response.dart';
import '/models/news_data.dart';

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
    if (_newsList.length <= _totalNews) {
      final String urlString = _isFilterSelected
          ? 'https://newsdata.io/api/1/news?apikey=$apiKey&language=en&page=$nextPage&category=' +
              filtersSelected.join(',')
          : 'https://newsdata.io/api/1/news?apikey=$apiKey&language=en&page=$nextPage&category=top';
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
        notifyListeners();
      } else {
        throw Exception('Failed to load news');
      }
    }
  }

  Future<List<NewsData?>?> fetchSearchNewsPage(String query) async {
    if (_searchNewsList.length <= _searchTotalNews) {
      final String urlString =
          'https://newsdata.io/api/1/news?apikey=$apiKey&language=en&page=$_searchNextPage&qInTitle=$query';
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
}
