import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

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
      // can't launch url, there is some error
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
    bool isFavorite = Provider.of<NewsProvider>(context, listen: false)
        .bookmarkedNewsList
        .any((item) => item.id == newsData.id);
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
              placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
              image: newsData.imageUrl != null
                  ? newsData.imageUrl!.isNotEmpty
                      ? (newsData.imageUrl!
                                  .substring(newsData.imageUrl!.length - 3) !=
                              'mp4'
                          ? NetworkImage(newsData.imageUrl!)
                          : const AssetImage('assets/images/newsshore_logo.jpg')
                              as ImageProvider)
                      : const AssetImage('assets/images/newsshore_logo.jpg')
                  : const AssetImage('assets/images/newsshore_logo.jpg'),
              height: 200,
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
                          presetFontSizes: const [13],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              height: 1.5),
                        )),
                    const SizedBox(height: 15),
                  ]),
                Text(
                  newsData.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22, height: 1.4),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.library_books,
                              size: 15,
                            ),
                            const SizedBox(width: 10),
                            Text(newsData.sourceId ?? '',
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(newsData.pubDate ?? '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 15))
                        ]),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        child: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          size: 28,
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
                const SizedBox(height: 25),
                Text(
                  newsData.fullDescription ??
                      newsData.content ??
                      newsData.description ??
                      '',
                  style: const TextStyle(fontSize: 15, height: 1.75),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.primary,
                            minimumSize: const Size(100, 50)),
                        onPressed: () => _launchNewsUrl(newsData.link ?? ''),
                        child: const Text(
                          'See full news',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
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
