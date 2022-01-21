import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/screens/search_results_screen.dart';

class NewsSearch extends SearchDelegate<String> {
  final news = ['Covid', 'Vaccine', 'Europe', 'USA', 'Asia'];
  final recentNews = ['Covid', 'Vaccine', 'Europe', 'USA', 'Asia'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            Provider.of<NewsProvider>(context, listen: false)
                .clearSearchNewsList();
            if (query.isEmpty) {
              close(context, '');
            }
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Provider.of<NewsProvider>(context, listen: false)
              .clearSearchNewsList();
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsScreen(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentNews
        : news.where((news) {
            final newsLowercase = news.toLowerCase();
            final queryLowercase = query.toLowerCase();
            return newsLowercase.startsWith(queryLowercase);
          }).toList();
    return buildSearchSuggestions(suggestions);
  }

  Widget buildSearchSuggestions(List<String> suggestions) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);
          return ListTile(
            leading: const Icon(Icons.search),
            title: RichText(
              text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: remainingText,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal))
                  ]),
            ),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}
