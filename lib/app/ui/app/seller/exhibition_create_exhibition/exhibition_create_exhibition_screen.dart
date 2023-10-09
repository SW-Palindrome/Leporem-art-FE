import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/widgets/next_button.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import 'widgets/exhibition_seller_input_widget.dart';
import 'widgets/exhibition_thumbnail_input_widget.dart';
import 'widgets/exhibition_title_input_widget.dart';

class ExhibitionCreateExhibitionScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateExhibitionScreen({super.key});

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
          onPressed: () => Get.back(),
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
              NextButton(
                text: '저장하기',
                value: true,
                onTap: () => Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
