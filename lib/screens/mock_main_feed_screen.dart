import 'package:flutter/material.dart';

import '/providers/mock_news.dart';
import 'package:newsshell/widgets/news_cell_widget_small.dart';

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
            child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: MOCK_NEWS.length,
                itemBuilder: (ctx, i) => NewsCellWidgetSmall(
                    key: UniqueKey(), ctx: ctx, newsData: MOCK_NEWS[i])),
          )
        ]));
  }
}
