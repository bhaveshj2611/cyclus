import 'package:female_health/utils/app_color.dart';
import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  Color color = AppColor.darkBlue.withOpacity(0.7);
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  RoundTextField(
      {super.key,
      required this.hitText,
      required this.icon,
      this.controller,
      required this.color,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.rigtIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hitText,
            suffixIcon: rigtIcon,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: AppColor.darkBlue,
                )),
            hintStyle: TextStyle(color: color, fontSize: 12)),
      ),
    );
  }
}
