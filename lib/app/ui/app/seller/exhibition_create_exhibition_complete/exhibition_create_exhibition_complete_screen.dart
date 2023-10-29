import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/exhibition/exhibition_controller.dart';

import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import '../exhibition/widgets/exhibition_widget.dart';

class ExhibitionCreateExhibitionCompleteScreen
    extends GetView<ExhibitionController> {
  const ExhibitionCreateExhibitionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.until((route) =>
              Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START);
        },
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
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              exhibitionWidget(
                exhibitionId: Get.arguments['exhibition_id'],
                title: controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .title,
                imageUrl: controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .coverImage,
                seller: controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .seller,
                period:
                    '${controller.exhibitions.firstWhere((element) => element.id == Get.arguments['exhibition_id']).startDate} ~ ${controller.exhibitions.firstWhere((element) => element.id == Get.arguments['exhibition_id']).endDate}',
                isTouchable: false,
              ),
              Spacer(),
              NextButton(
                text: '이어서 작가 소개 작성하기',
                value: true,
                onTap: () async {
                  await controller.fetchExhibitionArtistById(
                      Get.arguments['exhibition_id']);
                  Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_SELLER,
                    arguments: {
                      'exhibition_id': Get.arguments['exhibition_id']
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
