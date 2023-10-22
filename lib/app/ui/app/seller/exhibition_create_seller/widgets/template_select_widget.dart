import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../theme/app_theme.dart';
import '../../../widgets/bottom_sheet.dart';

Widget templateSelectWidget() {
  final controller = Get.find<ExhibitionController>();

  return Obx(
    () => Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: controller.isSellerTemplateUsed.value == true
            ? ColorPalette.purple.withOpacity(0.1)
            : ColorPalette.grey_1,
        border: Border.all(
          color: controller.isSellerTemplateUsed.value == true
              ? ColorPalette.purple
              : ColorPalette.grey_3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                MyBottomSheet(
                  height: Get.height * 0.3,
                  title: '템플릿 사용을 변경 할까요?',
                  description: '입력했던 정보가 사라집니다.',
                  buttonType: BottomSheetType.twoButton,
                  leftButtonText: '취소',
                  onLeftButtonPressed: () {
                    Get.back();
                  },
                  rightButtonText: '변경',
                  onRightButtonPressed: () {
                    controller.sellerImage.clear();
                    controller.isSellerTemplateUsed.value =
                        !controller.isSellerTemplateUsed.value;
                    Get.back();
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
            child: controller.isSellerTemplateUsed.value == true
                ? SvgPicture.asset('assets/icons/checkbox_select.svg')
                : SvgPicture.asset('assets/icons/checkbox_unselect.svg'),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '작가 소개 템플릿을 사용할게요!',
                style: TextStyle(
                  color: ColorPalette.grey_6,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_SELLER_EXAMPLE);
                },
                child: Text(
                  '템플릿 예시 보기',
                  style: TextStyle(
                    color: ColorPalette.grey_5,
                    fontSize: 12,
                    fontFamily: FontPalette.pretendard,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
