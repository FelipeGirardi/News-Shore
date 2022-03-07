import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';

class NewsCellWidgetLarge extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;

  const NewsCellWidgetLarge({Key? key, this.ctx, this.newsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool hasDescription = (newsData?.description != null ||
        newsData?.content != null ||
        newsData?.fullDescription != null);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: hasDescription
            ? screenHeight < 800
                ? screenHeight / 2.15
                : screenHeight / 2.5
            : screenHeight < 800
                ? screenHeight / 2.4
                : screenHeight / 2.8,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: ImageWidgetLarge(newsData: newsData)),
              Expanded(child: TitleAndSourceWidgetLarge(newsData: newsData)),
            ]),
      ),
    );
  }
}

class TitleAndSourceWidgetLarge extends StatefulWidget {
  const TitleAndSourceWidgetLarge({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  State<TitleAndSourceWidgetLarge> createState() =>
      _TitleAndSourceWidgetLargeState();
}

class _TitleAndSourceWidgetLargeState extends State<TitleAndSourceWidgetLarge> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isFavorite = Provider.of<NewsProvider>(context, listen: false)
        .bookmarkedNewsList
        .any((item) => item.id == widget.newsData!.id);
    bool hasDescription = (widget.newsData?.description != null ||
        widget.newsData?.fullDescription != null ||
        widget.newsData?.description != null);
    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AutoSizeText(widget.newsData?.title ?? '',
                presetFontSizes:
                    hasDescription ? const [20, 18] : const [22, 20],
                maxLines: hasDescription ? 2 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: Theme.of(context).colorScheme.background)),
            const Spacer(),
            AutoSizeText(
              widget.newsData?.description ??
                  widget.newsData?.fullDescription ??
                  '',
              presetFontSizes: screenHeight < 800 ? const [13] : const [15],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.5, color: Theme.of(context).colorScheme.background),
            ),
            const Spacer(),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.library_books,
                  size: 14,
                  color: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 10),
                AutoSizeText(widget.newsData?.sourceId ?? '',
                    presetFontSizes: const [13],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background)),
                const Spacer(),
                InkWell(
                  child: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    size: 24,
                    color: isFavorite
                        ? Colors.yellow
                        : Theme.of(context).colorScheme.background,
                  ),
                  onTap: () {
                    setState(() {
                      isFavorite
                          ? {
                              Provider.of<NewsProvider>(context, listen: false)
                                  .removeBookmark(widget.newsData!)
                            }
                          : Provider.of<NewsProvider>(context, listen: false)
                              .addBookmark(widget.newsData!);
                    });
                  },
                ),
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
    required this.newsData,
  }) : super(key: key);

  final NewsData? newsData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Hero(
        tag: newsData!.id!,
        child: FadeInImage(
          placeholder:
              const AssetImage('assets/images/newsshore_logo_long.png'),
          image: (newsData!.showImage!
                  ? NetworkImage(newsData!.imageUrl!)
                  : const AssetImage('assets/images/newsshore_logo_long.png'))
              as ImageProvider,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
