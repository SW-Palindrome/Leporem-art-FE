import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../exhibition_create_item/widgets/item_edit_widget.dart';

itemResultWidget() {
  final controller = Get.find<ExhibitionController>();

  return Obx(() => template1EditWidget(
        Color(
            controller.colorList[controller.selectedItemBackgroundColor.value]),
        controller.fontList[controller.displayedItemFont.value],
        true,
      ));
}
