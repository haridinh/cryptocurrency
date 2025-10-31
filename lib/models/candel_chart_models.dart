// Thông tin cần thiết để vẽ biểu đồ nến

class CandleChartResponse {
  int? time;
  double? open;
  double? high;
  double? low;
  double? close;

  CandleChartResponse({this.time, this.open, this.high, this.low, this.close});

  factory CandleChartResponse.fromJson(Map<String, dynamic> json) {
    return CandleChartResponse(
      time: json['time'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['close'] = close;
    return data;
  }
}
