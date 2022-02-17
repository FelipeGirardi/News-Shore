import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';
import '/widgets/loading_widget.dart';

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

  Future<void> _setNewsProvider() async {
    return await Provider.of<NewsProvider>(context, listen: false).fetchNews();
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
        ((!provider.isNewsAPILang && provider.newsList.length < 100) ||
            (provider.isNewsAPILang && provider.newsAPIList.length < 100)) &&
        !provider.isLastPage) {
      _willFetchNewsPage = true;
      setState(() {
        _isLoadingPage = true;
      });
      await provider.fetchNews();
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
        child: FutureBuilder(
          future: _newsProvider,
          builder: (ctx, snapshot) => Consumer<NewsProvider>(
              builder: (ctx, newsProv, _) => snapshot.connectionState ==
                          ConnectionState.waiting ||
                      newsProv.isLoadingNews ||
                      ((!newsProv.isNewsAPILang && newsProv.newsList.isEmpty) ||
                          (newsProv.isNewsAPILang &&
                              newsProv.newsAPIList.isEmpty)) ||
                      snapshot.hasError
                  ? const LoadingWidget()
                  : ListView.builder(
                      controller: scrollController,
                      physics: _willFetchNewsPage
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: 3 * newsProv.nextPage,
                      itemBuilder: (ctx, cellType) => cellType % 3 == 0
                          ? NewsCellWidget(
                              key: UniqueKey(),
                              ctx: ctx,
                              cellType: cellType,
                              index: 0,
                              newsData: !newsProv.isNewsAPILang
                                  ? newsProv.newsList[10 * cellType ~/ 3]
                                  : null,
                              newsAPIData: newsProv.isNewsAPILang
                                  ? newsProv.newsAPIList[10 * cellType ~/ 3]
                                  : null)
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
                                        newsData: !newsProv.isNewsAPILang
                                            ? newsProv.newsList[
                                                (cellType ~/ 3) * 10 + i + 1]
                                            : null,
                                        newsAPIData: newsProv.isNewsAPILang
                                            ? newsProv.newsAPIList[
                                                (cellType ~/ 3) * 10 + i + 1]
                                            : null,
                                      ))
                              : Column(
                                  children: [
                                    GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 6,
                                        itemBuilder: (ctx, i) => NewsCellWidget(
                                              key: UniqueKey(),
                                              ctx: ctx,
                                              cellType: cellType,
                                              index: i,
                                              newsData: !newsProv.isNewsAPILang
                                                  ? newsProv.newsList[
                                                      (cellType ~/ 3) * 10 +
                                                          i +
                                                          4]
                                                  : null,
                                              newsAPIData:
                                                  newsProv.isNewsAPILang
                                                      ? newsProv.newsAPIList[
                                                          (cellType ~/ 3) * 10 +
                                                              i +
                                                              4]
                                                      : null,
                                            )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                    )),
        ),
      ),
      Center(
          child: _isLoadingPage
              ? const LoadingWidget()
              : const SizedBox(
                  height: 0,
                )),
    ]);
  }
}
