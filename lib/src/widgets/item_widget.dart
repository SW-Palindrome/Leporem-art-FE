import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/screens/buyer/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';

itemWidget(BuyerHomeItem item) {
  return GestureDetector(
    onTap: () {
      Get.to(BuyerItemDetailScreen(), arguments: {'item_id': item.id});
      Get.put(ItemDetailController());
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                ExtendedImage.network(
                  item.thumbnailUrl,
                  fit: BoxFit.cover,
                  width: Get.width * 0.5,
                  height: Get.width * 0.5,
                  cache: true,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: item.isLiked
                      ? SvgPicture.asset(
                          'assets/icons/heart_fill.svg',
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              ColorPalette.purple, BlendMode.srcIn),
                        )
                      : SvgPicture.asset(
                          'assets/icons/heart_outline.svg',
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              ColorPalette.white, BlendMode.srcIn),
                        ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.creator,
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: Get.height * 0.04,
                  child: Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${item.price.toString().toString().replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      )}원',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.black,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/heart_fill.svg',
                      height: 12,
                      width: 12,
                      colorFilter: ColorFilter.mode(
                          item.likes != 0
                              ? ColorPalette.purple
                              : Colors.transparent,
                          BlendMode.srcIn),
                    ),
                    SizedBox(width: 2),
                    Text(
                      '${item.likes}',
                      style: TextStyle(
                        color: item.likes != 0
                            ? ColorPalette.purple
                            : Colors.transparent,
                        fontSize: 10,
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
  );
}
