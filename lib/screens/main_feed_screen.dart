import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';
import '/widgets/loading_widget.dart';
import '/helpers/ad_helper.dart';

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

  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  Future<void> _setNewsProvider() async {
    return await Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  Future<void> _refreshNews() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    provider.clearNews();
    await provider.fetchNews();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _newsProvider = _setNewsProvider();
    scrollController.addListener(pagination);

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          //print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _bannerAd.dispose();
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
      await provider.fetchNews();
      setState(() {
        _isLoadingPage = false;
      });
      _willFetchNewsPage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: FutureBuilder(
          future: _newsProvider,
          builder: (ctx, snapshot) => Consumer<NewsProvider>(
              builder: (ctx, newsProv, _) => snapshot.connectionState ==
                          ConnectionState.waiting ||
                      newsProv.isLoadingNews ||
                      newsProv.newsList.isEmpty ||
                      snapshot.hasError
                  ? FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 10000)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done)
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.couldNotLoad,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24),
                            ),
                          );
                        else
                          return LoadingWidget();
                      })
                  : RefreshIndicator(
                      onRefresh: _refreshNews,
                      child: ListView.builder(
                        controller: scrollController,
                        physics: _willFetchNewsPage
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 12),
                        itemCount: newsProv.shouldFetchNewsAPI
                            ? 4 * newsProv.nextPageNewsAPICounter
                            : 4 * newsProv.nextPageCounter,
                        itemBuilder: (ctx, cellType) => cellType % 4 == 0
                            ? NewsCellWidget(
                                key: UniqueKey(),
                                ctx: ctx,
                                cellType: cellType,
                                index: 0,
                                newsData: newsProv.newsList[10 * cellType ~/ 4])
                            : (cellType - 1) % 4 == 0
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
                                            ((cellType ~/ 4) * 10) + i + 1]))
                                : (cellType - 2) % 4 == 0
                                    ? Column(
                                        children: [
                                          GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          isMobile ? 2 : 3,
                                                      childAspectRatio: 8 / 9),
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
                                                      newsData:
                                                          newsProv.newsList[
                                                              ((cellType ~/ 4) *
                                                                      10) +
                                                                  i +
                                                                  4])),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : _isAdLoaded
                                        ? Column(
                                            children: [
                                              StatefulBuilder(
                                                builder: (context, setState) =>
                                                    Container(
                                                  child:
                                                      AdWidget(ad: _bannerAd),
                                                  width: _bannerAd.size.width
                                                      .toDouble(),
                                                  height: 72.0,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          )
                                        : Container(),
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
