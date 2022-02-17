import 'package:flutter/material.dart';

import '/providers/mock_news.dart';
import '/widgets/news_cell_widget.dart';

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
          padding: const EdgeInsets.only(bottom: 12),
          itemCount: 3, // NO FEED REAL: 3 * (newsProv.nextPage - 1)
          itemBuilder: (ctx, cellType) => cellType % 3 == 0
              ? NewsCellWidget(
                  key: UniqueKey(),
                  ctx: ctx,
                  cellType: cellType,
                  index: 0,
                  newsData: MOCK_NEWS[0]) // NO FEED REAL: 10*cellType~/3
              : (cellType - 1) % 3 == 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (ctx, i) => NewsCellWidget(
                          key: UniqueKey(),
                          ctx: ctx,
                          cellType: cellType,
                          index: i,
                          newsData: MOCK_NEWS[i +
                              1])) // NO FEED REAL: (cellType~/3) * 10 + i + 1
                  : Column(
                      children: [
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 8 / 9),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (ctx, i) => NewsCellWidget(
                                key: UniqueKey(),
                                ctx: ctx,
                                cellType: cellType,
                                index: i,
                                newsData: MOCK_NEWS[i + 4])),
                        const SizedBox(height: 10),
                      ],
                    ), // NO FEED REAL: (cellType~/3) * 10 + i + 4
        ),
      )
    ]);
  }
}
