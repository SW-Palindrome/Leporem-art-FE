import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemSaleSelectWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '작품이 판매용인가요?',
        style: TextStyle(
          color: ColorPalette.black,
          fontFamily: FontPalette.pretendard,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.isItemSailEnabled.value = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: controller.isItemSailEnabled.value == true
                        ? ColorPalette.purple
                        : ColorPalette.grey_3,
                    width: 1,
                  ),
                  color: controller.isItemSailEnabled.value == true
                      ? ColorPalette.purple.withOpacity(0.1)
                      : ColorPalette.grey_1,
                ),
                child: Center(
                  child: Text(
                    '판매용입니다.',
                    style: TextStyle(
                      color: controller.isItemSailEnabled.value == true
                          ? ColorPalette.purple
                          : ColorPalette.grey_6,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.isItemSailEnabled.value = false;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: controller.isItemSailEnabled.value == false
                        ? ColorPalette.purple
                        : ColorPalette.grey_3,
                    width: 1,
                  ),
                  color: controller.isItemSailEnabled.value == false
                      ? ColorPalette.purple.withOpacity(0.1)
                      : ColorPalette.grey_1,
                ),
                child: Center(
                  child: Text(
                    '판매용이 아닙니다.',
                    style: TextStyle(
                      color: controller.isItemSailEnabled.value == false
                          ? ColorPalette.purple
                          : ColorPalette.grey_6,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
