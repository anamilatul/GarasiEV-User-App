import 'package:flutter/material.dart';

class ColorResources {
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffF1F1F1);
  static const Color red = Color(0xFFD32F2F);
  static const Color yellow = Color(0xFFFFAA47);
  static const Color green = Color(0xff23CB60);

  static const Color hintTextColor = Color(0xff9E9E9E);
  static const Color lightSkyBlue = Color(0xff8DBFF6);
  static const Color harlequin = Color(0xff3FCC01);
  static const Color cris = Color(0xffE2206B);
  static const Color gainsBg = Color(0xffE6E6E6);
  static const Color textBg = Color(0xffF3F9FF);
  static const Color iconBg = Color(0xffF9F9F9);
  static const Color homeBg = Color(0xffF0F0F0);
  static const Color imageBg = Color(0xffE2F0FF);
  static const Color lowGreen = Color(0xffEFF6FE);

  static const Map<int, Color> colorMap = {
    50: Color(0x103abaf4),
    100: Color(0x203abaf4),
    200: Color(0x303abaf4),
    300: Color(0x403abaf4),
    400: Color(0x503abaf4),
    500: Color(0x603abaf4),
    600: Color(0x703abaf4),
    700: Color(0x803abaf4),
    800: Color(0x903abaf4),
    900: Color(0xff3abaf4),
  };
  static const MaterialColor primaryMaterial =
      MaterialColor(0xFF3abaf4, colorMap);
}
