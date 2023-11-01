import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/buyer/exhibition/buyer_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

final controller = Get.find<BuyerExhibitionController>();
sellerWidget() {
  return controller.exhibitionArtist.value!.isUsingTemplate == true
      ? _sellerWithTemplateWidget()
      : _sellerWithoutTemplateWidget();
}

_sellerWithTemplateWidget() {
  int colorIndex =
      int.parse(controller.exhibitionArtist.value!.backgroundColor);
  int fontIndex = int.parse(controller.exhibitionArtist.value!.fontFamily);
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Color(controller.colorList[colorIndex]),
      border: Border.all(
        color: colorIndex == 0 ? ColorPalette.grey_2 : Colors.transparent,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ABOUT',
          style: TextStyle(
            color: ColorPalette.purple,
            fontFamily: FontPalette.pretendard,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        if (fontIndex == 0)
          Text(
            controller.exhibitions
                .firstWhere((element) =>
                    element.id == Get.arguments['buyer_exhibition_id'])
                .seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 1)
          Text(
            controller.exhibitions
                .firstWhere((element) =>
                    element.id == Get.arguments['buyer_exhibition_id'])
                .seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 2)
          Text(
            controller.exhibitions
                .firstWhere((element) =>
                    element.id == Get.arguments['buyer_exhibition_id'])
                .seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 3)
          Text(
            controller.exhibitions
                .firstWhere((element) =>
                    element.id == Get.arguments['buyer_exhibition_id'])
                .seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(Get.width),
          child: CachedNetworkImage(
            imageUrl: controller.exhibitionArtist.value!.imageUrl!,
            fit: BoxFit.cover,
            width: Get.width * 0.53,
            height: Get.width * 0.53,
          ),
        ),
        SizedBox(height: 16),
        if (fontIndex == 0)
          Text(
            controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
            ),
          ),
        if (fontIndex == 1)
          Text(
            controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontSize: 14,
            ),
          ),
        if (fontIndex == 2)
          Text(
            controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontSize: 14,
            ),
          ),
        if (fontIndex == 3)
          Text(
            controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontSize: 14,
            ),
          ),
      ],
    ),
  );
}

_sellerWithoutTemplateWidget() {
  return CachedNetworkImage(
    imageUrl: controller.exhibitionArtist.value!.imageUrl!,
    width: Get.width,
    fit: BoxFit.cover,
  );
}
