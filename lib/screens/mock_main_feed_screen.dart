import 'package:flutter/material.dart';

import '/providers/mock_news.dart';
import '/widgets/news_cell_widget_small.dart';
import '/widgets/news_cell_widget_medium.dart';

class MockMainFeedScreen extends StatefulWidget {
  const MockMainFeedScreen({Key? key}) : super(key: key);

  @override
  State<MockMainFeedScreen> createState() => _MockMainFeedScreenState();
}

class _MockMainFeedScreenState extends State<MockMainFeedScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('NewsShell')),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                controller: scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: MOCK_NEWS.length,
                itemBuilder: (ctx, i) => NewsCellWidgetSmall(
                    key: UniqueKey(), ctx: ctx, newsData: MOCK_NEWS[i])),
          )
        ]));
  }
}
