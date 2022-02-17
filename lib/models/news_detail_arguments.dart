import '/models/news_data.dart';

class NewsDetailArguments {
  final NewsData newsData;
  final bool isBookmarked;
  final String heroTag;

  NewsDetailArguments(this.newsData, this.isBookmarked, this.heroTag);
}
