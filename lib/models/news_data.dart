class NewsData {
  final String? title;
  final String? link;
  final List<dynamic>? keywords;
  final List<dynamic>? creator;
  final String? videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? imageUrl;
  final String? sourceId;

  const NewsData({
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.sourceId,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      title: json['title'],
      link: json['link'],
      keywords: json['keywords'],
      creator: json['creator'],
      videoUrl: json['video_url'],
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'],
      sourceId: json['source_id'],
    );
  }
}
