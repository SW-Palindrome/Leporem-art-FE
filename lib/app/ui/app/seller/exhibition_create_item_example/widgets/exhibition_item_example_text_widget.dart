import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

exhibitionItemExampleTextWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '작품에 사용할 템플릿을 선택해주세요.',
          style: TextStyle(
            color: ColorPalette.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '좌우로 넘겨보며 템플릿을 구경해보세요!',
          style: TextStyle(
            color: ColorPalette.grey_5,
            fontFamily: FontPalette.pretendard,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
