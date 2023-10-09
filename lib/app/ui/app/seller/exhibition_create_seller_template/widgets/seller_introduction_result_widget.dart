import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

sellerIntroductionResultWidget() {
  final controller = Get.find<ExhibitionController>();
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: ColorPalette.white,
      border: Border.all(
        color: ColorPalette.grey_2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ABOUT',
          style: TextStyle(
            color: ColorPalette.purple,
            fontFamily: FontPalette.pretenderd,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          controller.exhibitions
              .firstWhere(
                  (element) => element.id == Get.arguments['exhibition_id'])
              .seller,
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(Get.width),
          child: Container(
            width: Get.width * 0.53,
            height: Get.width * 0.53,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(controller.sellerImage[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          controller.sellerIntroduction.value,
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
