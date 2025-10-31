// Thông tin người dùng

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptocurrency/services/keys.dart';

class UserModel {
  String? uid;
  String? firstName;
  String? email;
  String? photoUrl;
  String? userRole;
  bool? isEmailLogin;
  bool? isTester;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? loginType;

  UserModel({
    this.createdAt,
    this.email,
    this.firstName,
    this.photoUrl,
    this.uid,
    this.updatedAt,
    this.isTester,
    this.userRole,
    this.isEmailLogin,
    this.loginType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createdAt: json[userKeys.createdAt],
      email: json[userKeys.email],
      firstName: json[userKeys.firstName],
      isEmailLogin: json[userKeys.isEmailLogin],
      photoUrl: json[userKeys.photoUrl],
      isTester: json[userKeys.isTester],
      userRole: json[userKeys.userRole],
      uid: json[userKeys.uid],
      updatedAt: json[userKeys.updatedAt],
      loginType: json[userKeys.loginType],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[userKeys.createdAt] = createdAt;
    data[userKeys.email] = email;
    data[userKeys.firstName] = firstName;
    data[userKeys.photoUrl] = photoUrl;
    data[userKeys.isEmailLogin] = isEmailLogin;
    data[userKeys.isTester] = isTester;
    data[userKeys.uid] = uid;
    data[userKeys.userRole] = userRole;
    data[userKeys.updatedAt] = updatedAt;
    data[userKeys.loginType] = loginType;
    return data;
  }
}
