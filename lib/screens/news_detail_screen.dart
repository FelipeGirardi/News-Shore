import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/providers/news_provider.dart';
import '/widgets/custom_app_bar.dart';
import '/models/news_data.dart';
import '/models/news_detail_arguments.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/news-detail';

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  _launchNewsUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final NewsDetailArguments args =
        ModalRoute.of(context)!.settings.arguments as NewsDetailArguments;
    final NewsData newsData = args.newsData;
    final bool isBookmarked = args.isBookmarked;
    final String heroTag = args.heroTag;
    final provider = Provider.of<NewsProvider>(context, listen: false);
    bool isFavorite =
        provider.bookmarkedNewsList.any((item) => item.id == newsData.id);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'News Shore',
        showSearchIcon: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: isBookmarked ? heroTag : newsData.id!,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/newsshore_logo_long.png'),
              image: (newsData.showImage!
                      ? NetworkImage(newsData.imageUrl!)
                      : const AssetImage(
                          'assets/images/newsshore_logo_long.png'))
                  as ImageProvider,
              height: isMobile ? 200 : 300,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                if (newsData.keywords != null)
                  Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          newsData.keywords!.take(5).join(', '),
                          maxLines: 1,
                          presetFontSizes: isMobile ? const [13] : const [19],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 13 : 19,
                              height: 1.5),
                        )),
                    const SizedBox(height: 10),
                  ]),
                Text(
                  newsData.title ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 22 : 36,
                      height: 1.3),
                ),
                SizedBox(height: isMobile ? 15 : 30),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.library_books,
                              size: isMobile ? 13 : 19,
                            ),
                            const SizedBox(width: 10),
                            Text(newsData.sourceId ?? '',
                                style: TextStyle(fontSize: isMobile ? 13 : 19)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Icon(
                            Icons.access_time,
                            size: isMobile ? 13 : 19,
                          ),
                          const SizedBox(width: 10),
                          Text(newsData.pubDate ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: isMobile ? 13 : 19))
                        ]),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        child: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          size: isMobile ? 28 : 36,
                          color: isFavorite ? Colors.yellow : null,
                        ),
                        onTap: () {
                          setState(() {
                            isFavorite
                                ? Provider.of<NewsProvider>(context,
                                        listen: false)
                                    .removeBookmark(newsData)
                                : Provider.of<NewsProvider>(context,
                                        listen: false)
                                    .addBookmark(newsData);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 20 : 35),
                newsData.videoUrl != null
                    ? NewsVideoWidget(
                        videoUrl: newsData.videoUrl!,
                        isMobile: isMobile,
                      )
                    : Container(),
                Text(
                  newsData.fullDescription ??
                      newsData.content ??
                      newsData.description ??
                      '',
                  style: TextStyle(fontSize: isMobile ? 15 : 21, height: 1.75),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: isMobile ? 50 : 75,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary,
                              minimumSize: const Size(100, 50)),
                          onPressed: () => _launchNewsUrl(newsData.link ?? ''),
                          child: Text(
                            AppLocalizations.of(context)!.fullNews,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 18 : 24),
                          )),
                    ),
                    const Spacer()
                  ],
                ),
                const SizedBox(height: 30),
              ])),
        ]),
      ),
    );
  }
}

class NewsVideoWidget extends StatefulWidget {
  const NewsVideoWidget(
      {Key? key, required this.videoUrl, required this.isMobile})
      : super(key: key);
  final String videoUrl;
  final bool isMobile;

  @override
  _NewsVideoWidgetState createState() => _NewsVideoWidgetState();
}

class _NewsVideoWidgetState extends State<NewsVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
              height: widget.isMobile ? 200 : 300,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            !_controller.value.isPlaying
                ? const Icon(
                    Icons.play_arrow,
                    size: 72,
                    color: Colors.white,
                  )
                : Container(),
          ]),
          onTap: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
