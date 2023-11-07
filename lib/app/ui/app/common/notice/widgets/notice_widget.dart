import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/common/notice/notice_controller.dart';
import '../../../../theme/app_theme.dart';

noticeWidget(int index) {
  final controller = Get.find<NoticeController>();
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ColorPalette.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
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
        GestureDetector(
          onTap: () {
            controller.isExpanded[index] = !controller.isExpanded[index];
          },
          child: SvgPicture.asset(
            controller.isExpanded[index] == true
                ? 'assets/icons/arrow_up.svg'
                : 'assets/icons/arrow_down.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
            width: 16,
            height: 16,
          ),
        ),
      ],
    ),
  );
}
