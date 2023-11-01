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
            fontFamily: FontPalette.pretendard,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Text(
          //2023-10-26T11:00:00Z -> 2023년 10월 26일 오후 12:00로 바꾸는 로직
          '${startDate.substring(0, 4)}년 ${startDate.substring(5, 7)}월 ${startDate.substring(8, 10)}일 ${startDate.substring(11, 16)} ~ ${endDate.substring(0, 4)}년 ${endDate.substring(5, 7)}월 ${endDate.substring(8, 10)}일  ${endDate.substring(11, 16)}',
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretendard,
            fontSize: 13,
          ),
        )
      ],
    ),
  );
}
