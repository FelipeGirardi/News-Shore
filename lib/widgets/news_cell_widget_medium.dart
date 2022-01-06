import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/models/news_data.dart';

class NewsCellWidgetMedium extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;

  const NewsCellWidgetMedium({Key? key, this.ctx, this.newsData})
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
                  TitleAndSourceWidgetMedium(
                      newsData: newsData, cellHeight: 100, maxLinesTitle: 3),
                  const SizedBox(width: 5),
                  ImageWidgetMedium(newsData: newsData)
                ]
              : [
                  TitleAndSourceWidgetMedium(
                      newsData: newsData, cellHeight: 80, maxLinesTitle: 2),
                ],
        ),
      ),
    );
  }
}

class TitleAndSourceWidgetMedium extends StatelessWidget {
  const TitleAndSourceWidgetMedium(
      {Key? key,
      required this.newsData,
      required this.cellHeight,
      required this.maxLinesTitle})
      : super(key: key);

  final NewsData? newsData;
  final double? cellHeight;
  final int? maxLinesTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: cellHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
              child: AutoSizeText(newsData?.title ?? '',
                  minFontSize: 16,
                  maxLines: maxLinesTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 0, 7),
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

class ImageWidgetMedium extends StatelessWidget {
  const ImageWidgetMedium({
    Key? key,
    required this.newsData,
  }) : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.network(
          newsData!.imageUrl!,
          fit: BoxFit.cover,
          height: 100,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
