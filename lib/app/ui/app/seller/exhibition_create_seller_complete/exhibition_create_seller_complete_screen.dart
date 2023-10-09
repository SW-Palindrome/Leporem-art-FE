import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_seller_template/widgets/seller_introduction_result_widget.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import '../exhibition_create_seller/widgets/seller_introduction_editor_widget.dart';

class ExhibitionCreateSellerCompleteScreen
    extends GetView<ExhibitionController> {
  const ExhibitionCreateSellerCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        isWhite: true,
        onTapLeadingIcon: () {
          Get.until((route) =>
              Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '작가 소개를 모두 작성했어요!\n이제 작품을 등록해주세요!',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              WidgetsToImage(
                  child: controller.isSellerTemplateUsed.value == true
                      ? sellerIntroductionResultWidget()
                      : sellerIntroductionEditorWidget(),
                  controller: controller.widgetsToImageController),
              Spacer(),
              NextButton(
                text: '이어서 작품 등록하기',
                value: true,
                onTap: () => Get.toNamed(
                  Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE,
                  arguments: {'exhibition_id': Get.arguments['exhibition_id']},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
