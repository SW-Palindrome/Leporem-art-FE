import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

sellerIntroductionResultWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Color(controller
          .colorList[controller.selectedSellerIntroductionColor.value]),
      border: Border.all(
        color: controller.selectedSellerIntroductionColor.value == 0
            ? ColorPalette.grey_2
            : Colors.transparent,
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
        if (controller.displayedSellerIntroductionFont.value == 0)
          Text(
            controller.exhibitions
                .firstWhere(
                    (element) => element.id == Get.arguments['exhibition_id'])
                .seller,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 1)
          Text(
            controller.exhibitions
                .firstWhere(
                    (element) => element.id == Get.arguments['exhibition_id'])
                .seller,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 2)
          Text(
            controller.exhibitions
                .firstWhere(
                    (element) => element.id == Get.arguments['exhibition_id'])
                .seller,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 3)
          Text(
            controller.exhibitions
                .firstWhere(
                    (element) => element.id == Get.arguments['exhibition_id'])
                .seller,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(Get.width),
          child: Container(
            width: Get.width * 0.53,
            height: Get.width * 0.53,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(controller.sellerImage[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        if (controller.displayedSellerIntroductionFont.value == 0)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.sellerIntroduction.value,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.pretendard,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 1)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.sellerIntroduction.value,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.gmarket,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 2)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.sellerIntroduction.value,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.kbo,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        if (controller.displayedSellerIntroductionFont.value == 3)
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: controller.sellerIntroduction.value,
            style: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontSize: 14,
            ),
            linkStyle: TextStyle(
              color: controller.selectedSellerIntroductionColor.value != 9
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontFamily: FontPalette.chosun,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
      ],
    ),
  );
}
