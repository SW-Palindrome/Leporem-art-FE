import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';

class ExhibitionCreateStartScreen extends StatelessWidget {
  const ExhibitionCreateStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _startInquiry(),
            SizedBox(height: 40),
            _exhibitionPeriod(),
            SizedBox(height: 40),
            _exhibitionProcess(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NextButton(
                text: '시작하기',
                value: true,
                onTap: () =>
                    Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_EXHIBITION),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_startInquiry() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Text(
      '기획전을 등록할까요?',
      style: TextStyle(
        color: ColorPalette.black,
        fontFamily: FontPalette.pretenderd,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

_exhibitionPeriod() {
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

_exhibitionProcess() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기획전 등은 아래 순서로 진행돼요!',
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
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
                    fontFamily: FontPalette.pretenderd,
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
                fontFamily: FontPalette.pretenderd,
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
                    fontFamily: FontPalette.pretenderd,
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
                fontFamily: FontPalette.pretenderd,
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
                    fontFamily: FontPalette.pretenderd,
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
                fontFamily: FontPalette.pretenderd,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
