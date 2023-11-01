import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

exhibitionProcessWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기획전 등록은 아래 순서로 진행돼요!',
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretendard,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ColorPalette.purple,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '1',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontFamily: FontPalette.pretendard,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              '기획전 소개 작성하기',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretendard,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ColorPalette.purple,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontFamily: FontPalette.pretendard,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              '작가 소개 작성하기',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretendard,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ColorPalette.purple,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '3',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontFamily: FontPalette.pretendard,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              '작품 등록하기',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretendard,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
