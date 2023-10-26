import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

final controller = Get.find<ExhibitionController>();
itemEditWidget() {
  switch (controller.selectedTemplateIndex.value) {
    case 0:
      return template1EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 1:
      return template2EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 2:
      return template3EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
  }
}

template1EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    color: color,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    child: Column(
      children: [
        isColorFontChange == true
            ? Center(
                child: Text(
                  controller.templateTitle.value,
                  style: TextStyle(
                    color: color == ColorPalette.black
                        ? ColorPalette.white
                        : ColorPalette.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontFamily,
                    fontSize: 26,
                  ),
                ),
              )
            : TextField(
                controller: controller.templateTitleController,
                maxLength: 15,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '작품 이름을 입력해주세요',
                  hintStyle: TextStyle(
                    color: ColorPalette.grey_4,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 26,
                  ),
                  counterText: '',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 26,
                ),
              ),
        SizedBox(height: 12),
        Stack(
          children: [
            CarouselSlider(
              items: [
                if (controller.itemImages.isEmpty)
                  GestureDetector(
                    onTap: () {
                      controller.selectImages(ImageType.item);
                    },
                    child: Container(
                      width: Get.width * 0.65,
                      height: Get.width * 0.65,
                      color: ColorPalette.grey_2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/camera.svg',
                            colorFilter: ColorFilter.mode(
                                ColorPalette.grey_3, BlendMode.srcIn),
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '작품 이미지를\n업로드해주세요',
                            style: TextStyle(
                              color: ColorPalette.grey_4,
                              fontFamily: FontPalette.pretendard,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.itemImages.isNotEmpty)
                  for (int i = 0; i < controller.itemImages.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (isColorFontChange == false) {
                          controller.selectImages(ImageType.item);
                        }
                      },
                      child: Container(
                        width: Get.width * 0.65,
                        height: Get.width * 0.65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(controller.itemImages[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
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
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: Get.width * 0.65,
          child: isColorFontChange == true
              ? Center(
                  child: Text(
                    controller.templateDescription.value,
                    style: TextStyle(
                      color: color == ColorPalette.black
                          ? ColorPalette.white
                          : ColorPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontFamily,
                      fontSize: 14,
                    ),
                  ),
                )
              : TextField(
                  controller: controller.templateDescriptionController,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '여기에 작품에 대한 설명을 적어주세요',
                    hintStyle: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                ),
        ),
      ],
    ),
  );
}

template2EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: [
            if (controller.itemImages.isEmpty)
              Padding(
                padding: EdgeInsets.only(left: 8, top: 8),
                child: GestureDetector(
                  onTap: () {
                    controller.selectImages(ImageType.item);
                  },
                  child: Container(
                    width: Get.width * 0.86,
                    height: Get.width * 0.82,
                    color: ColorPalette.grey_2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/camera.svg',
                          colorFilter: ColorFilter.mode(
                              ColorPalette.grey_3, BlendMode.srcIn),
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '작품 이미지를\n업로드해주세요',
                          style: TextStyle(
                            color: ColorPalette.grey_4,
                            fontFamily: FontPalette.pretendard,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (controller.itemImages.isNotEmpty)
              for (int i = 0; i < controller.itemImages.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (isColorFontChange == false) {
                        controller.selectImages(ImageType.item);
                      }
                    },
                    child: Container(
                      width: Get.width * 0.86,
                      height: Get.width * 0.82,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(controller.itemImages[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
            child: isColorFontChange == true
                ? Center(
                    child: Text(
                      controller.templateTitle.value,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontFamily,
                        fontSize: 26,
                      ),
                    ),
                  )
                : TextField(
                    controller: controller.templateTitleController,
                    maxLength: 15,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '작품 이름을 입력해주세요',
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_4,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontPalette.pretendard,
                        fontSize: 26,
                      ),
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 26,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Center(
                  child: Text(
                    controller.templateDescription.value,
                    style: TextStyle(
                      color: color == ColorPalette.black
                          ? ColorPalette.white
                          : ColorPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontFamily,
                      fontSize: 14,
                    ),
                  ),
                )
              : TextField(
                  controller: controller.templateDescriptionController,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '여기에 작품에 대한 설명을 적어주세요',
                    hintStyle: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                ),
        ),
      ],
    ),
  );
}

template3EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
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
            child: isColorFontChange == true
                ? Center(
                    child: Text(
                      controller.templateTitle.value,
                      style: TextStyle(
                        color: color == ColorPalette.black
                            ? ColorPalette.white
                            : ColorPalette.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontFamily,
                        fontSize: 26,
                      ),
                    ),
                  )
                : TextField(
                    controller: controller.templateTitleController,
                    maxLength: 15,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '작품 이름을 입력해주세요',
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_4,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontPalette.pretendard,
                        fontSize: 26,
                      ),
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 26,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Center(
                  child: Text(
                    controller.templateDescription.value,
                    style: TextStyle(
                      color: color == ColorPalette.black
                          ? ColorPalette.white
                          : ColorPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontFamily,
                      fontSize: 14,
                    ),
                  ),
                )
              : TextField(
                  controller: controller.templateDescriptionController,
                  textAlign: TextAlign.center,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: '여기에 작품에 대한 설명을 적어주세요',
                    hintStyle: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontPalette.pretendard,
                      fontSize: 14,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                ),
        ),
        SizedBox(height: 12),
        Stack(
          children: [
            CarouselSlider(
              items: [
                if (controller.itemImages.isEmpty)
                  GestureDetector(
                    onTap: () {
                      controller.selectImages(ImageType.item);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.width * 0.78,
                      color: ColorPalette.grey_2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/camera.svg',
                            colorFilter: ColorFilter.mode(
                                ColorPalette.grey_3, BlendMode.srcIn),
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '작품 이미지를\n업로드해주세요',
                            style: TextStyle(
                              color: ColorPalette.grey_4,
                              fontFamily: FontPalette.pretendard,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.itemImages.isNotEmpty)
                  for (int i = 0; i < controller.itemImages.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (isColorFontChange == false) {
                          controller.selectImages(ImageType.item);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.width * 0.78,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(controller.itemImages[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                height: Get.width * 0.78,
                enableInfiniteScroll: false,
                padEnds: false,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    'assets/icons/arrow_exhibition_left.svg',
                    width: 24,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    'assets/icons/arrow_exhibition_right.svg',
                    width: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
