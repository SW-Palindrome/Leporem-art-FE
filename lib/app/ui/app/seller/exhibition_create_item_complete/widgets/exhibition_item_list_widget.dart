import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../theme/app_theme.dart';

exhibitionItemListWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return SingleChildScrollView(
    child: Column(
      children: [
        for (int index = 0; index < controller.exhibitionItems.length; index++)
          Column(
            children: [
              _exhibitionItemWidget(controller, index),
              if (index != controller.exhibitionItems.length)
                SizedBox(height: 16),
            ],
          ),
        if (controller.exhibitionItems.length <= 9)
          Column(
            children: [
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  controller.selectedTemplateIndex.value = 1;
                  controller.resetItemInfo();
                  Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_ITEM_EXAMPLE,
                    arguments: {
                      'exhibition_id': Get.arguments['exhibition_id'],
                    },
                  );
                  controller.isEditingItem.value = false;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/plus.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.grey_4,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '작품 추가하기',
                      style: TextStyle(
                        color: ColorPalette.grey_4,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
      ],
    ),
  );
}

_exhibitionItemWidget(SellerExhibitionController controller, int index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: ColorPalette.white,
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: controller.exhibitionItems[index].imageUrls[0],
            width: Get.width * 0.1493,
            height: Get.width * 0.1493,
          ),
        ),
        SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (controller.exhibitionItems[index].isSale == true)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorPalette.purple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '판매용',
                        style: TextStyle(
                          color: ColorPalette.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontPalette.pretendard,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  if (controller.exhibitionItems[index].isSale == true)
                    SizedBox(width: 4),
                  Text(
                    controller.exhibitionItems[index].title,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                controller.exhibitionItems[index].description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: ColorPalette.grey_6,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: () async {
            await controller
                .fetchExhibitionItemById(controller.exhibitionItems[index].id);
            Get.toNamed(
              Routes.SELLER_EXHIBITION_CREATE_ITEM,
              arguments: {
                'exhibition_id': Get.arguments['exhibition_id'],
                'item_id': controller.exhibitionItems[index].id,
              },
            );
            controller.isEditingItem.value = true;
          },
          child: SvgPicture.asset(
            'assets/icons/edit.svg',
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              ColorPalette.grey_4,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    ),
  );
}
