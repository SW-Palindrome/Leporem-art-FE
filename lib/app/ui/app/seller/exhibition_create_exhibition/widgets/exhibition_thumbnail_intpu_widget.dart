import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/log_analytics.dart';
import '../../../../theme/app_theme.dart';

Widget exhibitionThumbnailInputWidget() {
  return Column(
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
  );
}
