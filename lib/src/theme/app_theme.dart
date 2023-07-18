import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorPalette.grey_1,
    scaffoldBackgroundColor: ColorPalette.grey_1,
    appBarTheme: AppBarTheme(
      color: ColorPalette.grey_1,
      actionsIconTheme: IconThemeData(
        size: 24,
        color: ColorPalette.red,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}

class ColorPalette {
  static const Color purple = Color(0xff594bf8);
  static const Color red = Color(0xfff04452);
  static const Color yellow = Color(0xffffc164);
  static const Color black = Color(0xff191f28);
  static const Color grey_7 = Color(0xff333d4b);
  static const Color grey_6 = Color(0xff515a68);
  static const Color grey_5 = Color(0xff6d7684);
  static const Color grey_4 = Color(0xffadb3be);
  static const Color grey_3 = Color(0xffe5e7ec);
  static const Color grey_2 = Color(0xfff4f5f6);
  static const Color grey_1 = Color(0xfffafafa);
  static const Color white = Color(0xffffffff);
}
