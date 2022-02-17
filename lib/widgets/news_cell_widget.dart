import 'package:flutter/material.dart';

import '/models/news_data.dart';
import '/screens/news_detail_screen.dart';
import '/widgets/news_cell_widget_large.dart';
import '/widgets/news_cell_widget_medium.dart';
import '/widgets/news_cell_widget_small.dart';
import '/models/news_detail_arguments.dart';

class NewsCellWidget extends StatelessWidget {
  const NewsCellWidget(
      {Key? key,
      this.ctx,
      this.cellType,
      this.index,
      this.newsData,
      this.isBookmarked})
      : super(key: key);
  final BuildContext? ctx;
  final int? cellType;
  final int? index;
  final NewsData? newsData;
  final bool? isBookmarked;

  @override
  Widget build(BuildContext context) {
    final String? bookmarkHeroTag =
        isBookmarked ?? false ? index!.toString() : null;
    final NewsDetailArguments newsDetailArguments = NewsDetailArguments(
        newsData!, isBookmarked ?? false, bookmarkHeroTag ?? '');
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            NewsDetailScreen.routeName,
            arguments: newsDetailArguments,
          );
        },
        child: cellType! % 3 == 0
            ? NewsCellWidgetLarge(
                key: key,
                ctx: ctx,
                newsData: newsData,
              )
            : (cellType! - 1) % 3 == 0
                ? NewsCellWidgetMedium(
                    key: key,
                    ctx: ctx,
                    newsData: newsData,
                    index: index,
                    isBookmarked: isBookmarked ?? false,
                    bookmarkHeroTag: bookmarkHeroTag ?? '',
                  )
                : NewsCellWidgetSmall(
                    key: key,
                    ctx: ctx,
                    newsData: newsData,
                    index: index,
                  ));
  }
}
