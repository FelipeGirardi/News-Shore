import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';

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

  void _setNewsProvider() async {
    _newsProvider =
        Provider.of<NewsProvider>(context, listen: false).fetchNewsPage();
  }

  @override
  void initState() {
    _setNewsProvider();
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
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: Scrollbar(
            child: FutureBuilder(
          future: _newsProvider,
          builder: (ctx, snapshot) => Consumer<NewsProvider>(
              builder: (ctx, newsProv, _) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      physics: _willFetchNewsPage
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: 3 * (newsProv.nextPage - 1),
                      itemBuilder: (ctx, cellType) => cellType % 3 == 0
                          ? NewsCellWidget(
                              key: UniqueKey(),
                              ctx: ctx,
                              cellType: cellType,
                              index: 0,
                              newsList: newsProv.newsList,
                              newsData: newsProv
                                  .newsList[10 * cellType ~/ 3])
                          : (cellType - 1) % 3 == 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (ctx, i) => NewsCellWidget(
                                      key: UniqueKey(),
                                      ctx: ctx,
                                      cellType: cellType,
                                      index: i,
                                      newsList: newsProv.newsList,
                                      newsData: newsProv.newsList[
                                          (cellType ~/ 3) * 10 + i + 1]))
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 6,
                                  itemBuilder: (ctx, i) => NewsCellWidget(
                                      key: UniqueKey(),
                                      ctx: ctx,
                                      cellType: cellType,
                                      index: i,
                                      newsList: newsProv.newsList,
                                      newsData: newsProv.newsList[
                                          (cellType ~/ 3) * 10 + i + 4])),
                    )),
        )),
      ),
      const SizedBox(),
      Center(
          child: _isLoadingPage
              ? const CircularProgressIndicator()
              : const SizedBox(
                  height: 0,
                )),
    ]);
  }
}
