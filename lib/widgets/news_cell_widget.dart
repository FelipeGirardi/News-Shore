import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import '/models/news_detail_arguments.dart';
import '/screens/news_detail_screen.dart';
import '/widgets/news_cell_widget_large.dart';
import '/widgets/news_cell_widget_medium.dart';
import '/widgets/news_cell_widget_small.dart';

class NewsCellWidget extends StatelessWidget {
  const NewsCellWidget(
      {Key? key, this.ctx, this.cellType, this.index, this.newsData})
      : super(key: key);
  final BuildContext? ctx;
  final int? cellType;
  final int? index;
  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    bool _checkBookmark() {
      return Provider.of<NewsProvider>(context, listen: false)
          .bookmarkedNewsList
          .any((item) => item.id == newsData!.id);
    }

    void _addBookmark() {
      Provider.of<NewsProvider>(context, listen: false).addBookmark(newsData!);
    }

    void _removeBookmark() {
      Provider.of<NewsProvider>(context, listen: false)
          .removeBookmark(newsData!);
    }

    return InkWell(
        onTap: () {
          final NewsDetailArguments args = NewsDetailArguments(
              newsData!, _checkBookmark, _addBookmark, _removeBookmark);
          Navigator.of(context).pushNamed(
            NewsDetailScreen.routeName,
            arguments: args,
          );
        },
        child: cellType! % 3 == 0
            ? NewsCellWidgetLarge(
                key: key,
                ctx: ctx,
                newsData: newsData,
                checkBookmarkFunc: _checkBookmark,
                addBookmarkFunc: _addBookmark,
                removeBookmarkFunc: _removeBookmark,
              )
            : (cellType! - 1) % 3 == 0
                ? NewsCellWidgetMedium(
                    key: key,
                    ctx: ctx,
                    newsData: newsData,
                    index: index,
                    checkBookmarkFunc: _checkBookmark,
                    addBookmarkFunc: _addBookmark,
                    removeBookmarkFunc: _removeBookmark,
                  )
                : NewsCellWidgetSmall(
                    key: key,
                    ctx: ctx,
                    newsData: newsData,
                    index: index,
                    checkBookmarkFunc: _checkBookmark,
                    addBookmarkFunc: _addBookmark,
                    removeBookmarkFunc: _removeBookmark,
                  ));
  }
}
