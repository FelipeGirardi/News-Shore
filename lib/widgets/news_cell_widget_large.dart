import 'package:flutter/material.dart';

import '/models/news_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCellWidgetLarge extends StatelessWidget {
  const NewsCellWidgetLarge({Key? key, this.ctx, this.newsData})
      : super(key: key);
  final BuildContext? ctx;
  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              flex: 1,
              child: ImageWidgetLarge(
                  imageUrl: newsData?.imageUrl != null
                      ? newsData!.imageUrl!
                      : 'https://leads-international.com/assets/front/img/placeholder-news.jpg')),
          Flexible(
              flex: 3, child: TitleAndSourceWidgetLarge(newsData: newsData)),
          const SizedBox(height: 10)
        ]);
  }
}

class TitleAndSourceWidgetLarge extends StatelessWidget {
  const TitleAndSourceWidgetLarge({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 248, 12, 95),
          )),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              AutoSizeText(newsData?.title ?? '',
                  minFontSize: 18,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              AutoSizeText(newsData?.description ?? '',
                  minFontSize: 14,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis),
              const Spacer(),
              const Spacer(),
              Text(newsData?.sourceId ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidgetLarge extends StatelessWidget {
  const ImageWidgetLarge({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
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
    );
  }
}
