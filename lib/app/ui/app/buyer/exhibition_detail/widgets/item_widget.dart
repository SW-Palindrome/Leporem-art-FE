import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/buyer/exhibition/buyer_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';
import '../../../seller/exhibition_create_item_example/widgets/exhibition_template_carousel_widget.dart';

final controller = Get.find<BuyerExhibitionController>();
itemWidget() {
  return Column(
    children: [
      for (var exhibitionItem in controller.exhibitionItems.value)
        _exhibitionItem(
          exhibitionItem.title,
          exhibitionItem.description,
          exhibitionItem.imageUrls,
          exhibitionItem.audioUrl,
          exhibitionItem.isUsingTemplate,
          exhibitionItem.template,
          exhibitionItem.backgroundColor,
          exhibitionItem.fontFamily,
        ),
    ],
  );
}

_exhibitionItem(
  String title,
  String description,
  List<String> imageUrls,
  String? audioUrl,
  bool isUsingTemplate,
  int? template,
  String backgroundColor,
  String fontFamily,
) {
  return isUsingTemplate == true
      ? _exhibitionItemWithTemplate(
          title,
          description,
          imageUrls,
          audioUrl,
          template,
          backgroundColor,
          fontFamily,
        )
      : _exhibitionItemWithoutTemplate(
          imageUrls,
          audioUrl,
        );
}

_exhibitionItemWithTemplate(
  String title,
  String description,
  List<String> imageUrls,
  String? audioUrl,
  int? template,
  String backgroundColor,
  String fontFamily,
) {
  Color color = Color(controller.colorList[int.parse(backgroundColor)]);
  String font;
  if (fontFamily == '0') {
    font = FontPalette.pretendard;
  } else if (fontFamily == '1') {
    font = FontPalette.gmarket;
  } else if (fontFamily == '2') {
    font = FontPalette.kbo;
  } else {
    font = FontPalette.chosun;
  }

  switch (template!) {
    case 1:
      return template1Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 2:
      return template2Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 3:
      return template3Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 4:
      return template4Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 5:
      return template5Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 6:
      return template6Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 7:
      return template7Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    case 8:
      return template8Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
    default:
      return template1Widget(
        title,
        description,
        imageUrls,
        color,
        font,
      );
  }
}

_exhibitionItemWithoutTemplate(
  List<String> imageUrls,
  String? audioUrl,
) {
  return CachedNetworkImage(
    imageUrl: imageUrls[0],
    width: Get.width,
    fit: BoxFit.cover,
  );
}
