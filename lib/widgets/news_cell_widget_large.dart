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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.2,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: ImageWidgetLarge(
                      imageUrl: newsData?.imageUrl != null
                          ? newsData!.imageUrl!
                          : 'https://leads-international.com/assets/front/img/placeholder-news.jpg')),
              Expanded(child: TitleAndSourceWidgetLarge(newsData: newsData)),
            ]),
      ),
    );
  }
}

class TitleAndSourceWidgetLarge extends StatelessWidget {
  const TitleAndSourceWidgetLarge({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 21, 45, 121),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        side: BorderSide(
          color: Color.fromARGB(255, 21, 45, 121),
          width: 1,
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
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
                    fontWeight: FontWeight.bold, color: Colors.white)),
            const Spacer(),
            AutoSizeText(
              newsData?.description ?? '',
              minFontSize: 14,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.library_books,
                  size: 14,
                  color: Colors.white54,
                ),
                const SizedBox(width: 10),
                AutoSizeText(newsData?.sourceId ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white54,
                    )),
              ],
            ),
          ],
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

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: Hero(
        tag: UniqueKey(),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/placeholder_news.jpg'),
          image: NetworkImage(imageUrl),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
