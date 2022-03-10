import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/news_provider.dart';
import '/models/news_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;
  final int? index;

  const NewsCellWidgetSmall({Key? key, this.ctx, this.newsData, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        elevation: 3,
        margin: isMobile
            ? (index! % 2 == 0
                ? const EdgeInsets.fromLTRB(12, 8, 8, 8)
                : const EdgeInsets.fromLTRB(8, 8, 12, 8))
            : (index! % 3 == 0
                ? const EdgeInsets.fromLTRB(18, 14, 14, 14)
                : (index! - 1) % 3 == 0
                    ? const EdgeInsets.fromLTRB(14, 14, 14, 14)
                    : const EdgeInsets.fromLTRB(14, 14, 18, 14)),
        color: Theme.of(context).colorScheme.background,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 4,
                  child:
                      ImageWidgetSmall(newsData: newsData, isMobile: isMobile)),
              Expanded(
                  flex: 6,
                  child: TitleAndSourceWidgetSmall(
                      newsData: newsData, isMobile: isMobile))
            ]));
  }
}

class TitleAndSourceWidgetSmall extends StatefulWidget {
  const TitleAndSourceWidgetSmall(
      {Key? key, this.newsData, required this.isMobile})
      : super(key: key);

  final NewsData? newsData;
  final bool isMobile;

  @override
  State<TitleAndSourceWidgetSmall> createState() =>
      _TitleAndSourceWidgetSmallState();
}

class _TitleAndSourceWidgetSmallState extends State<TitleAndSourceWidgetSmall> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = Provider.of<NewsProvider>(context, listen: false)
        .bookmarkedNewsList
        .any((item) => item.id == widget.newsData!.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 5, 7, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoSizeText(widget.newsData?.title ?? '',
              presetFontSizes: widget.isMobile ? const [13] : const [19],
              maxLines: widget.isMobile ? 4 : 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, height: 1.4)),
          const Spacer(),
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.library_books,
                size: widget.isMobile ? 11 : 17,
              ),
              const SizedBox(width: 10),
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: AutoSizeText(
                  widget.newsData?.sourceId ?? '',
                  presetFontSizes: widget.isMobile ? const [11] : const [17],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              InkWell(
                child: Icon(
                  isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  size: widget.isMobile ? 24 : 36,
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
  const ImageWidgetSmall(
      {Key? key, required this.newsData, required this.isMobile})
      : super(key: key);

  final NewsData? newsData;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: Hero(
        tag: newsData!.id!,
        child: FadeInImage(
          placeholder:
              const AssetImage('assets/images/newsshore_logo_long.png'),
          image: (newsData!.showImage!
                  ? NetworkImage(newsData!.imageUrl!)
                  : const AssetImage('assets/images/newsshore_logo_long.png'))
              as ImageProvider,
          width: isMobile ? 200 : 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
