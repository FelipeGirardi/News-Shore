import 'package:flutter/material.dart';

import '/providers/mock_news.dart';
import '/widgets/news_cell_widget_small.dart';
import '/widgets/news_cell_widget_medium.dart';
import '/widgets/news_cell_widget_large.dart';

class MockMainFeedScreen extends StatefulWidget {
  const MockMainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MockMainFeedScreen> createState() => _MockMainFeedScreenState();
}

class _MockMainFeedScreenState extends State<MockMainFeedScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: MOCK_NEWS.length,
            itemBuilder: (ctx, i) => NewsCellWidgetLarge(
                key: UniqueKey(), ctx: ctx, newsData: MOCK_NEWS[i])),
      )
    ]);
  }
}
