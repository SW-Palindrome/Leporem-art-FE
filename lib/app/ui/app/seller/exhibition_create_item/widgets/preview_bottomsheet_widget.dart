import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';
import '../../../widgets/next_button.dart';

previewBottomSheetWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Container(
    padding: EdgeInsets.fromLTRB(0, 16.5, 0, 20),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                '미리보기',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  'assets/icons/cancel.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    ColorPalette.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.file(
                  controller.itemImages[0],
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: NextButton(
                    text: '확인',
                    onTap: () {
                      Get.back();
                    },
                    value: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
