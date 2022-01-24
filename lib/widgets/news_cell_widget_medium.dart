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
                children: [
                  TitleAndSourceWidgetMedium(newsData: newsData),
                  const SizedBox(
                    width: 5,
                  ),
                  ImageWidgetMedium(newsData: newsData)
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
  const TitleAndSourceWidgetMedium({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AutoSizeText(newsData?.title ?? '',
                presetFontSizes: const [15],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                )),
            const Spacer(),
            AutoSizeText(
              newsData?.description ??
                  newsData?.content ??
                  newsData?.fullDescription ??
                  '',
              presetFontSizes: const [12],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.3),
            ),
            const Spacer(),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.library_books,
                  size: 12,
                ),
                const SizedBox(width: 10),
                AutoSizeText(
                  newsData?.sourceId ?? '',
                  presetFontSizes: const [12],
                ),
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
        tag: (newsData?.imageUrl ??
            '$newsData.title$newsData.sourceIdassets/images/newsshore_logo.jpg'),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
          image: newsData?.imageUrl != null
              ? (newsData!.imageUrl!
                          .substring(newsData!.imageUrl!.length - 3) !=
                      'mp4'
                  ? NetworkImage(newsData!.imageUrl!)
                  : const AssetImage('assets/images/newsshore_logo.jpg')
                      as ImageProvider)
              : const AssetImage('assets/images/newsshore_logo.jpg'),
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
//