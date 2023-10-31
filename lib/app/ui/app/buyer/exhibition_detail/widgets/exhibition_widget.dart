import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/buyer/exhibition/buyer_exhibition_controller.dart';
import '../../../../../data/models/exhibition.dart';
import '../../../../theme/app_theme.dart';

exhibitionWidget() {
  final controller = Get.find<BuyerExhibitionController>();
  return Stack(
    children: [
      ClipRRect(
        child: CachedNetworkImage(
          imageUrl: controller.exhibition.coverImage,
          fit: BoxFit.cover,
          width: Get.width,
        ),
      ),
      Positioned(
        left: 24,
        bottom: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.exhibition.title,
              style: TextStyle(
                color: ColorPalette.white,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.exhibition.seller,
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 12,
                  color: ColorPalette.white.withOpacity(0.4),
                ),
                SizedBox(width: 12),
                Text(
                  '${controller.exhibition.startDate} ~ ${controller.exhibition.endDate.substring(5)}',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
