import 'package:flutter/material.dart';

import '/models/news_data.dart';

class NewsCellWidgetSmall extends StatelessWidget {
  final BuildContext? ctx;
  final NewsData? newsData;

  const NewsCellWidgetSmall({Key? key, this.ctx, this.newsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 248, 12, 95),
            width: 1,
          ),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: ListTile(
            horizontalTitleGap: 5,
            title: Text(newsData?.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            subtitle: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(newsData!.sourceId!)),
            trailing: newsData?.imageUrl != null
                ? ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 100),
                    child:
                        Image.network(newsData!.imageUrl!, fit: BoxFit.cover),
                  )
                : null,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
