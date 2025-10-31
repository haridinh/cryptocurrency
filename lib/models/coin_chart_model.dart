// Các điểm dữ liệu để vẽ biểu đồ giá của một đồng coin cụ thể
class CoinChartModel {
  List<List<num>> prices;
  List<List<num>> marketCaps;
  List<List<num>> totalVolumes;

  CoinChartModel({
    required this.prices,
    required this.marketCaps,
    required this.totalVolumes,
  });

  factory CoinChartModel.fromJson(Map<String, dynamic> json) {
    return CoinChartModel(
      prices: List<List<num>>.from(
        (json["prices"] ?? []).map((e) => List<num>.from(e)),
      ),
      marketCaps: List<List<num>>.from(
        (json["market_caps"] ?? []).map((e) => List<num>.from(e)),
      ),
      totalVolumes: List<List<num>>.from(
        (json["total_volumes"] ?? []).map((e) => List<num>.from(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "prices": prices,
      "market_caps": marketCaps,
      "total_volumes": totalVolumes,
    };
  }
}
