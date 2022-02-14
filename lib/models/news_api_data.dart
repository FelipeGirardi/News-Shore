import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NewsAPIData {
  final String? id;
  final NewsAPISource? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const NewsAPIData({
    this.id,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsAPIData.fromJson(Map<String, dynamic> json) {
    final publishedAtSplit = json['publishedAt'].split('T');
    final timestampSplit = publishedAtSplit[1].split('Z');
    return NewsAPIData(
      id: const Uuid().v4(),
      source: NewsAPISource.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt:
          DateFormat("dd-MM-yyyy").format(DateTime.parse(publishedAtSplit[0])) +
              ', ' +
              timestampSplit[0] +
              ' GMT',
      content: json['content'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id ?? const Uuid().v4(),
      'source': source?.toMap() ?? {},
      'author': author ?? '',
      'title': title ?? '',
      'description': description ?? '',
      'url': url ?? '',
      'urlToImage': urlToImage ?? '',
      'publishedAt': publishedAt ?? '',
      'content': content ?? '',
    };
  }

  factory NewsAPIData.fromMap(Map<String, dynamic> dataMap) {
    return NewsAPIData(
      id: dataMap['id'],
      source: NewsAPISource.fromMap(dataMap['source']),
      author: dataMap['author'],
      title: dataMap['title'],
      description: dataMap['description'],
      url: dataMap['url'],
      urlToImage: dataMap['urlToImage'],
      publishedAt: dataMap['publishedAt'],
      content: dataMap['content'],
    );
  }
}

class NewsAPISource {
  final String? id;
  final String? name;

  const NewsAPISource({this.id, this.name});

  factory NewsAPISource.fromJson(Map<String, dynamic> json) {
    return NewsAPISource(id: json['id'], name: json['name']);
  }

  Map<String, Object> toMap() {
    return {'id': id ?? '', 'name': name ?? ''};
  }

  factory NewsAPISource.fromMap(Map<String, dynamic> dataMap) {
    return NewsAPISource(id: dataMap['id'], name: dataMap['name']);
  }
}