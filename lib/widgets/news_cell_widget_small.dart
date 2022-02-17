import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import '/models/news_api_data.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final NewsAPIData? newsAPIData;
  final int? index;

  const NewsCellWidgetSmall(
      {Key? key, this.ctx, this.newsData, this.newsAPIData, this.index})
      : super(key: key);

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
              Expanded(
                  flex: 4,
                  child: ImageWidgetSmall(
                      newsData: newsData, newsAPIData: newsAPIData)),
              Expanded(
                  flex: 6,
                  child: TitleAndSourceWidgetSmall(
                      newsData: newsData, newsAPIData: newsAPIData))
            ]));
  }
}

class TitleAndSourceWidgetSmall extends StatefulWidget {
  const TitleAndSourceWidgetSmall({Key? key, this.newsData, this.newsAPIData})
      : super(key: key);

  final NewsData? newsData;
  final NewsAPIData? newsAPIData;

  @override
  State<TitleAndSourceWidgetSmall> createState() =>
      _TitleAndSourceWidgetSmallState();
}

class _TitleAndSourceWidgetSmallState extends State<TitleAndSourceWidgetSmall> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    bool isFavorite = widget.newsData != null
        ? provider.bookmarkedNewsList
            .any((item) => item.id == widget.newsData!.id)
        : provider.bookmarkedNewsAPIList
            .any((item) => item.id == widget.newsData!.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 5, 7, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoSizeText(
              widget.newsData != null
                  ? widget.newsData?.title ?? ''
                  : widget.newsAPIData?.title ?? '',
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
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: AutoSizeText(
                  widget.newsData != null
                      ? widget.newsData?.sourceId ?? ''
                      : widget.newsAPIData?.source?.name ?? '',
                  presetFontSizes: const [11],
                  overflow: TextOverflow.ellipsis,
                ),
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
    );
  }
}

class ImageWidgetSmall extends StatelessWidget {
  const ImageWidgetSmall({
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
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
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
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
