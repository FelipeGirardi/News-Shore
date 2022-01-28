import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCellWidgetLarge extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;

  const NewsCellWidgetLarge({Key? key, this.ctx, this.newsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.2,
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
    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            AutoSizeText(widget.newsData?.title ?? '',
                presetFontSizes: const [17],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: Theme.of(context).colorScheme.background)),
            const Spacer(),
            AutoSizeText(
              widget.newsData?.description ??
                  widget.newsData?.content ??
                  widget.newsData?.fullDescription ??
                  '',
              presetFontSizes: const [14],
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.3, color: Theme.of(context).colorScheme.background),
            ),
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
                    presetFontSizes: const [14],
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
          placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
          image: newsData?.imageUrl != null
              ? newsData!.imageUrl!.isNotEmpty
                  ? (newsData!.imageUrl!
                              .substring(newsData!.imageUrl!.length - 3) !=
                          'mp4'
                      ? NetworkImage(newsData!.imageUrl!)
                      : const AssetImage('assets/images/newsshore_logo.jpg')
                          as ImageProvider)
                  : const AssetImage('assets/images/newsshore_logo.jpg')
              : const AssetImage('assets/images/newsshore_logo.jpg'),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
