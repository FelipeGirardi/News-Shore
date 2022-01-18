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
  int _nextPage = 1;
  List<String> filtersSelected = [];
  bool _isFilterSelected = false;
  bool isLoadingNews = false;

  List<NewsData> get newsList {
    return [..._newsList];
  }

  int get totalNews {
    return _totalNews;
  }

  int get nextPage {
    return _nextPage;
  }

  Future<void> didCloseFiltersDrawer() async {
    if (filtersSelected.isNotEmpty ||
        (filtersSelected.isEmpty && _isFilterSelected)) {
      _newsList.clear();
      _totalNews = 0;
      _nextPage = 1;
      filtersSelected.isEmpty
          ? _isFilterSelected = false
          : _isFilterSelected = true;
      isLoadingNews = true;
      notifyListeners();
      await fetchNewsPage();
    }
  }

  Future<void> fetchNewsPage() async {
    if (newsList.length <= totalNews) {
      final String urlString = _isFilterSelected
          ? 'https://newsdata.io/api/1/news?apikey=$apiKey&language=en&page=$nextPage&category=' +
              filtersSelected.join(',')
          : 'https://newsdata.io/api/1/news?apikey=$apiKey&language=en&page=$nextPage';
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final initialNewsResponse = NewsResponse.fromJson(decoded);
        _totalNews = initialNewsResponse.totalResults ?? 0;
        _nextPage = initialNewsResponse.nextPage ?? 0;
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
}
