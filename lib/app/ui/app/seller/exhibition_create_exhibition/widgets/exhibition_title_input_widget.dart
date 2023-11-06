import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

Widget exhibitionTitleInputWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            '전시전 이름을 알려주세요.',
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
        ),
        child: TextField(
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 46,
          controller: controller.exhibitionTitleController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '이름',
            hintStyle: TextStyle(
              color: ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontSize: 16.0,
            ),
            counterText: '',
          ),
        ),
      ),
    ],
  );
}
