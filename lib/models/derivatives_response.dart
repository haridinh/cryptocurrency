// Toàn bộ phản hồi API về dữ liệu sản phẩm phái sinh
// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

class DerivativesResponse {
  var country;
  var description;
  var id;
  var image;
  String? name;
  var number_of_futures_pairs;
  var number_of_perpetual_pairs;
  var open_interest_btc;
  var trade_volume_24h_btc;
  var url;
  var year_established;

  DerivativesResponse({
    this.country,
    this.description,
    this.id,
    this.image,
    this.name,
    this.number_of_futures_pairs,
    this.number_of_perpetual_pairs,
    this.open_interest_btc,
    this.trade_volume_24h_btc,
    this.url,
    this.year_established,
  });

  factory DerivativesResponse.fromJson(Map<String, dynamic> json) {
    return DerivativesResponse(
      country: json['country'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      number_of_futures_pairs: json['number_of_futures_pairs'],
      number_of_perpetual_pairs: json['number_of_perpetual_pairs'],
      open_interest_btc: json['open_interest_btc'],
      trade_volume_24h_btc: json['trade_volume_24h_btc'],
      url: json['url'],
      year_established: json['year_established'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['number_of_futures_pairs'] = number_of_futures_pairs;
    data['number_of_perpetual_pairs'] = number_of_perpetual_pairs;
    data['open_interest_btc'] = open_interest_btc;
    data['trade_volume_24h_btc'] = trade_volume_24h_btc;
    data['url'] = url;
    data['year_established'] = year_established;
    return data;
  }
}
