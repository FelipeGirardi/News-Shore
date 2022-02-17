import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import '/models/news_api_data.dart';

class NewsCellWidgetLarge extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final NewsAPIData? newsAPIData;

  const NewsCellWidgetLarge(
      {Key? key, this.ctx, this.newsData, this.newsAPIData})
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
              Expanded(
                  child: ImageWidgetLarge(
                      newsData: newsData, newsAPIData: newsAPIData)),
              Expanded(
                  child: TitleAndSourceWidgetLarge(
                newsData: newsData,
                newsAPIData: newsAPIData,
              )),
            ]),
      ),
    );
  }
}

class TitleAndSourceWidgetLarge extends StatefulWidget {
  const TitleAndSourceWidgetLarge(
      {Key? key, required this.newsData, required this.newsAPIData})
      : super(key: key);

  final NewsData? newsData;
  final NewsAPIData? newsAPIData;

  @override
  State<TitleAndSourceWidgetLarge> createState() =>
      _TitleAndSourceWidgetLargeState();
}

class _TitleAndSourceWidgetLargeState extends State<TitleAndSourceWidgetLarge> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    bool isFavorite = widget.newsData != null
        ? provider.bookmarkedNewsList
            .any((item) => item.id == widget.newsData!.id)
        : provider.bookmarkedNewsAPIList
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
            AutoSizeText(
                widget.newsData != null
                    ? widget.newsData?.title ?? ''
                    : widget.newsAPIData?.title ?? '',
                presetFontSizes: const [18],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: Theme.of(context).colorScheme.background)),
            const Spacer(),
            AutoSizeText(
              widget.newsData != null
                  ? widget.newsData?.description ??
                      widget.newsData?.content ??
                      widget.newsData?.fullDescription ??
                      ''
                  : widget.newsAPIData?.description ??
                      widget.newsAPIData?.content ??
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
                AutoSizeText(
                    widget.newsData != null
                        ? widget.newsData?.sourceId ?? ''
                        : widget.newsAPIData?.source?.name ?? '',
                    presetFontSizes: const [14],
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
    required this.newsAPIData,
  }) : super(key: key);

  final NewsData? newsData;
  final NewsAPIData? newsAPIData;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        newsData != null ? newsData?.imageUrl : newsAPIData?.urlToImage;
    return ClipRRect(
      child: Hero(
        tag: newsData != null ? newsData?.id! ?? '' : newsAPIData?.id! ?? '',
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
          image: imageUrl != null
              ? imageUrl.isNotEmpty
                  ? (imageUrl.substring(imageUrl.length - 3) != 'mp4'
                      ? NetworkImage(imageUrl)
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
