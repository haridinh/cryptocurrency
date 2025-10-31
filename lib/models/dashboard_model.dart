// Các thông tin tổng quan cần thiết để hiển thị màn hình chính/bảng điều khiển

import 'package:cryptocurrency/models/coin_list_model.dart';
import 'package:cryptocurrency/models/trending_model.dart';

class DashboardResponse {
  List<CoinListModel>? coinModel;
  TrendingModel? trendingCoins;

  DashboardResponse({this.coinModel, this.trendingCoins});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      coinModel: json['CoinListModel'] != null
          ? (json['CoinListModel'] as List)
                .map((i) => CoinListModel.fromJson(i))
                .toList()
          : null,
      trendingCoins: json['trendingCoins'] != null
          ? (TrendingModel.fromJson(json['trendingCoins']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (coinModel != null) {
      data['coinModel'] = coinModel!.map((v) => v.toJson()).toList();
    }
    if (trendingCoins != null) {
      data['trendingCoins'] = trendingCoins!.toJson();
    }
    return data;
  }
}
