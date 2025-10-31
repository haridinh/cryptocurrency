// Các loại tiền tệ pháp định
class CurrencyModel {
  String? cc;
  String? name;
  String? symbol;

  CurrencyModel({this.cc, this.name, this.symbol});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      cc: json['cc'],
      name: json['name'],
      symbol: json['symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cc'] = cc;
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}
