import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemFlopInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '숏츠를 올려주세요',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            Text(
              '(영상 30초 제한)',
              style: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.selectVideo();
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
                      'assets/icons/flop.svg',
                      colorFilter: ColorFilter.mode(
                        ColorPalette.grey_4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Get.height * 0.025,
                    child: Text(
                      '${controller.itemVideo.length}/1',
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
          controller.isVideoLoading.value == true
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
              : (controller.thumbnail.value != null)
                  ? Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.memory(
                              controller.thumbnail.value!,
                              fit: BoxFit.cover,
                              height: Get.width * 0.2,
                              width: Get.width * 0.2,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              controller.removeVideo();
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
                    )
                  : Container(),
        ],
      ),
    ],
  );
}
