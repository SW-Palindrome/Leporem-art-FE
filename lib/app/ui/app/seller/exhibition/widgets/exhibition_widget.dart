import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../theme/app_theme.dart';

exhibitionWidget({
  required String title,
  required String imageUrl,
  required String seller,
  required String period,
  required int exhibitionId,
  bool isTouchable = true,
}) {
  final controller = Get.find<SellerExhibitionController>();
  return GestureDetector(
    onTap: isTouchable
        ? () async {
            await controller.fetchExhibitionById(exhibitionId);
            Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_START,
                arguments: {'exhibition_id': exhibitionId});
          }
        : null,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorPalette.white,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    seller,
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
                    period,
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
    ),
  );
}
