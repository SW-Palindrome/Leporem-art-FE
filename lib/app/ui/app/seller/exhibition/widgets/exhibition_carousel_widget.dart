import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../theme/app_theme.dart';

final controller = Get.find<SellerExhibitionController>();
exhibitionCarouselWidget() {
  return CarouselSlider(
    items: [
      for (var exhibition in controller.exhibitions.value)
        _exhibitionCarouselItem(
          exhibition.id,
          exhibition.title,
          exhibition.coverImage,
          exhibition.seller,
          exhibition.startDate,
          exhibition.endDate,
        )
    ],
    options: CarouselOptions(
      enableInfiniteScroll: false,
      height: Get.height * 0.56,
    ),
  );
}

_exhibitionCarouselItem(
  int id,
  String title,
  String? coverImage,
  String seller,
  String startDate,
  String endDate,
) {
  return Padding(
    padding: EdgeInsets.only(right: 16),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorPalette.grey_4.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
          await controller.fetchExhibitionById(id);
          Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_START,
              arguments: {'exhibition_id': id});
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: coverImage ??
                    'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_cover_image/exhibition_default_cover_image.png',
                fit: BoxFit.cover,
                width: Get.width * 0.8,
                height: Get.height * 0.56,
              ),
            ),
            Positioned(
              left: 24,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.6,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                        '$startDate ~ ${endDate.substring(5)}',
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
      ),
    ),
  );
}
