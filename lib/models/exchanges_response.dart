// Toàn bộ phản hồi từ API khi yêu cầu danh sách các sàn giao dịch
// ignore_for_file: non_constant_identifier_names

class ExchangesResponse {
  String? country;
  String? description;
  bool? has_trading_incentive;
  String? id;
  String? image;
  String? name;
  double? trade_volume_24h_btc;
  double? trade_volume_24h_btc_normalized;
  int? trust_score;
  int? trust_score_rank;
  String? url;
  int? year_established;

  ExchangesResponse({
    this.country,
    this.description,
    this.has_trading_incentive,
    this.id,
    this.image,
    this.name,
    this.trade_volume_24h_btc,
    this.trade_volume_24h_btc_normalized,
    this.trust_score,
    this.trust_score_rank,
    this.url,
    this.year_established,
  });

  factory ExchangesResponse.fromJson(Map<String, dynamic> json) {
    return ExchangesResponse(
      country: json['country'],
      description: json['description'],
      has_trading_incentive: json['has_trading_incentive'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      trade_volume_24h_btc: json['trade_volume_24h_btc'],
      trade_volume_24h_btc_normalized: json['trade_volume_24h_btc_normalized'],
      trust_score: json['trust_score'],
      trust_score_rank: json['trust_score_rank'],
      url: json['url'],
      year_established: json['year_established'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
    data['description'] = description;
    data['has_trading_incentive'] = has_trading_incentive;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['trade_volume_24h_btc'] = trade_volume_24h_btc;
    data['trade_volume_24h_btc_normalized'] = trade_volume_24h_btc_normalized;
    data['trust_score'] = trust_score;
    data['trust_score_rank'] = trust_score_rank;
    data['url'] = url;
    data['year_established'] = year_established;
    return data;
  }
}
