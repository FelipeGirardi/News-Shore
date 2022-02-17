import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';

class NewsCellWidgetMedium extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final int? index;
  final bool? isBookmarked;
  final String? bookmarkHeroTag;

  const NewsCellWidgetMedium(
      {Key? key,
      this.ctx,
      this.newsData,
      this.index,
      this.isBookmarked,
      this.bookmarkHeroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
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
                ImageWidgetMedium(
                    newsData: newsData,
                    isBookmarked: isBookmarked,
                    bookmarkHeroTag: bookmarkHeroTag)
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
    );
  }
}

class TitleAndSourceWidgetMedium extends StatefulWidget {
  const TitleAndSourceWidgetMedium({Key? key, required this.newsData})
      : super(key: key);

  final NewsData? newsData;

  @override
  State<TitleAndSourceWidgetMedium> createState() =>
      _TitleAndSourceWidgetMediumState();
}

class _TitleAndSourceWidgetMediumState
    extends State<TitleAndSourceWidgetMedium> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = Provider.of<NewsProvider>(context, listen: false)
        .bookmarkedNewsList
        .any((item) => item.id == widget.newsData!.id);
    bool hasDescription = (widget.newsData?.description != null ||
        widget.newsData?.content != null ||
        widget.newsData?.fullDescription != null);
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 125,
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AutoSizeText(widget.newsData?.title ?? '',
                  presetFontSizes: hasDescription ? const [15] : const [18],
                  maxLines: hasDescription ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  )),
              const Spacer(),
              AutoSizeText(
                widget.newsData?.description ??
                    widget.newsData?.content ??
                    widget.newsData?.fullDescription ??
                    '',
                presetFontSizes: const [12],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1.5),
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
                    widget.newsData?.sourceId ?? '',
                    presetFontSizes: const [12],
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  InkWell(
                    child: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      size: 24,
                      color: isFavorite ? Colors.yellow : null,
                    ),
                    onTap: () {
                      setState(() {
                        isFavorite
                            ? Provider.of<NewsProvider>(context, listen: false)
                                .removeBookmark(widget.newsData!)
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
      ),
    );
  }
}

class ImageWidgetMedium extends StatelessWidget {
  const ImageWidgetMedium(
      {Key? key,
      required this.newsData,
      this.isBookmarked,
      this.bookmarkHeroTag})
      : super(key: key);

  final NewsData? newsData;
  final bool? isBookmarked;
  final String? bookmarkHeroTag;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Hero(
        tag: isBookmarked! ? bookmarkHeroTag! : newsData!.id!,
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
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
//