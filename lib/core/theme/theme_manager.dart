import 'package:chatia/core/styles/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_color.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: ColorManager.whiteColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: ColorManager.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: 19),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  iconTheme: IconThemeData(color: ColorManager.primaryColor),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(ColorManager.primaryColor))),
  textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      bodyMedium: const TextStyle(
          color: ColorManager.greyColor,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodySmall: const TextStyle(
          color: ColorManager.blackColor,
          fontSize: 12,
          fontWeight: FontWeight.w500)),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: getRegularStyle(color: ColorManager.lightPrimary),
    prefixIconColor: ColorManager.primaryColor,
    suffixIconColor: ColorManager.primaryColor,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorManager.greyColor,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorManager.greyColor,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: ColorManager.primaryColor)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.errorColor)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: ColorManager.whiteColor,
    selectedItemColor: ColorManager.primaryColor,
    unselectedItemColor: ColorManager.greyColor,
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
  ),
);

///////////////////-------------------darkkk----------------------///////////////

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: ColorManager.backgroundColor,
  appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.backgroundColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(
          color: ColorManager.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 19),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.backgroundColor,
          statusBarIconBrightness: Brightness.light)),
  iconTheme: IconThemeData(color: ColorManager.primaryColor),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(ColorManager.primaryColor))),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: getRegularStyle(color: ColorManager.greyColor),
    prefixIconColor: ColorManager.primaryColor,
    suffixIconColor: ColorManager.primaryColor,
    hintStyle: getRegularStyle(color: ColorManager.greyColor),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorManager.greyColor,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorManager.greyColor,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: ColorManager.primaryColor)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.errorColor)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorManager.primaryColor),
        foregroundColor:
            const MaterialStatePropertyAll(ColorManager.whiteColor),
        textStyle: MaterialStatePropertyAll(
          getMediumStyle(color: ColorManager.whiteColor),
        )),
  ),
  textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      bodyMedium: const TextStyle(
          color: ColorManager.whiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodySmall: const TextStyle(
          color: ColorManager.greyColor,
          fontSize: 12,
          fontWeight: FontWeight.w500)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: ColorManager.backgroundColor,
    selectedItemColor: ColorManager.primaryColor,
    unselectedItemColor: ColorManager.greyColor,
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
  ),
);
