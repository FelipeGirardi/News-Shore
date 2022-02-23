import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';
import '/widgets/loading_widget.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);
  static const routeName = '/bookmarks-screen';

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  Future<void>? _newsProvider;

  Future<void>? _setNewsProvider() async {
    return await Provider.of<NewsProvider>(context, listen: false)
        .fetchBookmarks();
  }

  @override
  void initState() {
    _newsProvider = _setNewsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _newsProvider,
      builder: (context, snapshot) => Consumer<NewsProvider>(
        builder: (ctx, newsProv, child) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const LoadingWidget()
                : snapshot.hasError
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.couldNotLoad,
                          style: const TextStyle(fontSize: 28),
                        ),
                      )
                    : newsProv.bookmarkedNewsList.isEmpty
                        ? child!
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: newsProv.bookmarkedNewsList.length,
                                itemBuilder: (ctx, i) => NewsCellWidget(
                                    key: UniqueKey(),
                                    ctx: ctx,
                                    cellType: 1,
                                    index: 0,
                                    newsData: newsProv.bookmarkedNewsList[i],
                                    isBookmarked: true)),
                          ),
        child: const NoBookmarksWidget(),
      ),
    );
  }
}

class NoBookmarksWidget extends StatelessWidget {
  const NoBookmarksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            AppLocalizations.of(context)!.noBookmarks,
            presetFontSizes: const [18, 16, 14],
            maxLines: 2,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeText(
                  AppLocalizations.of(context)!.howToBookmark,
                  presetFontSizes: const [18, 16, 14],
                  maxLines: 1,
                ),
              ),
              const Icon(
                Icons.bookmark_border,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
