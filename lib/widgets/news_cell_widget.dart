import 'package:flutter/material.dart';
import 'dart:developer';

import '/models/news_data.dart';
import '/screens/news_detail_screen.dart';
import '/widgets/news_cell_widget_large.dart';
import '/widgets/news_cell_widget_medium.dart';
import '/widgets/news_cell_widget_small.dart';

class NewsCellWidget extends StatelessWidget {
  const NewsCellWidget(
      {Key? key,
      this.ctx,
      this.cellType,
      this.index,
      this.newsList,
      this.newsData})
      : super(key: key);
  final BuildContext? ctx;
  final int? cellType;
  final int? index;
  final List<NewsData>? newsList;
  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(newsData!.title);
          print(cellType);
          print(index);
          inspect(newsList);
          Navigator.of(context).pushNamed(
            NewsDetailScreen.routeName,
            arguments: newsData,
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
                    key: key, ctx: ctx, newsData: newsData, index: index)
                : NewsCellWidgetSmall(
                    key: key, ctx: ctx, newsData: newsData, index: index));
  }
}
