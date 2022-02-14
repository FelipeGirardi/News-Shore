class NewsAPIResponse {
  final String? status;
  final int? totalResults;
  final List<dynamic>? articles;

  const NewsAPIResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsAPIResponse.fromJson(Map<String, dynamic> json) {
    return NewsAPIResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'],
    );
  }
}
