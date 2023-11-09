import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../controller/seller/exhibition/exhibition_preview_controller.dart';
import '../../../../theme/app_theme.dart';

sellerWidget() {
  final controller = Get.find<ExhibitionPreviewController>();
  return controller.exhibitionArtist.value!.isUsingTemplate == true
      ? _sellerWithTemplateWidget(controller)
      : _sellerWithoutTemplateWidget(controller);
}

_sellerWithTemplateWidget(ExhibitionPreviewController controller) {
  int colorIndex =
      int.parse(controller.exhibitionArtist.value!.backgroundColor);
  int fontIndex = int.parse(controller.exhibitionArtist.value!.fontFamily);
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
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
            controller.exhibition.seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 1)
          Text(
            controller.exhibition.seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 2)
          Text(
            controller.exhibition.seller,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (fontIndex == 3)
          Text(
            controller.exhibition.seller,
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
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
            ),
          ),
        if (fontIndex == 1)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
            ),
          ),
        if (fontIndex == 2)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
            ),
          ),
        if (fontIndex == 3)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.exhibitionArtist.value!.description,
            style: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: colorIndex != 9 ? ColorPalette.black : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
            ),
          ),
      ],
    ),
  );
}

_sellerWithoutTemplateWidget(ExhibitionPreviewController controller) {
  return CachedNetworkImage(
    imageUrl: controller.exhibitionArtist.value!.imageUrl!,
    width: Get.width,
    fit: BoxFit.cover,
  );
}
