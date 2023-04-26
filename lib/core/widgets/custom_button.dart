import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/styles_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, this.icon, required this.onTap});

  final String text;
  final Widget? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorManager.primaryColor,
                  const Color.fromARGB(255, 201, 10, 201),
                ])),
        child: Text(
          text,
          style: getMediumStyle(color: ColorManager.whiteColor),
        ),
      ),
    );
  }
}
