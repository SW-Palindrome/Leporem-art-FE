import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../theme/app_theme.dart';

exhibitionItemEditWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    children: [
      for (int index = 0; index < controller.exhibitionItems.length; index++)
        Column(
          children: [
            _exhibitionItemWidget(controller, index),
            if (index != controller.exhibitionItems.length)
              SizedBox(height: 16),
          ],
        ),
    ],
  );
}

_exhibitionItemWidget(ExhibitionController controller, int index) {
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
            await controller.removeExhibitionItem(controller.exhibitionId, controller.exhibitionItems[index].id);
          },
          child: SvgPicture.asset(
            'assets/icons/cancel.svg',
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
