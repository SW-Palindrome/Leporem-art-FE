import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

exhibitionTemplateCarouselWidget() {
  return Column(
    children: [
      CarouselSlider(
        items: [
          //TODO: 준식이형이 템플릿 예시 다 만든대요 2~8번까지 부탁해요 ㅋㅋ
          _template1Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.pretendard,
          ),
          _template2Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
          _template3Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
          _template4Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
          _template5Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
          _template7Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg'
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
          _template8Widget(
            '솔방울을 머금은 술잔',
            '추풍낙엽 속 길을 거닐며 떨어진 솔방울을 보고 명감을 받아 만든 술잔입니다.',
            [
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/items/item_image/e29ad86f-7255-43e9-b596-f59dc4c90957.jpg',
            ],
            Color(0xffFFEADE),
            FontPalette.chosun,
          ),
        ],
        options: CarouselOptions(
          height: Get.width * 1.1,
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

_template1Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: [
                for (final imageUrl in imageUrlList)
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: Get.width,
                    height: Get.width * 0.87,
                    fit: BoxFit.cover,
                  ),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                height: Get.width * 0.87,
                enableInfiniteScroll: false,
              ),
            ),
            Positioned(
              top: 13,
              left: 18,
              child: Text(
                title,
                style: TextStyle(
                  color: ColorPalette.white,
                  fontFamily: fontFamily,
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
            description,
            style: TextStyle(
              color: color == ColorPalette.black
                  ? ColorPalette.white
                  : ColorPalette.black,
              fontFamily: fontFamily,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

_template2Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: [
            for (final imageUrl in imageUrlList)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: Get.width * 0.86,
                  height: Get.width * 0.82,
                  fit: BoxFit.cover,
                ),
              ),
          ],
          options: CarouselOptions(
            viewportFraction: 0.82,
            height: Get.width * 0.82,
            enableInfiniteScroll: false,
            padEnds: false,
          ),
        ),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: TextStyle(
                color: color == ColorPalette.black
                    ? ColorPalette.white
                    : ColorPalette.black,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            description,
            style: TextStyle(
              color: color == ColorPalette.black
                  ? ColorPalette.white
                  : ColorPalette.black,
              fontFamily: fontFamily,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

_template3Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  CarouselController carouselController = CarouselController();
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: TextStyle(
                color: color == ColorPalette.black
                    ? ColorPalette.white
                    : ColorPalette.black,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              description,
              style: TextStyle(
                color: color == ColorPalette.black
                    ? ColorPalette.white
                    : ColorPalette.black,
                fontFamily: fontFamily,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Stack(children: [
          CarouselSlider(
            carouselController: carouselController,
            items: [
              for (final imageUrl in imageUrlList)
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: Get.width,
                  height: Get.width * 0.78,
                  fit: BoxFit.cover,
                ),
            ],
            options: CarouselOptions(
              aspectRatio: 1 / 0.78,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              padEnds: false,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/arrow_exhibition_left.svg',
                  width: 24,
                ),
                onPressed: () {
                  carouselController.previousPage();
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/arrow_exhibition_right.svg',
                  width: 24,
                ),
                onPressed: () {
                  carouselController.nextPage();
                },
              ),
            ),
          ),
        ]),
      ],
    ),
  );
}

_template4Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color == ColorPalette.black
                ? ColorPalette.white
                : ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: FontPalette.pretendard,
            fontSize: 26,
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: Get.width * 0.1),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageUrlList[0],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageUrlList[1],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageUrlList[2],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageUrlList[3],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: color == ColorPalette.black
                ? ColorPalette.white
                : ColorPalette.black,
            fontWeight: FontWeight.w400,
            fontFamily: FontPalette.pretendard,
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}

_template5Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color == ColorPalette.black
                ? ColorPalette.white
                : ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: FontPalette.pretendard,
            fontSize: 26,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: color == ColorPalette.black
                ? ColorPalette.white
                : ColorPalette.black,
            fontWeight: FontWeight.w400,
            fontFamily: FontPalette.pretendard,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: imageUrlList[0],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), // Placeholder 사용
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageUrlList[1],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: imageUrlList[2],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: imageUrlList[3],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_template7Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
      width: Get.width,
      height: Get.width * 1.1,
      color: color,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.6,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrlList[0],
                  width: Get.width * 0.75,
                  height: Get.width * 0.6,
                  fit: BoxFit.cover,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      description,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontFamily: fontFamily,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: imageUrlList[0],
                    width: Get.width * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        ],
      ));
}

_template8Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
      width: Get.width,
      height: Get.width * 1.1,
      color: color,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.83,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrlList[0],
                  width: Get.width * 0.77,
                  height: Get.width * 0.83,
                  fit: BoxFit.cover,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontFamily: fontFamily,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ));
}
