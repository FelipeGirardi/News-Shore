import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/widgets/custom_app_bar.dart';
import '/models/news_data.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/news-detail';

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
    final newsData = ModalRoute.of(context)!.settings.arguments as NewsData;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'News Shore',
        showSearchIcon: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: UniqueKey(),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/newsshore_logo.jpg'),
              image: newsData.imageUrl != null
                  ? (newsData.imageUrl!
                              .substring(newsData.imageUrl!.length - 3) !=
                          'mp4'
                      ? NetworkImage(newsData.imageUrl!)
                      : const AssetImage('assets/images/newsshore_logo.jpg')
                          as ImageProvider)
                  : const AssetImage('assets/images/newsshore_logo.jpg'),
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                if (newsData.keywords != null)
                  Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          newsData.keywords!.join(', '),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.5),
                        )),
                    const SizedBox(height: 10),
                  ]),
                Text(
                  newsData.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, height: 1.3),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      Icons.library_books,
                      size: 14,
                    ),
                    const SizedBox(width: 10),
                    Text(newsData.sourceId ?? '',
                        style: const TextStyle(fontSize: 14)),
                    const Spacer(),
                    Text(newsData.pubDate ?? '',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  newsData.fullDescription ??
                      newsData.content ??
                      newsData.description ??
                      '',
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.primary),
                        onPressed: () => _launchNewsUrl(newsData.link ?? ''),
                        child: const Text(
                          'See full news',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    const Spacer()
                  ],
                ),
                const SizedBox(height: 20),
              ])),
        ]),
      ),
    );
  }
}
