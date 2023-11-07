import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/common/notice/notice_controller.dart';
import '../../../../theme/app_theme.dart';

final controller = Get.find<NoticeController>();

noticeWidget(int index) {
  return Obx(
    () => GestureDetector(
      onTap: () {
        controller.isExpanded[index] = !controller.isExpanded[index];
      },
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: controller.isExpanded[index] == true
            ? _expandedWidget(index)
            : _unExpandedWidget(index),
      ),
    ),
  );
}

_expandedWidget(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.notices[index].date,
                style: TextStyle(
                  color: ColorPalette.grey_5,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              Text(
                controller.notices[index].title,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          SvgPicture.asset(
            'assets/icons/arrow_up.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
            width: 16,
            height: 16,
          ),
        ],
      ),
      SizedBox(height: 16),
      Divider(
        color: ColorPalette.grey_3,
        height: 1,
      ),
      SizedBox(height: 16),
      Text(
        controller.notices[index].content,
        style: TextStyle(
          color: ColorPalette.black,
          fontWeight: FontWeight.w400,
          fontFamily: FontPalette.pretendard,
          fontSize: 12,
        ),
      ),
    ],
  );
}

_unExpandedWidget(int index) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.notices[index].date,
            style: TextStyle(
              color: ColorPalette.grey_5,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8),
          Text(
            controller.notices[index].title,
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
            ),
          ),
        ],
      ),
      Spacer(),
      controller.isExpanded[index] == true
          ? SvgPicture.asset(
              'assets/icons/arrow_up.svg',
              colorFilter:
                  ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
              width: 16,
              height: 16,
            )
          : SvgPicture.asset(
              'assets/icons/arrow_down.svg',
              colorFilter:
                  ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
              width: 16,
              height: 16,
            ),
    ],
  );
}
