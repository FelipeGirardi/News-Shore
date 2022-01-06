import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/models/news_data.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;

  const NewsCellWidgetSmall({Key? key, this.ctx, this.newsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            color: Color.fromARGB(255, 248, 12, 95),
            width: 1,
          ),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: newsData?.imageUrl != null
              ? [
                  TitleAndSourceWidgetSmall(newsData: newsData),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      child: Image.network(newsData!.imageUrl!,
                          fit: BoxFit.cover, height: 100),
                    ),
                  )
                ]
              : [
                  TitleAndSourceWidgetSmall(newsData: newsData),
                ],
        ),
      ),
    );
  }
}

class TitleAndSourceWidgetSmall extends StatelessWidget {
  const TitleAndSourceWidgetSmall({
    Key? key,
    required this.newsData,
  }) : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Expanded(
                child: AutoSizeText(newsData?.title ?? '',
                    minFontSize: 15,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Text(newsData?.sourceId ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
