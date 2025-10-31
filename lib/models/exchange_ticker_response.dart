// Phản hồi từ API chứa danh sách ticker của một sàn giao dịch
import 'package:cryptocurrency/models/coin_detail_model.dart';

class ExchangeTickerModel {
  String? name;
  List<Ticker>? tickers;

  ExchangeTickerModel({this.name, this.tickers});

  factory ExchangeTickerModel.fromJson(Map<String, dynamic> json) {
    return ExchangeTickerModel(
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
