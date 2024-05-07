import 'package:female_health/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppGradient {
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [AppColor.red, AppColor.orange, AppColor.yellow],
    stops: [0.0, 1.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient floatingBtnGradient = RadialGradient(
    colors: [Color(0xFFFFDEDE), Color(0xFFFF979A)],
  );

  static List<Color> grad1 = [AppColor.red, AppColor.orange, AppColor.yellow];
  static List<Color> grad4 = [
    AppColor.red,
    const Color.fromARGB(255, 255, 132, 0),
    // const Color.fromARGB(255, 141, 101, 0)
  ];
  static List<Color> grad3 = [AppColor.orange, AppColor.yellow];

  static List<Color> grad2 = [
    Colors.grey, Colors.grey.shade500,
    // AppColor.offwhite,
    // AppColor.yellow
  ];
}
