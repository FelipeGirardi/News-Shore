import 'package:flutter/material.dart';

import '/models/news_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  const NewsCellWidgetSmall({Key? key, this.ctx, this.newsData, this.index})
      : super(key: key);
  final BuildContext? ctx;
  final NewsData? newsData;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        elevation: 3,
        margin: index! % 2 == 0
            ? const EdgeInsets.fromLTRB(12, 8, 8, 8)
            : const EdgeInsets.fromLTRB(8, 8, 12, 8),
        color: Theme.of(context).colorScheme.background,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(flex: 4, child: ImageWidgetSmall(newsData: newsData)),
              Expanded(
                  flex: 6, child: TitleAndSourceWidgetSmall(newsData: newsData))
            ]));
  }
}

class TitleAndSourceWidgetSmall extends StatelessWidget {
  const TitleAndSourceWidgetSmall({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 5, 7, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoSizeText(newsData?.title ?? '',
              presetFontSizes: const [13],
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, height: 1.3)),
          const Spacer(),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.library_books,
                size: 11,
              ),
              const SizedBox(width: 10),
              AutoSizeText(
                newsData?.sourceId ?? '',
                presetFontSizes: const [11],
              ),
              const Spacer(),
              InkWell(
                child: const Icon(Icons.bookmark_border, size: 24),
                onTap: () {},
              ),
            ],
          ),
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
      child: Hero(
        tag: newsData!.id!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
          image: newsData!.imageUrl != null
              ? (newsData!.imageUrl!
                          .substring(newsData!.imageUrl!.length - 3) !=
                      'mp4'
                  ? NetworkImage(newsData!.imageUrl!)
                  : const AssetImage('assets/images/newsshore_logo.jpg')
                      as ImageProvider)
              : const AssetImage('assets/images/newsshore_logo.jpg'),
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
