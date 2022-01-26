import '/models/news_data.dart';

class NewsDetailArguments {
  final NewsData newsData;
  final Function checkBookmarkFunc;
  final Function addBookmarkFunc;
  final Function removeBookmarkFunc;

  NewsDetailArguments(this.newsData, this.checkBookmarkFunc,
      this.addBookmarkFunc, this.removeBookmarkFunc);
}
