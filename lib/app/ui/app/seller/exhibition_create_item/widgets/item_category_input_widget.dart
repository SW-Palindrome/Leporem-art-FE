import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemCategoryInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '작품의 카테고리를 알려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.bottomSheet(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            '작품 종류',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.black,
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
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  ColorPalette.black, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.width * 0.1),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (int i = 0;
                              i < controller.categoryTypes.length;
                              i++)
                            GestureDetector(
                              onTap: () {
                                controller.changeSelectedCategoryType(i);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedCategoryType.value[i]
                                          ? ColorPalette.purple
                                          : Colors.white,
                                  border: Border.all(
                                      color: controller
                                              .selectedCategoryType.value[i]
                                          ? ColorPalette.purple
                                          : ColorPalette.grey_3),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  controller.categoryTypes[i],
                                  style: TextStyle(
                                    color:
                                        controller.selectedCategoryType.value[i]
                                            ? Colors.white
                                            : ColorPalette.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: Get.width * 0.1),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
          );
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: controller.selectedCategoryType.value.contains(true) ==
                          false
                      ? ColorPalette.grey_3
                      : ColorPalette.purple),
              borderRadius: BorderRadius.circular(20),
              color:
                  controller.selectedCategoryType.value.contains(true) == false
                      ? ColorPalette.white
                      : ColorPalette.purple,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.selectedCategoryType.value.contains(true) == false
                      ? '카테고리 선택'
                      : (controller.selectedCategoryType
                                  .where((element) => element == true)
                                  .length ==
                              1
                          ? controller.categoryTypes[controller
                              .selectedCategoryType.value
                              .indexOf(true)]
                          : controller.selectedCategoryType.value
                              .where((element) => element == true)
                              .length
                              .toString()),
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        controller.selectedCategoryType.value.contains(true) ==
                                false
                            ? ColorPalette.grey_6
                            : ColorPalette.white,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    controller.resetSelectedCategoryType();
                  },
                  child: SvgPicture.asset(
                    controller.selectedCategoryType.value.contains(true) ==
                            false
                        ? 'assets/icons/arrow_down.svg'
                        : 'assets/icons/cancel.svg',
                    height: 10,
                    width: 10,
                    colorFilter: ColorFilter.mode(
                      controller.selectedCategoryType.value.contains(true) ==
                              false
                          ? ColorPalette.grey_4
                          : ColorPalette.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
