class NewsResponse {
  final String? status;
  final int? totalResults;
  final List<dynamic>? results;
  final String? nextPage;

  const NewsResponse({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      results: json['results'],
      nextPage: json['nextPage'],
    );
  }
}
