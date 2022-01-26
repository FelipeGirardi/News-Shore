import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/widgets/news_cell_widget.dart';
import '/widgets/custom_app_bar.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bookmarks',
        showSearchIcon: false,
      ),
      body: FutureBuilder(
        future: _newsProvider,
        builder: (context, snapshot) => Consumer<NewsProvider>(
            builder: (ctx, newsProv, _) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : snapshot.hasError
                        ? Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'News could not be loaded.',
                              style: TextStyle(fontSize: 28),
                            ),
                          )
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
                                    newsData: newsProv.bookmarkedNewsList[i])),
                          )),
      ),
    );
  }
}
