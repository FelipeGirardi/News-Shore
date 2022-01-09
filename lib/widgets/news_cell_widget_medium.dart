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
            color: Color.fromARGB(255, 143, 226, 222),
            width: 2,
          ),
        ),
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: newsData?.imageUrl != null
                ? [
                    TitleAndSourceWidgetMedium(
                        newsData: newsData, cellHeight: 120, maxLinesTitle: 2),
                    ImageWidgetMedium(newsData: newsData)
                  ]
                : [
                    TitleAndSourceWidgetMedium(
                        newsData: newsData, cellHeight: 120, maxLinesTitle: 2),
                  ],
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              AutoSizeText(newsData?.title ?? '',
                  minFontSize: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              AutoSizeText(newsData?.description ?? '',
                  minFontSize: 12,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              const Spacer(),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.library_books,
                    size: 12,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 10),
                  AutoSizeText(newsData?.sourceId ?? '',
                      //textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      )),
                ],
              ),
            ],
          ),
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
          height: 120,
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
