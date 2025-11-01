import 'package:cryptocurrency/screens/man_hinh_bang_dieu_khien.dart';
import 'package:cryptocurrency/screens/man_hinh_cai_dat_mac_dinh.dart';
import 'package:cryptocurrency/screens/man_hinh_chi_tiet_coin.dart';
import 'package:cryptocurrency/screens/man_hinh_chi_tiet_coin2.dart';
import 'package:cryptocurrency/screens/man_hinh_chi_tiet_phai_sinh.dart';
import 'package:cryptocurrency/screens/man_hinh_chi_tiet_san_giao_dich.dart';
import 'package:cryptocurrency/screens/man_hinh_chinh_sua_ho_so.dart';
import 'package:cryptocurrency/screens/man_hinh_chon_don_vi_tien_te.dart';
import 'package:cryptocurrency/screens/man_hinh_cong_ty.dart';
import 'package:cryptocurrency/screens/man_hinh_danh_muc.dart';
import 'package:cryptocurrency/screens/man_hinh_danh_sach_coin.dart';
import 'package:cryptocurrency/screens/man_hinh_doi_mat_khau.dart';
import 'package:cryptocurrency/screens/man_hinh_phai_sinh.dart';
import 'package:cryptocurrency/screens/man_hinh_san_giao_dich.dart';
import 'package:cryptocurrency/screens/man_hinh_them_danh_muc.dart';
import 'package:cryptocurrency/screens/man_hinh_them_tien_ao.dart';
import 'package:cryptocurrency/screens/man_hinh_them_coin_vao_danh_muc.dart';
import 'package:flutter/material.dart';
import 'package:cryptocurrency/store/app_store.dart';

import 'package:cryptocurrency/screens/man_hinh_gioi_thieu.dart';

AppStore appStore = AppStore();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ExchangesDetailScreen(
        data: ExchangeData(id: 'binance', name: 'Binance Exchange'),
      ),
    );
  }
}
