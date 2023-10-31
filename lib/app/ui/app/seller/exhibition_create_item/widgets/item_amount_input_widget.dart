import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemAmountInputWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          '수량',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: FontPalette.pretendard,
            fontStyle: FontStyle.normal,
            fontSize: 16.0,
          ),
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () => controller.decreaseAmount(),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.grey_2,
              ),
              child: SvgPicture.asset(
                'assets/icons/minus.svg',
                colorFilter: ColorFilter.mode(
                  ColorPalette.grey_6,
                  BlendMode.srcIn,
                ),
                width: 16.0,
              ),
            ),
          ),
          SizedBox(width: Get.width * 0.02),
          Container(
            height: Get.width * 0.1,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorPalette.grey_4,
                width: 1,
              ),
            ),
            child: Obx(
              () => Center(
                child: Text(
                  '${controller.amount.value}',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Get.width * 0.02),
          GestureDetector(
            onTap: () => controller.increaseAmount(),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.grey_2,
              ),
              child: SvgPicture.asset(
                'assets/icons/plus.svg',
                colorFilter: ColorFilter.mode(
                  ColorPalette.grey_6,
                  BlendMode.srcIn,
                ),
                width: 16.0,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
