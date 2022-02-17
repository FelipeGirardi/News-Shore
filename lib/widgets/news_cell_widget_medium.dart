import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import '/models/news_api_data.dart';

class NewsCellWidgetMedium extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final NewsAPIData? newsAPIData;
  final int? index;
  final bool? isBookmarked;
  final String? bookmarkHeroTag;

  const NewsCellWidgetMedium(
      {Key? key,
      this.ctx,
      this.newsData,
      this.newsAPIData,
      this.index,
      this.isBookmarked,
      this.bookmarkHeroTag})
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
                  TitleAndSourceWidgetMedium(
                      newsData: newsData, newsAPIData: newsAPIData),
                  const SizedBox(
                    width: 5,
                  ),
                  ImageWidgetMedium(
                      newsData: newsData,
                      newsAPIData: newsAPIData,
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
      ),
    );
  }
}

class TitleAndSourceWidgetMedium extends StatefulWidget {
  const TitleAndSourceWidgetMedium(
      {Key? key, required this.newsData, required this.newsAPIData})
      : super(key: key);

  final NewsData? newsData;
  final NewsAPIData? newsAPIData;

  @override
  State<TitleAndSourceWidgetMedium> createState() =>
      _TitleAndSourceWidgetMediumState();
}

class _TitleAndSourceWidgetMediumState
    extends State<TitleAndSourceWidgetMedium> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    bool isFavorite = widget.newsData != null
        ? provider.bookmarkedNewsList
            .any((item) => item.id == widget.newsData!.id)
        : provider.bookmarkedNewsAPIList
            .any((item) => item.id == widget.newsData!.id);
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
              AutoSizeText(
                  widget.newsData != null
                      ? widget.newsData?.title ?? ''
                      : widget.newsAPIData?.title ?? '',
                  presetFontSizes: const [15],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  )),
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
                    widget.newsData != null
                        ? widget.newsData?.sourceId ?? ''
                        : widget.newsAPIData?.source?.name ?? '',
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
      required this.newsAPIData,
      this.isBookmarked,
      this.bookmarkHeroTag})
      : super(key: key);

  final NewsData? newsData;
  final NewsAPIData? newsAPIData;
  final bool? isBookmarked;
  final String? bookmarkHeroTag;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        newsData != null ? newsData?.imageUrl : newsAPIData?.urlToImage;
    return Expanded(
      flex: 3,
      child: Hero(
        tag: isBookmarked!
            ? bookmarkHeroTag!
            : (newsData != null ? newsData?.id! ?? '' : newsAPIData?.id! ?? ''),
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
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
//