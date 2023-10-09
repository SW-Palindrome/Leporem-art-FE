import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

emptyExhibitionWidget() {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 144),
        Image.asset(
          'assets/images/rabbit.png',
          height: 200,
        ),
        SizedBox(height: 24),
        Text(
          '아직 등록된 기획전이 없어요.',
          style: TextStyle(
            fontSize: 16,
            color: ColorPalette.grey_5,
            fontFamily: FontPalette.pretendard,
          ),
        ),
      ],
    ),
  );
}
