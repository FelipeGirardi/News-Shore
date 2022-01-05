import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget_small.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  Future<void>? _newsProvider;
  final scrollController = ScrollController();
  bool _isLoadingPage = false;
  bool _willFetchNewsPage = false;

  @override
  void initState() {
    _newsProvider =
        Provider.of<NewsProvider>(context, listen: false).fetchNewsPage();
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void pagination() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_willFetchNewsPage) {
      _willFetchNewsPage = true;
      setState(() {
        _isLoadingPage = true;
      });
      await Provider.of<NewsProvider>(context, listen: false).fetchNewsPage();
      setState(() {
        _isLoadingPage = false;
      });
      _willFetchNewsPage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NewsShell')),
      body: Column(children: [
        Expanded(
          child: Scrollbar(
              child: FutureBuilder(
            future: _newsProvider,
            builder: (ctx, snapshot) => Consumer<NewsProvider>(
                builder: (ctx, newsProv, _) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            controller: scrollController,
                            physics: _willFetchNewsPage
                                ? const NeverScrollableScrollPhysics()
                                : const AlwaysScrollableScrollPhysics(),
                            itemCount: newsProv.newsList.length,
                            itemBuilder: (ctx, i) => NewsCellWidgetSmall(
                                key: UniqueKey(),
                                ctx: ctx,
                                newsData: newsProv.newsList[i]))),
          )),
        ),
        const SizedBox(),
        Center(
            child: _isLoadingPage
                ? const CircularProgressIndicator()
                : const SizedBox(
                    height: 0,
                  )),
      ]),
    );
  }
}
