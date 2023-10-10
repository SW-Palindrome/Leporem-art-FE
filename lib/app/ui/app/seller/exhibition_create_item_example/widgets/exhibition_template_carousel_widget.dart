import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

exhibitionTemplateCarouselWidget() {
  return Column(
    children: [
      CarouselSlider(
        items: [
          //TODO: 준식이형이 템플릿 예시 다 만든대요 2~8번까지 부탁해요 ㅋㅋ
          _template1Widget(),
          _template1Widget(),
          _template1Widget(),
        ],
        options: CarouselOptions(
          height: Get.width,
          viewportFraction: 1,
          enableInfiniteScroll: false,
        ),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.purple,
            ),
          ),
          SizedBox(width: 4),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.grey_3,
            ),
          ),
          SizedBox(width: 4),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.grey_3,
            ),
          ),
        ],
      ),
    ],
  );
}

_template1Widget() {
  return Container(
    width: Get.width,
    height: Get.width,
    color: Color(0xffFFEADE),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: [
                CachedNetworkImage(
                  imageUrl:
                      'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
                  width: Get.width,
                  height: Get.width * 0.8,
                  fit: BoxFit.cover,
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
                  width: Get.width,
                  height: Get.width * 0.8,
                  fit: BoxFit.cover,
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
                  width: Get.width,
                  height: Get.width * 0.8,
                  fit: BoxFit.cover,
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 1 / 0.8,
                viewportFraction: 1,
                height: Get.width * 0.8,
                enableInfiniteScroll: false,
              ),
            ),
            Positioned(
              top: 13,
              left: 18,
              child: Text(
                '솔방울을 머금은 술잔',
                style: TextStyle(
                  color: ColorPalette.white,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.white.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            style: TextStyle(
              color: ColorPalette.black,
              fontFamily: FontPalette.pretendard,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
