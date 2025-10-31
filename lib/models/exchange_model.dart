// Thông tin cơ bản về sàn giao dịch
import 'package:cryptocurrency/models/coin_detail_model.dart';

class ExchangeModel {
  String? name;
  List<Ticker>? tickers;

  ExchangeModel({this.name, this.tickers});

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      name: json['name'],
      tickers: json['tickers'] != null
          ? (json['tickers'] as List).map((i) => Ticker.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    if (tickers != null) {
      data['tickers'] = tickers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
