import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

exhibitionItemCompleteTextWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '작품을 등록해주세요.',
        style: TextStyle(
          color: ColorPalette.black,
          fontFamily: FontPalette.pretendard,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(height: 12),
      Text(
        '작품은 최소 1개, 최대 10개까지 등록 가능해요.',
        style: TextStyle(
          color: ColorPalette.grey_5,
          fontFamily: FontPalette.pretendard,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    ],
  );
}
