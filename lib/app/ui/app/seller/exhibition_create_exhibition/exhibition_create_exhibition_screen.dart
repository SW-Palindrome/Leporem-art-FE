import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/widgets/next_button.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/my_app_bar.dart';
import 'widgets/exhibition_seller_input_widget.dart';
import 'widgets/exhibition_thumbnail_input_widget.dart';
import 'widgets/exhibition_title_input_widget.dart';

class ExhibitionCreateExhibitionScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        isWhite: true,
        appBarType: AppBarType.backAppBar,
        title: '기획전 소개 작성',
        onTapLeadingIcon: () {
          Get.bottomSheet(
            MyBottomSheet(
              height: Get.height * 0.3,
              title: '뒤로 갈까요?',
              description: '입력했던 정보가 사라집니다.',
              buttonType: BottomSheetType.twoButton,
              leftButtonText: '취소',
              onLeftButtonPressed: () {
                Get.back();
              },
              rightButtonText: '뒤로가기',
              onRightButtonPressed: () {
                controller.exhibitionInfoReset();
                Get.until((route) =>
                    Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START);
              },
              onCloseButtonPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              exhibitionThumbnailInputWidget(),
              SizedBox(height: 40),
              exhibitionTitleInputWidget(),
              SizedBox(height: 40),
              exhibitionSellerInputWidget(),
              Spacer(),
              Obx(
                () => NextButton(
                  text: '저장하기',
                  value: controller.isValidExhibitionSave(),
                  onTap: () => Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE,
                    arguments: {
                      "exhibition_id": Get.arguments["exhibition_id"]
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
