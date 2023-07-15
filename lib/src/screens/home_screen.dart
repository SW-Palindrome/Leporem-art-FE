import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/home_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/screens/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorPalette.grey_1),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              _filterDropDown('최신순'),
              SizedBox(width: 10),
              _filterDropDown('작품 종류'),
              SizedBox(width: 10),
              _filterDropDown('가격대'),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.items.length,
                itemBuilder: (context, index) =>
                    _itemWidget(controller.items[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(Item item) {
    return GestureDetector(
      onTap: () {
        Get.to(ItemDetailScreen());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Stack(
              children: [
                ExtendedImage.network(
                  item.thumbnailUrl,
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
                  Text(
                    item.name,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${item.price}원',
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
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${item.likes}',
                        style: TextStyle(
                          color: ColorPalette.purple,
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

  Container _filterDropDown(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffe6e7ec)),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 12)),
          SizedBox(width: 5),
          SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            height: 10,
            width: 10,
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
