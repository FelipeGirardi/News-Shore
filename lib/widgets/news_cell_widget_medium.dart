import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/models/news_data.dart';

class NewsCellWidgetMedium extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final int? index;

  const NewsCellWidgetMedium({Key? key, this.ctx, this.newsData, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: newsData?.imageUrl != null
                    ? [
                        TitleAndSourceWidgetMedium(
                            newsData: newsData,
                            cellHeight: 120,
                            maxLinesTitle: 2),
                        ImageWidgetMedium(newsData: newsData)
                      ]
                    : [
                        TitleAndSourceWidgetMedium(
                            newsData: newsData,
                            cellHeight: 120,
                            maxLinesTitle: 2),
                      ],
              ),
              const SizedBox(height: 10),
              if (index != 2)
                Column(
                  children: [
                    Divider(
                        height: 3,
                        thickness: 2,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 10),
                  ],
                ),
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
                minFontSize: 12, maxLines: 3, overflow: TextOverflow.ellipsis),
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
      child: Hero(
        tag: UniqueKey(),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/placeholder_news.jpg'),
          image: NetworkImage(newsData!.imageUrl!),
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
//