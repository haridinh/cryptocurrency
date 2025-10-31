// Phản hồi của API về tin tức
// ignore_for_file: non_constant_identifier_names

import 'package:nb_utils/nb_utils.dart';

class NewsResponse {
  List<NewsData>? news;
  int? count;
  int? page;

  NewsResponse({this.news, this.count, this.page});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      news: json['data'] != null
          ? (json['data'] as List).map((i) => NewsData.fromJson(i)).toList()
          : null,
      count: json['count'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['page'] = page;
    if (news != null) {
      data['data'] = news.validate().map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  String? author;
  String? description;
  String? news_site;
  String? thumb_2x;
  String? title;
  int? updated_at;
  String? url;

  NewsData({
    this.author,
    this.description,
    this.news_site,
    this.thumb_2x,
    this.title,
    this.updated_at,
    this.url,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      author: json['author'],
      description: json['description'],
      news_site: json['news_site'],
      thumb_2x: json['thumb_2x'],
      title: json['title'],
      updated_at: json['updated_at'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['author'] = author;
    data['description'] = description;
    data['news_site'] = news_site;
    data['thumb_2x'] = thumb_2x;
    data['title'] = title;
    data['updated_at'] = updated_at;
    data['url'] = url;
    return data;
  }
}
