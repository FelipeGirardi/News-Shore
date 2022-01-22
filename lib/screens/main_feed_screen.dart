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

  Future<void> _setNewsProvider() async {
    return await Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsPage();
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
        provider.newsList.length < 100 &&
        !provider.isLastPage) {
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
        child: FutureBuilder(
          future: _newsProvider,
          builder: (ctx, snapshot) => Consumer<NewsProvider>(
              builder: (ctx, newsProv, _) => snapshot.connectionState ==
                          ConnectionState.waiting ||
                      newsProv.isLoadingNews
                  ? const Center(child: CircularProgressIndicator())
                  : newsProv.newsList.isEmpty || snapshot.hasError
                      ? const Center(
                          child: Text('No news currently available.'))
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
                                  newsData:
                                      newsProv.newsList[10 * cellType ~/ 3])
                              : (cellType - 1) % 3 == 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (ctx, i) => NewsCellWidget(
                                          key: UniqueKey(),
                                          ctx: ctx,
                                          cellType: cellType,
                                          index: i,
                                          newsData: newsProv.newsList[
                                              (cellType ~/ 3) * 10 + i + 1]))
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
                                            itemBuilder: (ctx, i) =>
                                                NewsCellWidget(
                                                    key: UniqueKey(),
                                                    ctx: ctx,
                                                    cellType: cellType,
                                                    index: i,
                                                    newsData: newsProv.newsList[
                                                        (cellType ~/ 3) * 10 +
                                                            i +
                                                            4])),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                        )),
        ),
      ),
      Center(
          child: _isLoadingPage
              ? const CircularProgressIndicator()
              : const SizedBox(
                  height: 0,
                )),
    ]);
  }
}
