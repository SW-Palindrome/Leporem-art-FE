import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../utils/log_analytics.dart';
import '../../../../theme/app_theme.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/next_button.dart';

designChangerWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    children: [
      Row(
        children: [
          Text(
            '배경',
            style: TextStyle(
              color: ColorPalette.grey_7,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          Row(
            children: [
              for (int index = 0; index < controller.colorList.length; index++)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectedSellerIntroductionColor.value =
                            index;
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.selectedSellerIntroductionColor
                                        .value ==
                                    index
                                ? ColorPalette.purple
                                : ColorPalette.grey_2,
                            width: 2,
                          ),
                          color: Color(controller.colorList[index]),
                        ),
                      ),
                    ),
                    if (index != 9) SizedBox(width: 5),
                  ],
                ),
            ],
          )
        ],
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Text(
            '폰트',
            style: TextStyle(
              color: ColorPalette.grey_7,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              '폰트',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                        SizedBox(height: 20),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                logAnalytics(
                                    name: "exhibition_font_change",
                                    parameters: {"font": "pretendard"});
                                controller
                                    .selectedSellerIntroductionFont.value = 0;
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Pretendard',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .selectedSellerIntroductionFont
                                                    .value ==
                                                0
                                            ? ColorPalette.purple
                                            : ColorPalette.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    controller.selectedSellerIntroductionFont
                                                .value ==
                                            0
                                        ? SvgPicture.asset(
                                            'assets/icons/check.svg',
                                            height: 24,
                                            width: 24,
                                            colorFilter: ColorFilter.mode(
                                                ColorPalette.purple,
                                                BlendMode.srcIn),
                                          )
                                        : SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: ColorPalette.grey_2, thickness: 2),
                            GestureDetector(
                              onTap: () {
                                logAnalytics(
                                    name: "exhibition_font_change",
                                    parameters: {"font": "gmarket"});
                                controller
                                    .selectedSellerIntroductionFont.value = 1;
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Gmarket Sans',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .selectedSellerIntroductionFont
                                                    .value ==
                                                1
                                            ? ColorPalette.purple
                                            : ColorPalette.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    controller.selectedSellerIntroductionFont
                                                .value ==
                                            1
                                        ? SvgPicture.asset(
                                            'assets/icons/check.svg',
                                            height: 24,
                                            width: 24,
                                            colorFilter: ColorFilter.mode(
                                                ColorPalette.purple,
                                                BlendMode.srcIn),
                                          )
                                        : SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: ColorPalette.grey_2, thickness: 2),
                            GestureDetector(
                              onTap: () {
                                logAnalytics(
                                    name: "exhibition_font_change",
                                    parameters: {"font": "kbo"});
                                controller
                                    .selectedSellerIntroductionFont.value = 2;
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'KBO 다이아 고딕체',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .selectedSellerIntroductionFont
                                                    .value ==
                                                2
                                            ? ColorPalette.purple
                                            : ColorPalette.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    controller.selectedSellerIntroductionFont
                                                .value ==
                                            2
                                        ? SvgPicture.asset(
                                            'assets/icons/check.svg',
                                            height: 24,
                                            width: 24,
                                            colorFilter: ColorFilter.mode(
                                                ColorPalette.purple,
                                                BlendMode.srcIn),
                                          )
                                        : SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: ColorPalette.grey_2, thickness: 2),
                            GestureDetector(
                              onTap: () {
                                logAnalytics(
                                    name: "exhibition_font_change",
                                    parameters: {"font": "chosun"});
                                controller
                                    .selectedSellerIntroductionFont.value = 3;
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      '조선 100년체',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: controller
                                                    .selectedSellerIntroductionFont
                                                    .value ==
                                                3
                                            ? ColorPalette.purple
                                            : ColorPalette.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    controller.selectedSellerIntroductionFont
                                                .value ==
                                            3
                                        ? SvgPicture.asset(
                                            'assets/icons/check.svg',
                                            height: 24,
                                            width: 24,
                                            colorFilter: ColorFilter.mode(
                                                ColorPalette.purple,
                                                BlendMode.srcIn),
                                          )
                                        : SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller
                                      .selectedSellerIntroductionFont.value = 0;
                                  controller.displayedSellerIntroductionFont
                                      .value = 0;
                                  Get.back();
                                },
                                child: Container(
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.isFontResetValid()
                                            ? ColorPalette.grey_7
                                            : ColorPalette.grey_3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/refresh.svg',
                                          height: 20,
                                          width: 20,
                                          colorFilter: ColorFilter.mode(
                                              controller.isFontResetValid()
                                                  ? ColorPalette.grey_7
                                                  : ColorPalette.grey_4,
                                              BlendMode.srcIn),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          '초기화',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: controller.isFontResetValid()
                                                ? ColorPalette.grey_7
                                                : ColorPalette.grey_4,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            NextButton(
                              text: '적용하기',
                              value: controller.isApplyValid(),
                              onTap: () {
                                logAnalytics(name: "exhibition_font_apply");
                                controller.applyFont();
                                Get.back();
                              },
                              width: Get.width * 0.5,
                            ),
                          ],
                        ),
                      ],
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
            child: Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorPalette.grey_2,
              ),
              child: Obx(
                () => Row(
                  children: [
                    if (controller.displayedSellerIntroductionFont.value == 0)
                      Text(
                        'Pretendard',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: FontPalette.pretendard,
                          fontSize: 14,
                        ),
                      ),
                    if (controller.displayedSellerIntroductionFont.value == 1)
                      Text(
                        'Gmarket Sans',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: FontPalette.gmarket,
                          fontSize: 14,
                        ),
                      ),
                    if (controller.displayedSellerIntroductionFont.value == 2)
                      Text(
                        'KBO 다이아 고딕체',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: FontPalette.kbo,
                          fontSize: 14,
                        ),
                      ),
                    if (controller.displayedSellerIntroductionFont.value == 3)
                      Text(
                        '조선 100년체',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: FontPalette.chosun,
                          fontSize: 14,
                        ),
                      ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/arrow_down.svg',
                      width: 12,
                      height: 12,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.grey_5,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
