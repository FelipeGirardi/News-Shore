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
      appBar: CustomAppBar('News Shore'),
      body: Column(children: [
        Hero(
          tag: UniqueKey(),
          child: Image.network(
            newsData.imageUrl != null
                ? newsData.imageUrl!
                : 'https://leads-international.com/assets/front/img/placeholder-news.jpg',
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                newsData.title ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                newsData.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                newsData.content ?? '',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.library_books,
                    size: 14,
                  ),
                  const SizedBox(width: 10),
                  Text(newsData.sourceId ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 21, 45, 121)),
                      onPressed: () => _launchNewsUrl(newsData.link ?? ''),
                      child: const Text(
                        'See full news',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  const Spacer()
                ],
              )
            ])),
      ]),
    );
  }
}
