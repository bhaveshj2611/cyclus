import 'package:female_health/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

toast(String msg) {
  return Toast.show(
      backgroundColor: AppColor.offwhite,
      duration: 3,
      msg,
      backgroundRadius: 5,
      textStyle: const TextStyle(color: AppColor.darkBlue));
}
