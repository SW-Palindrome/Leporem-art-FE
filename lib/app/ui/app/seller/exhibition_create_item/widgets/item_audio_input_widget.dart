import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemAudioInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '작품에 포함할 음성을 올려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            Text(
              '(선택, 4MB 제한)',
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
      if (controller.itemAudio.isEmpty == true)
        GestureDetector(
          onTap: () {
            controller.selectAudio();
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
                  child: SvgPicture.asset(
                    'assets/icons/voice.svg',
                    colorFilter: ColorFilter.mode(
                      ColorPalette.grey_4,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      if (controller.itemAudio.isNotEmpty == true)
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: Get.width * 0.2,
              width: Get.width * 0.2,
              decoration: BoxDecoration(
                color: ColorPalette.grey_1,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: ColorPalette.grey_3,
                  width: 1,
                ),
              ),
              child: Text(
                controller.itemAudio[0].path.split('/').last,
                style: TextStyle(
                  color: ColorPalette.grey_6,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 11,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.removeAudio();
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
  );
}
