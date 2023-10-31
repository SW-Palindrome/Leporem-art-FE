import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../utils/log_analytics.dart';
import '../../../../theme/app_theme.dart';

itemImageInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '작품 사진을 올려주세요.',
        style: TextStyle(
          color: ColorPalette.black,
          fontWeight: FontWeight.w600,
          fontFamily: "PretendardVariable",
          fontStyle: FontStyle.normal,
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 16),
      Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  logAnalytics(name: "item_create_select_image");
                  if (controller.isItemSailEnabled.value == true) {
                    controller.selectImages(ImageType.itemSale);
                  } else {
                    controller.selectImages(ImageType.itemNotSale);
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorPalette.grey_4,
                  radius: Radius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                      ),
                      Positioned(
                        top: Get.height * 0.025,
                        child: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Get.height * 0.025,
                        child: Text(
                          '${controller.itemImages.length}/${controller.isItemSailEnabled.value ? 1 : 10}',
                          style: TextStyle(
                            color: ColorPalette.grey_6,
                            fontWeight: FontWeight.w600,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (var i = 0; i < controller.itemImages.length; i++)
                controller.isItemImagesLoading[i] == true
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
                                image: FileImage(controller.itemImages[i]),
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
                                controller.removeImage(ImageType.itemSale,
                                    index: i);
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
                          if (i == 0)
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorPalette.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '대표 이미지',
                                  style: TextStyle(
                                    color: ColorPalette.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "PretendardVariable",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
            ],
          ),
        ),
      ),
    ],
  );
}
