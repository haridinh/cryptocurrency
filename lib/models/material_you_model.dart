// Thiết lập giao diện Material

import 'package:cryptocurrency/main.dart';
import 'package:cryptocurrency/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Future<Color> getMaterialYouData() async {
  if (appStore.useMaterialYouTheme && await isAndroid12Above()) {
    themePrimaryColor = await getMaterialYouPrimaryColor() ?? secondaryColor;
  } else {
    themePrimaryColor = secondaryColor;
  }

  return themePrimaryColor;
}
