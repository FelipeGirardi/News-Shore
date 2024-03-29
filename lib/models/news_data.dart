import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NewsData {
  final String? id;
  final String? title;
  final String? link;
  final List<dynamic>? keywords;
  final List<dynamic>? creator;
  final String? videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? fullDescription;
  final String? imageUrl;
  final String? sourceId;
  bool? showImage = false;

  NewsData(
      {this.id,
      this.title,
      this.link,
      this.keywords,
      this.creator,
      this.videoUrl,
      this.description,
      this.content,
      this.pubDate,
      this.fullDescription,
      this.imageUrl,
      this.sourceId,
      this.showImage});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    final pubDateSplit = json['pubDate'].split(' ');
    final String? imgString = json['image_url'] as String?;
    final realImgString = imgString == null
        ? null
        : (imgString.isNotEmpty &&
                imgString.substring(0, 4) == 'http' &&
                imgString.substring(imgString.length - 3) != 'mp4')
            ? (imgString.endsWith('&')
                ? imgString.substring(0, imgString.length - 1)
                : imgString)
            : null;
    return NewsData(
        id: const Uuid().v4(),
        title: json['title'],
        link: json['link'],
        keywords: json['keywords'],
        creator: json['creator'],
        videoUrl: json['video_url'],
        description: json['description'],
        content: json['content'],
        pubDate:
            DateFormat("dd-MM-yyyy").format(DateTime.parse(pubDateSplit[0])) +
                ', ' +
                pubDateSplit[1] +
                ' GMT',
        fullDescription: json['full_description'],
        imageUrl: realImgString,
        sourceId: json['source_id'],
        showImage: false);
  }

  Map<String, Object> toMap() {
    return {
      'id': id ?? const Uuid().v4(),
      'title': title ?? '',
      'link': link ?? '',
      'keywords': keywords?.join(',') ?? '',
      'creator': creator?.join(',') ?? '',
      'video_url': videoUrl ?? '',
      'description': description ?? '',
      'content': content ?? '',
      'pub_date': pubDate ?? '',
      'full_description': fullDescription ?? '',
      'image_url': imageUrl ?? '',
      'source_id': sourceId ?? '',
      'show_image': (showImage ?? false) == true ? 1 : 0,
    };
  }

  factory NewsData.fromMap(Map<String, dynamic> dataMap) {
    return NewsData(
        id: dataMap['id'],
        title: dataMap['title'],
        link: dataMap['link'],
        keywords: (dataMap['keywords'] as String).split(','),
        creator: (dataMap['creator'] as String).split(','),
        videoUrl: dataMap['video_url'],
        description: dataMap['description'],
        content: dataMap['content'],
        pubDate: dataMap['pub_date'],
        fullDescription: dataMap['full_description'],
        imageUrl: dataMap['image_url'],
        sourceId: dataMap['source_id'],
        showImage: dataMap['show_image'] == 1 ? true : false);
  }
}
