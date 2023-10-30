import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemDescriptionInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '작품에 대한 설명을 알려주세요.',
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: Get.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ColorPalette.grey_4,
            width: 1,
          ),
        ),
        child: TextField(
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 255,
          maxLines: null,
          controller: controller.itemDescriptionController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '작품에 대한 상세한 설명을 적어주세요.',
            hintStyle: TextStyle(
              color: ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ],
  );
}
