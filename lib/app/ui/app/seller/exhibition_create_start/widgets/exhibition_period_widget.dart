import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

exhibitionPeriodWidget(String startDate, String endDate) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: EdgeInsets.symmetric(horizontal: 16),
    width: double.infinity,
    decoration: BoxDecoration(
      color: ColorPalette.grey_1,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기획전 기간',
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '2023년 10월 24일 오후 12:00 ~ 10월 31일 오후 12:00',
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
            fontSize: 13,
          ),
        )
      ],
    ),
  );
}
