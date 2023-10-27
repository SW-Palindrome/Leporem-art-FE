import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../exhibition_create_item/widgets/item_edit_widget.dart';

itemResultWidget() {
  final controller = Get.find<ExhibitionController>();

  return Obx(() {
    switch (controller.selectedTemplateIndex.value) {
      case 0:
        return template1EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 1:
        return template2EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 2:
        return template3EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 3:
        return template4EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 4:
        return template5EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 5:
        return template6EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 6:
        return template7EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      case 7:
        return template8EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
      default:
        return template1EditWidget(
          Color(controller
              .colorList[controller.selectedItemBackgroundColor.value]),
          controller.fontList[controller.displayedItemFont.value],
          true,
        );
    }
  });
}