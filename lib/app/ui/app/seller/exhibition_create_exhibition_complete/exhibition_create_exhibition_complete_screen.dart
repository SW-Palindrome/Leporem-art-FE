import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import '../exhibition/widgets/exhibition_widget.dart';

class ExhibitionCreateExhibitionCompleteScreen extends StatelessWidget {
  const ExhibitionCreateExhibitionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        isWhite: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '기획전 소개를 모두 작성했어요!\n이제 작가 소개를 작성해주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretenderd,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              exhibitionWidget(
                title: '한가위 아름다운 단풍 기획전',
                imageUrl:
                    'http://www.knnews.co.kr/edb/nimages/2022/04/2022040416024296883.jpg',
                seller: '우유병 도예 작가',
                period: '2023.10.24 ~ 10.31',
                isTouchable: false,
              ),
              Spacer(),
              NextButton(
                text: '이어서 작가 소개 작성하기',
                value: true,
                onTap: () =>
                    Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_SELLER),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
