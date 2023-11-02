import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

exhibitionTemplateCarouselWidget() {
  final controller = Get.find<SellerExhibitionController>();
  return Column(
    children: [
      CarouselSlider(
        items: [
          template1Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png'
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template2Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png'
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template3Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png'
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template4Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template5Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template6Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template7Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
          template8Widget(
            '꼬미',
            '꼬미는 공예쁨의 마스코트입니다.',
            [
              'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/exhibitions/exhibition_item_image/kkomi.png',
            ],
            Color(0xffF8E8E0),
            FontPalette.gmarket,
          ),
        ],
        options: CarouselOptions(
          height: Get.width * 1.1,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            controller.selectedTemplateIndex.value = index + 1;
          },
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: 8,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(
              () => Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index + 1 == controller.selectedTemplateIndex.value
                      ? ColorPalette.purple
                      : ColorPalette.grey_3,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 4);
          },
          itemCount: 8,
        ),
      ),
    ],
  );
}

template1Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  CarouselController carouselController = CarouselController();
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color == ColorPalette.black
                ? ColorPalette.white
                : ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamily,
            fontSize: 26,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(width: 12),
        Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: [
                for (final imageUrl in imageUrlList)
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: Get.width * 0.65,
                    height: Get.width * 0.65,
                    fit: BoxFit.cover,
                  ),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                height: Get.width * 0.65,
                enableInfiniteScroll: false,
                padEnds: false,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    carouselController.previousPage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorPalette.grey_2,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_left.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    carouselController.nextPage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorPalette.grey_2,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: Get.width * 0.65,
          child: Text(
            description,
            style: TextStyle(
              color: color == ColorPalette.black
                  ? ColorPalette.white
                  : ColorPalette.black,
              fontWeight: FontWeight.w400,
              fontFamily: fontFamily,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

template2Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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

template3Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  CarouselController carouselController = CarouselController();
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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

template4Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              color: color == ColorPalette.black
                  ? ColorPalette.white
                  : ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: fontFamily,
              fontSize: 26,
            ),
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
            fontFamily: fontFamily,
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}

template5Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              color: color == ColorPalette.black
                  ? ColorPalette.white
                  : ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: fontFamily,
              fontSize: 26,
            ),
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
            fontFamily: fontFamily,
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

template6Widget(String title, String description, List<String> imageUrlList,
    Color color, String fontFamily) {
  return Container(
    width: Get.width,
    height: Get.width * 1.1,
    color: color,
    padding: EdgeInsets.fromLTRB(8, 8, 12, 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
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
                  ),
                ),
              ),
              SizedBox(height: 8),
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
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color == ColorPalette.black
                        ? ColorPalette.white
                        : ColorPalette.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: fontFamily,
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
                    fontFamily: fontFamily,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

template7Widget(String title, String description, List<String> imageUrlList,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
    ),
  );
}

template8Widget(String title, String description, List<String> imageUrlList,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
    ),
  );
}
