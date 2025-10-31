// Loại tiền tệ đang được người dùng chọn để hiển thị giá

class CurrentCurrencyModel {
  String? currency;
  num? currentValue;

  CurrentCurrencyModel({this.currency, this.currentValue});

  CurrentCurrencyModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    currentValue = json['currentValue'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currency'] = currency;
    data['currentValue'] = currentValue;
    return data;
  }
}
