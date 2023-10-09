import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../utils/log_analytics.dart';
import '../../../../theme/app_theme.dart';

Widget exhibitionThumbnailInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기획전을 대표할 썸네일 이미지를 올려주세요.',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                logAnalytics(name: "exhibition_item_select_image");
                controller.selectImages();
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: ColorPalette.grey_4,
                radius: Radius.circular(5),
                child: SizedBox(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/camera.svg',
                      colorFilter: ColorFilter.mode(
                        ColorPalette.grey_4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller.isImageLoading.value
                ? SizedBox(
                    height: Get.width * 0.2,
                    width: Get.width * 0.2,
                    child: Center(
                      child: SizedBox(
                        height: Get.width * 0.1,
                        width: Get.width * 0.1,
                        child: CircularProgressIndicator(
                          color: ColorPalette.grey_3,
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: FileImage(controller.image.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            logAnalytics(name: "exhibition_item_remove_image");
                            controller.removeImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: ColorPalette.black,
                            radius: 10,
                            child: SvgPicture.asset(
                              'assets/icons/cancel.svg',
                              colorFilter: ColorFilter.mode(
                                ColorPalette.white,
                                BlendMode.srcIn,
                              ),
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
        GestureDetector(
          onTap: () {
            logAnalytics(name: "exhibition_select_thumbnail");
          },
          child: DottedBorder(
            color: ColorPalette.grey_4,
            child: SizedBox(
              width: Get.width * 0.2,
              height: Get.width * 0.2,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    ColorPalette.grey_4,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
