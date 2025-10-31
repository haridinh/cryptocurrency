// Thông tin chi tiết về sàn giao dịch
// ignore_for_file: non_constant_identifier_names

import 'package:cryptocurrency/models/coin_detail_model.dart';

class ExchangeDetailResponse {
  String? alert_notice;
  bool? centralized;
  String? country;
  String? description;
  String? facebook_url;
  bool? has_trading_incentive;
  String? image;
  String? name;
  String? other_url_1;
  String? other_url_2;
  String? public_notice;
  String? reddit_url;
  String? slack_url;
  List<StatusUpdate>? status_updates;
  String? telegram_url;
  List<Ticker>? tickers;
  num? trade_volume_24h_btc;
  num? trade_volume_24h_btc_normalized;
  num? trust_score;
  num? trust_score_rank;
  String? twitter_handle;
  String? url;
  num? year_established;

  ExchangeDetailResponse({
    this.alert_notice,
    this.centralized,
    this.country,
    this.description,
    this.facebook_url,
    this.has_trading_incentive,
    this.image,
    this.name,
    this.other_url_1,
    this.other_url_2,
    this.public_notice,
    this.reddit_url,
    this.slack_url,
    this.status_updates,
    this.telegram_url,
    this.tickers,
    this.trade_volume_24h_btc,
    this.trade_volume_24h_btc_normalized,
    this.trust_score,
    this.trust_score_rank,
    this.twitter_handle,
    this.url,
    this.year_established,
  });

  factory ExchangeDetailResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeDetailResponse(
      alert_notice: json['alert_notice'],
      centralized: json['centralized'],
      country: json['country'],
      description: json['description'],
      facebook_url: json['facebook_url'],
      has_trading_incentive: json['has_trading_incentive'],
      image: json['image'],
      name: json['name'],
      other_url_1: json['other_url_1'],
      other_url_2: json['other_url_2'],
      public_notice: json['public_notice'],
      reddit_url: json['reddit_url'],
      slack_url: json['slack_url'],
      status_updates: json['status_updates'] != null
          ? (json['status_updates'] as List)
                .map((i) => StatusUpdate.fromJson(i))
                .toList()
          : null,
      telegram_url: json['telegram_url'],
      tickers: json['tickers'] != null
          ? (json['tickers'] as List).map((i) => Ticker.fromJson(i)).toList()
          : null,
      trade_volume_24h_btc: json['trade_volume_24h_btc'],
      trade_volume_24h_btc_normalized: json['trade_volume_24h_btc_normalized'],
      trust_score: json['trust_score'],
      trust_score_rank: json['trust_score_rank'],
      twitter_handle: json['twitter_handle'],
      url: json['url'],
      year_established: json['year_established'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alert_notice'] = alert_notice;
    data['centralized'] = centralized;
    data['country'] = country;
    data['description'] = description;
    data['facebook_url'] = facebook_url;
    data['has_trading_incentive'] = has_trading_incentive;
    data['image'] = image;
    data['name'] = name;
    data['other_url_1'] = other_url_1;
    data['other_url_2'] = other_url_2;
    data['public_notice'] = public_notice;
    data['reddit_url'] = reddit_url;
    data['slack_url'] = slack_url;
    data['telegram_url'] = telegram_url;
    data['trade_volume_24h_btc'] = trade_volume_24h_btc;
    data['trade_volume_24h_btc_normalized'] = trade_volume_24h_btc_normalized;
    data['trust_score'] = trust_score;
    data['trust_score_rank'] = trust_score_rank;
    data['twitter_handle'] = twitter_handle;
    data['url'] = url;
    data['year_established'] = year_established;
    if (status_updates != null) {
      data['status_updates'] = status_updates!.map((v) => v.toJson()).toList();
    }
    if (tickers != null) {
      data['tickers'] = tickers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusUpdate {
  String? category;
  String? created_at;
  String? description;
  bool? pin;
  Project? project;
  String? user;
  String? user_title;

  StatusUpdate({
    this.category,
    this.created_at,
    this.description,
    this.pin,
    this.project,
    this.user,
    this.user_title,
  });

  factory StatusUpdate.fromJson(Map<String, dynamic> json) {
    return StatusUpdate(
      category: json['category'],
      created_at: json['created_at'],
      description: json['description'],
      pin: json['pin'],
      project: json['project'] != null
          ? Project.fromJson(json['project'])
          : null,
      user: json['user'],
      user_title: json['user_title'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category'] = category;
    data['created_at'] = created_at;
    data['description'] = description;
    data['pin'] = pin;
    data['user'] = user;
    data['user_title'] = user_title;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  Image? image;
  String? name;
  String? type;

  Project({this.id, this.image, this.name, this.type});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Image {
  String? large;
  String? small;
  String? thumb;

  Image({this.large, this.small, this.thumb});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      large: json['large'],
      small: json['small'],
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['large'] = large;
    data['small'] = small;
    data['thumb'] = thumb;
    return data;
  }
}
