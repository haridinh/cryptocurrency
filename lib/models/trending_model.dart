// Dữ liệu các đồng coin hoặc sự kiện đang theo xu hướng
// ignore_for_file: non_constant_identifier_names

class TrendingModel {
  List<Coin>? coins;
  List<Object>? exchanges;
  Status? status;

  TrendingModel({this.coins, this.exchanges, this.status});

  factory TrendingModel.fromJson(Map<String, dynamic> json) {
    return TrendingModel(
      coins: json['coins'] != null
          ? (json['coins'] as List).map((i) => Coin.fromJson(i)).toList()
          : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      // exchanges: json['exchanges'] != null ? (json['exchanges'] as List).map((i) => Object.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coins != null) {
      data['coins'] = coins!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    /*if (this.exchanges != null) {
      data['exchanges'] = this.exchanges.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Coin {
  Item? item;

  Coin({this.item});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
  num? coin_id;
  String? id;
  String? large;
  num? market_cap_rank;
  String? name;
  num? price_btc;
  num? score;
  String? slug;
  String? small;
  String? symbol;
  String? thumb;

  Item({
    this.coin_id,
    this.id,
    this.large,
    this.market_cap_rank,
    this.name,
    this.price_btc,
    this.score,
    this.slug,
    this.small,
    this.symbol,
    this.thumb,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      coin_id: json['coin_id'],
      id: json['id'],
      large: json['large'],
      market_cap_rank: json['market_cap_rank'],
      name: json['name'],
      price_btc: json['price_btc'],
      score: json['score'],
      slug: json['slug'],
      small: json['small'],
      symbol: json['symbol'],
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['coin_id'] = coin_id;
    data['id'] = id;
    data['large'] = large;
    data['market_cap_rank'] = market_cap_rank;
    data['name'] = name;
    data['price_btc'] = price_btc;
    data['score'] = score;
    data['slug'] = slug;
    data['small'] = small;
    data['symbol'] = symbol;
    data['thumb'] = thumb;
    return data;
  }
}

class Status {
  int? error_code;
  String? error_message;

  Status({this.error_code, this.error_message});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      error_code: json['error_code'],
      error_message: json['error_message'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = error_code;
    data['error_message'] = error_message;
    return data;
  }
}
