import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

noticeWidget(String date, String title, String content) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ColorPalette.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                color: ColorPalette.grey_5,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          child: SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
            width: 16,
            height: 16,
          ),
        ),
      ],
    ),
  );
}
