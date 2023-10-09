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
        GestureDetector(
          onTap: () {
            logAnalytics(name: "exhibition_item_select_image");
            controller.selectImages();
          },
          child: _buildImageWidget(controller),
        ),
      ],
    ),
  );
}

Widget _buildImageWidget(ExhibitionController controller) {
  if (controller.image.isEmpty) {
    // 이미지가 없을 때
    return DottedBorder(
      borderType: BorderType.RRect,
      color: ColorPalette.grey_4,
      radius: Radius.circular(4),
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
    );
  } else {
    if (controller.isImageLoading.value) {
      // 이미지 로딩 중일 때
      return SizedBox(
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
      );
    } else {
      // 이미지가 있을 때
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            height: Get.width * 0.2,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: FileImage(controller.image[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                logAnalytics(name: "item_create_remove_image");
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
      );
    }
  }
}
