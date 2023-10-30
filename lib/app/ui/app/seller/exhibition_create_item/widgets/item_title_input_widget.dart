import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemTitleInputWidget() {
  final controller = Get.find<ExhibitionController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '작품의 이름을 알려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
          controller: controller.itemTitleController,
          maxLength: 46,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '이름',
            hintStyle: TextStyle(
              color: ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
            counterText: '',
          ),
        ),
      ),
    ],
  );
}
