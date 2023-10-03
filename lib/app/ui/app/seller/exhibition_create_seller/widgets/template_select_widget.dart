import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/app_theme.dart';

Widget templateSelectWidget() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ColorPalette.grey_1,
      border: Border.all(color: ColorPalette.grey_3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SvgPicture.asset('assets/icons/checkbox_unselect.svg'),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작가 소개 템플릿을 사용할게요!',
              style: TextStyle(
                color: ColorPalette.grey_6,
                fontFamily: FontPalette.pretenderd,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 6),
            Text(
              '템플릿 예시 보기',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: ColorPalette.grey_5,
                fontFamily: FontPalette.pretenderd,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
