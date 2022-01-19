import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/news_data.dart';
import '/models/news_response.dart';
import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';

class NewsSearch extends SearchDelegate<String> {
  final news = ['Covid', 'Vaccine', 'Europe', 'USA', 'Asia'];
  final recentNews = ['Covid', 'Vaccine', 'Europe', 'USA', 'Asia'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
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
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsProvider>(context, listen: false)
            .fetchSearchNewsPage(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: const Text(
                'News could not be loaded.',
                style: TextStyle(fontSize: 28),
              ),
            );
          } else {
            final NewsResponse response = snapshot.data as NewsResponse;
            final List<NewsData> newsData =
                response.results!.map((res) => NewsData.fromJson(res)).toList();
            return buildNewsResult(newsData);
          }
        });
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

  Widget buildNewsResult(List<NewsData> newsData) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: newsData.length,
          itemBuilder: (ctx, i) => NewsCellWidget(
              key: UniqueKey(),
              ctx: ctx,
              cellType: 1,
              index: 0,
              newsData: newsData[i])),
    );
  }
}
