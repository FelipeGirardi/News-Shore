import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/news_data.dart';
import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';
import '/widgets/loading_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  Future<List<NewsData?>?>? _newsProvider;
  final scrollController = ScrollController();
  bool _isLoadingPage = false;
  bool _willFetchNewsPage = false;

  Future<List<NewsData?>?>? _setNewsProvider() async {
    return await Provider.of<NewsProvider>(context, listen: false)
        .fetchSearchNews(widget.query);
  }

  @override
  void initState() {
    _newsProvider = _setNewsProvider();
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void pagination() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_willFetchNewsPage &&
        provider.searchNewsList.length < 100 &&
        !provider.isLastSearchPage) {
      _willFetchNewsPage = true;
      setState(() {
        _isLoadingPage = true;
      });
      await Provider.of<NewsProvider>(context, listen: false)
          .fetchSearchNews(widget.query);
      setState(() {
        _isLoadingPage = false;
      });
      _willFetchNewsPage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: FutureBuilder(
              future: _newsProvider,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'News could not be loaded.',
                      style: TextStyle(fontSize: 28),
                    ),
                  );
                } else {
                  return NewsResultWidget(
                      scrollController: scrollController,
                      willFetchNewsPage: _willFetchNewsPage,
                      newsData: snapshot.data as List<NewsData>);
                }
              }),
        ),
        Center(
            child: _isLoadingPage
                ? const LoadingWidget()
                : const SizedBox(
                    height: 0,
                  )),
      ],
    );
  }
}

class NewsResultWidget extends StatelessWidget {
  const NewsResultWidget({
    Key? key,
    required this.scrollController,
    required bool willFetchNewsPage,
    required this.newsData,
  })  : _willFetchNewsPage = willFetchNewsPage,
        super(key: key);

  final ScrollController scrollController;
  final bool _willFetchNewsPage;
  final List<NewsData> newsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          physics: _willFetchNewsPage
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
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
