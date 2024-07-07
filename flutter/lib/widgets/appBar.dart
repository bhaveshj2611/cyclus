import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

buildAppBar({
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    elevation: 8,
    shadowColor: AppColor.orange.withOpacity(0.5),
    backgroundColor: AppColor.red,
    iconTheme: const IconThemeData(color: AppColor.white),
    toolbarHeight: 65,
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/logo/notification.png',
              color: AppColor.offwhite,
            )),
      ),
    ],
    leading: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Image.asset(ImagePath.appLogo, width: 120),
    ),
  );
}
