import 'package:flutter/material.dart';

import '/models/news_data.dart';
import '/widgets/news_cell_widget_large.dart';
import '/screens/news_detail_screen.dart';

class NewsCellWidget extends StatelessWidget {
  const NewsCellWidget({Key? key, this.ctx, this.newsData}) : super(key: key);
  final BuildContext? ctx;
  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            NewsDetailScreen.routeName,
            arguments: newsData,
          );
        },
        child: NewsCellWidgetLarge(
          key: key,
          ctx: ctx,
          newsData: newsData,
        ));
  }
}
