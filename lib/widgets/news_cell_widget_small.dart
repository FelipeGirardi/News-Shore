import 'package:flutter/material.dart';

import '/models/news_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  const NewsCellWidgetSmall({Key? key, this.ctx, this.newsData})
      : super(key: key);
  final BuildContext? ctx;
  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(
          color: Color.fromARGB(255, 248, 12, 95),
          width: 1,
        ),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: newsData?.imageUrl != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  Expanded(
                      flex: 4, child: ImageWidgetSmall(newsData: newsData)),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 248, 12, 95),
                  ),
                  Expanded(
                      flex: 6,
                      child: TitleAndSourceWidgetSmall(
                          newsData: newsData, maxLinesTitle: 4))
                ])
          : TitleAndSourceWidgetSmall(newsData: newsData, maxLinesTitle: 6),
    );
  }
}

class TitleAndSourceWidgetSmall extends StatelessWidget {
  const TitleAndSourceWidgetSmall(
      {Key? key, required this.newsData, required this.maxLinesTitle})
      : super(key: key);

  final NewsData? newsData;
  final int? maxLinesTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          AutoSizeText(newsData?.title ?? '',
              minFontSize: 14,
              maxLines: maxLinesTitle,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          const Spacer(),
          const Spacer(),
          Text(newsData?.sourceId ?? '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              )),
        ],
      ),
    );
  }
}

class ImageWidgetSmall extends StatelessWidget {
  const ImageWidgetSmall({
    Key? key,
    required this.newsData,
  }) : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: Image.network(
        newsData!.imageUrl!,
        fit: BoxFit.cover,
        width: 200,
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
    );
  }
}
