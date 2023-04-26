import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: fontWeight);
}

// light style

TextStyle getLightStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w300, color);
}

// regular style

TextStyle getRegularStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w400, color);
}

// medium style

TextStyle getMediumStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w500, color);
}

// semibold style

TextStyle getSemiBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w600, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w700, color);
}
