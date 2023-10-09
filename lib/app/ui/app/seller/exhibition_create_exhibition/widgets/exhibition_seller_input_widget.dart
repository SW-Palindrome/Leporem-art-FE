import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

Widget exhibitionSellerInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            '작가님의 이름을 알려주세요.',
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretenderd,
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
          maxLength: 46,
          controller: controller.sellerNameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '이름',
            hintStyle: TextStyle(
              color: ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretenderd,
              fontSize: 16.0,
            ),
            counterText: '',
          ),
        ),
      ),
    ],
  );
}
