//  Các đồng coin mà người dùng đã thêm vào danh mục đầu tư

// ignore_for_file: non_constant_identifier_names

import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class Data {
  num? inr;
  num? inr_24h_change;
  num? inr_24h_vol;
  num? inr_market_cap;
  num? last_updated_at;

  Data({
    this.inr,
    this.inr_24h_change,
    this.inr_24h_vol,
    this.inr_market_cap,
    this.last_updated_at,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      inr: json[appStore.mSelectedCurrency!.cc.validate()],
      inr_24h_change:
          json['${appStore.mSelectedCurrency!.cc.validate()}_24h_change'],
      inr_24h_vol: json['${appStore.mSelectedCurrency!.cc.validate()}_24h_vol'],
      inr_market_cap:
          json['${appStore.mSelectedCurrency!.cc.validate()}_market_cap'],
      last_updated_at: json['last_updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[appStore.mSelectedCurrency!.cc.validate()] = inr;
    data['${appStore.mSelectedCurrency!.cc.validate()}_24h_change'] =
        inr_24h_change;
    data['${appStore.mSelectedCurrency!.cc.validate()}_24h_vol'] = inr_24h_vol;
    data['${appStore.mSelectedCurrency!.cc.validate()}_market_cap'] =
        inr_market_cap;
    data['last_updated_at'] = last_updated_at;
    return data;
  }
}
