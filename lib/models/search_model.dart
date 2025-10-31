// Tìm kiếm

// ignore_for_file: non_constant_identifier_names

class SearchModel {
  List<Coin>? coins;

  SearchModel({this.coins});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      coins: json['coins'] != null
          ? (json['coins'] as List).map((i) => Coin.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coins != null) {
      data['coins'] = coins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coin {
  String? id;
  String? large;
  int? market_cap_rank;
  String? name;
  String? symbol;
  String? thumb;
  int? isFav;

  Coin({
    this.id,
    this.large,
    this.market_cap_rank,
    this.name,
    this.symbol,
    this.thumb,
    this.isFav,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      large: json['large'],
      market_cap_rank: json['market_cap_rank'],
      name: json['name'],
      symbol: json['symbol'],
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['large'] = large;
    data['market_cap_rank'] = market_cap_rank;
    data['name'] = name;
    data['symbol'] = symbol;
    data['thumb'] = thumb;
    return data;
  }

  factory Coin.fromDBJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      large: json['large'],
      market_cap_rank: json['market_cap_rank'],
      name: json['name'],
      symbol: json['symbol'],
      thumb: json['thumb'],
      isFav: json['isFav'],
    );
  }

  Map<String, dynamic> toDBJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['large'] = large;
    data['market_cap_rank'] = market_cap_rank;
    data['name'] = name;
    data['symbol'] = symbol;
    data['thumb'] = thumb;
    data['isFav'] = isFav;
    return data;
  }
}
