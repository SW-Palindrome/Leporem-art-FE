import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

designChangerWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    children: [
      Row(
        children: [
          Text(
            '배경',
            style: TextStyle(
              color: ColorPalette.grey_7,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5E1E1),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5E1E1),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5E1E1),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5E1E1),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Text(
            '폰트',
            style: TextStyle(
              color: ColorPalette.grey_7,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.grey_2,
            ),
            child: Row(
              children: [
                Text(
                  'Pretendard',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontFamily: FontPalette.pretenderd,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/arrow_down.svg',
                  width: 12,
                  height: 12,
                  colorFilter: ColorFilter.mode(
                    ColorPalette.grey_5,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
