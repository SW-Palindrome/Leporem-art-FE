import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../theme/app_theme.dart';

class ExhibitionCreateSellerExampleScreen
    extends GetView<ExhibitionController> {
  const ExhibitionCreateSellerExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        isWhite: true,
        title: '템플릿 예시',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFFFFF4E3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ABOUT',
                    style: TextStyle(
                      color: ColorPalette.purple,
                      fontFamily: FontPalette.pretendard,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '공예쁨',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretendard,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Get.width),
                    child: CachedNetworkImage(
                      width: Get.width * 0.53,
                      height: Get.width * 0.53,
                      imageUrl:
                          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '- 한국도자 신진 작가 수상 (2023.03)\n- 서울 도자 페어 참석 (2022.12)\n- 한국대학교 공예학과 (2018.03 ~)',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
