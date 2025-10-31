// Danh mục đầu tư của người dùng

import 'package:cloud_firestore/cloud_firestore.dart';

class PortfolioModel {
  Timestamp? createdDate;
  Timestamp? date;
  String? name;
  String? coinIcon;
  String? coinSymbol;
  String? buyInCurrency;
  String? coinId;
  num? noOfUnits;
  String? notes;
  num? perCoin;
  num? price;
  String? uid;
  Timestamp? updatedDate;
  List<dynamic>? currentCurrencyList;

  PortfolioModel({
    this.createdDate,
    this.buyInCurrency,
    this.coinIcon,
    this.coinSymbol,
    this.date,
    this.name,
    this.coinId,
    this.noOfUnits,
    this.notes,
    this.perCoin,
    this.price,
    this.uid,
    this.updatedDate,
    this.currentCurrencyList,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      createdDate: json['createdDate'],
      date: json['date'],
      name: json['name'],
      coinIcon: json['coinIcon'],
      coinSymbol: json['coinSymbol'],
      buyInCurrency: json['buyInCurrency'],
      coinId: json['coinId'],
      noOfUnits: json['noOfUnits'],
      notes: json['notes'],
      perCoin: json['perCoin'],
      price: json['price'],
      uid: json['uid'],
      updatedDate: json['updatedDate'],
      currentCurrencyList: json['currentCurrencyList'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['date'] = date;
    data['name'] = name;
    data['coinIcon'] = coinIcon;
    data['coinId'] = coinId;
    data['coinSymbol'] = coinSymbol;
    data['buyInCurrency'] = buyInCurrency;
    data['coinIcon'] = coinIcon;
    data['noOfUnits'] = noOfUnits;
    data['notes'] = notes;
    data['perCoin'] = perCoin;
    data['price'] = price;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['currentCurrencyList'] = currentCurrencyList;
    return data;
  }
}
