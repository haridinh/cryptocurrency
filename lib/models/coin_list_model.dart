// Các mục trong danh sách tổng thể các đồng tiền điện tử
class CoinListModel {
  num? ath;
  num? athChangePercentage;
  String? athDate;
  num? atl;
  num? atlChangePercentage;
  String? atlDate;
  num? circulatingSupply;
  num? currentPrice;
  num? fullyDilutedValuation;
  num? high24h;
  String? id;
  String? image;
  String? lastUpdated;
  num? low24h;
  num? marketCap;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? marketCapRank;
  num? maxSupply;
  String? name;
  num? priceChange24h;
  num? priceChangePercentage24h;
  Roi? roi;
  SparklineIn7d? sparklineIn7d;
  String? symbol;
  num? totalSupply;
  num? totalVolume;
  num? priceChangePercentage1hInCurrency;
  num? priceChangePercentage24hInCurrency;
  num? priceChangePercentage7dInCurrency;
  num? priceChangePercentage14dInCurrency;
  num? priceChangePercentage30dInCurrency;
  num? priceChangePercentage200dInCurrency;
  num? priceChangePercentage1yInCurrency;

  CoinListModel({
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.circulatingSupply,
    this.currentPrice,
    this.fullyDilutedValuation,
    this.high24h,
    this.id,
    this.image,
    this.lastUpdated,
    this.low24h,
    this.marketCap,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.marketCapRank,
    this.maxSupply,
    this.name,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.roi,
    this.sparklineIn7d,
    this.symbol,
    this.totalSupply,
    this.totalVolume,
    this.priceChangePercentage1hInCurrency,
    this.priceChangePercentage14dInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage200dInCurrency,
    this.priceChangePercentage1yInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage7dInCurrency,
  });

  factory CoinListModel.fromJson(Map<String, dynamic> json) {
    return CoinListModel(
      ath: json['ath'],
      athChangePercentage: json['athChangePercentage'],
      athDate: json['athDate'],
      atl: json['atl'],
      atlChangePercentage: json['atlChangePercentage'],
      atlDate: json['atlDate'],
      circulatingSupply: json['circulatingSupply'],
      currentPrice: json['currentPrice'],
      high24h: json['high24h'],
      id: json['id'],
      image: json['image'],
      lastUpdated: json['lastUpdated'],
      low24h: json['low24h'],
      marketCap: json['marketCap'],
      marketCapChange24h: json['marketCapChange24h'],
      marketCapChangePercentage24h: json['marketCapChangePercentage24h'],
      marketCapRank: json['marketCapRank'],
      maxSupply: json['maxSupply'],
      name: json['name'],
      priceChangePercentage1hInCurrency:
          json['priceChangePercentage1hInCurrency'],
      priceChangePercentage24hInCurrency:
          json['priceChangePercentage24hInCurrency'],
      priceChangePercentage7dInCurrency:
          json['priceChangePercentage7dInCurrency'],
      priceChangePercentage14dInCurrency:
          json['priceChangePercentage14dInCurrency'],
      priceChangePercentage30dInCurrency:
          json['priceChangePercentage30dInCurrency'],
      priceChangePercentage200dInCurrency:
          json['priceChangePercentage200dInCurrency'],
      priceChangePercentage1yInCurrency:
          json['priceChangePercentage1yInCurrency'],
      priceChange24h: json['priceChange24h'],
      priceChangePercentage24h: json['priceChangePercentage24h'],
      roi: json['roi'] != null ? Roi?.fromJson(json['roi']) : null,
      sparklineIn7d: json['sparklineIn7d'] != null
          ? SparklineIn7d.fromJson(json['sparklineIn7d'])
          : null,
      symbol: json['symbol'],
      totalSupply: json['totalSupply'],
      totalVolume: json['totalVolume'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ath'] = ath;
    data['athChangePercentage'] = athChangePercentage;
    data['athDate'] = athDate;
    data['atl'] = atl;
    data['atlChangePercentage'] = atlChangePercentage;
    data['atlDate'] = atlDate;
    data['circulatingSupply'] = circulatingSupply;
    data['currentPrice'] = currentPrice;
    data['high24h'] = high24h;
    data['id'] = id;
    data['image'] = image;
    data['lastUpdated'] = lastUpdated;
    data['low24h'] = low24h;
    data['marketCap'] = marketCap;
    data['marketCapChange24h'] = marketCapChange24h;
    data['marketCapChangePercentage24h'] = marketCapChangePercentage24h;
    data['marketCapRank'] = marketCapRank;
    data['name'] = name;
    data['priceChangePercentage1hInCurrency'] =
        priceChangePercentage1hInCurrency;
    data['priceChangePercentage24hInCurrency'] =
        priceChangePercentage24hInCurrency;
    data['priceChangePercentage7dInCurrency'] =
        priceChangePercentage7dInCurrency;
    data['priceChangePercentage14dInCurrency'] =
        priceChangePercentage14dInCurrency;
    data['priceChangePercentage30dInCurrency'] =
        priceChangePercentage30dInCurrency;
    data['priceChangePercentage200dInCurrency'] =
        priceChangePercentage200dInCurrency;
    data['priceChangePercentage1yInCurrency'] =
        priceChangePercentage1yInCurrency;
    data['priceChange24h'] = priceChange24h;
    data['priceChangePercentage24h'] = priceChangePercentage24h;
    data['symbol'] = symbol;
    data['totalVolume'] = totalVolume;
    data['fullyDilutedValuation'] = fullyDilutedValuation;
    data['maxSupply'] = maxSupply;
    data['sparklineIn7d'] = sparklineIn7d;
    data['totalSupply'] = totalSupply;

    if (roi != null) {
      data['roi'] = roi!.toJson();
    }

    return data;
  }
}

class SparklineIn7d {
  List<double>? price;

  SparklineIn7d({this.price});

  factory SparklineIn7d.fromJson(Map<String, dynamic> json) {
    return SparklineIn7d(
      price: json['price'] != null ? List<double>.from(json['price']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (price != null) {
      data['price'] = price;
    }
    return data;
  }
}

class Roi {
  String? currency;
  double? percentage;
  double? times;

  Roi({this.currency, this.percentage, this.times});

  factory Roi.fromJson(Map<String, dynamic> json) {
    return Roi(
      currency: json['currency'],
      percentage: json['percentage'],
      times: json['times'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currency'] = currency;
    data['percentage'] = percentage;
    data['times'] = times;
    return data;
  }
}
