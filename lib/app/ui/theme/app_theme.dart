import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorPalette.grey_1,
    scaffoldBackgroundColor: ColorPalette.grey_1,
    appBarTheme: AppBarTheme(
      centerTitle: true,
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
  static const Color orange = Color(0xffff847c);
  static const Color green = Color(0xff41d9a2);
  static const Color blue = Color(0xff4a9dff);
  static const Color pink = Color(0xfffa9ae5);
  static const Color violet = Color(0xff9d00e7);
  static const Color black = Color(0xff191f28);
  static const Color grey_7 = Color(0xff333d4b);
  static const Color grey_6 = Color(0xff515a68);
  static const Color grey_5 = Color(0xff6d7684);
  static const Color grey_4 = Color(0xffadb3be);
  static const Color grey_3 = Color(0xffe5e7ec);
  static const Color grey_2 = Color(0xfff4f5f6);
  static const Color grey_1 = Color(0xfffafafa);
  static const Color white = Color(0xffffffff);
  //gradient: LinearGradient(
//                   begin: Alignment(1.00, -0.07),
//                   end: Alignment(-1, 0.07),
//                   colors: [Color(0xFF9C00E6), Color(0xFF594BF8)],
//                 ), 와 같은 색깔을 정의
  static const LinearGradient gradientPurple = LinearGradient(
    begin: Alignment(1.00, -0.07),
    end: Alignment(-1, 0.07),
    colors: [Color(0xFF9C00E6), Color(0xFF594BF8)],
  );
}

class FontPalette {
  static const String pretendard = "Pretendard";
  static const String gmarket = "GmarketSans";
  static const String chosun = "ChosunCentennial";
  static const String kbo = "KBODiaGothic";
}
