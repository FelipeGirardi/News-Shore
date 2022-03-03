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
    bool hasDescription = (newsData?.description != null ||
        newsData?.content != null ||
        newsData?.fullDescription != null);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: hasDescription
            ? MediaQuery.of(context).size.height / 2.3
            : MediaQuery.of(context).size.height / 2.7,
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
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
              presetFontSizes: const [13],
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
          image: newsData?.imageUrl != null
              ? newsData!.imageUrl!.isNotEmpty
                  ? NetworkImage(newsData!.imageUrl!)
                  : const AssetImage('assets/images/newsshore_logo_long.png')
                      as ImageProvider
              : const AssetImage('assets/images/newsshore_logo_long.png'),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
