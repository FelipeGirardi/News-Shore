import '/models/news_data.dart';
import '/models/news_api_data.dart';

class NewsDetailArguments {
  final NewsData? newsData;
  final NewsAPIData? newsAPIData;
  final bool isBookmarked;
  final String heroTag;

  NewsDetailArguments(
      this.newsData, this.newsAPIData, this.isBookmarked, this.heroTag);
}
