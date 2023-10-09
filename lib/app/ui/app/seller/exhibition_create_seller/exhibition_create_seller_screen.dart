import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import 'widgets/seller_introduction_input_widget.dart';
import 'widgets/seller_thumbnail_input_widget.dart';
import 'widgets/template_select_widget.dart';

class ExhibitionCreateSellerScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () => Get.until((route) =>
              Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START),
        ),
        actions: [
          GestureDetector(
            onTap: () => print('미리보기'),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '미리보기',
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontFamily: FontPalette.pretenderd,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                templateSelectWidget(),
                SizedBox(height: 40),
                sellerThumbnailInputWidget(),
                SizedBox(height: 40),
                controller.isSellerTemplateUsed.value == true
                    ? sellerIntroductionInputWidget()
                    : SizedBox(),
                Spacer(),
                NextButton(
                  text: '저장하기',
                  value: controller.isValidSellerSave(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
