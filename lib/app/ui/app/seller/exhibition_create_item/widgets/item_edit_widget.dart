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
    case 3:
      return template4EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 4:
      return template5EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 5:
      return template6EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 6:
      return template7EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
    case 7:
      return template8EditWidget(
          ColorPalette.white, FontPalette.pretendard, false);
  }
}

template1EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    color: color,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                if (controller.templateItemImages.isEmpty)
                  GestureDetector(
                    onTap: () {
                      controller.selectImages(ImageType.templateItem);
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
                if (controller.templateItemImages.isNotEmpty)
                  for (int i = 0; i < controller.templateItemImages.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (isColorFontChange == false) {
                          controller.selectImages(ImageType.templateItem);
                        }
                      },
                      child: Container(
                        width: Get.width * 0.65,
                        height: Get.width * 0.65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(controller.templateItemImages[i]!),
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
              ? Text(
                  controller.templateDescription.value,
                  style: TextStyle(
                    color: color == ColorPalette.black
                        ? ColorPalette.white
                        : ColorPalette.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 14,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: [
            if (controller.templateItemImages.isEmpty)
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
            if (controller.templateItemImages.isNotEmpty)
              for (int i = 0; i < controller.templateItemImages.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (isColorFontChange == false) {
                        controller.selectImages(ImageType.templateItem);
                      }
                    },
                    child: Container(
                      width: Get.width * 0.86,
                      height: Get.width * 0.82,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(controller.templateItemImages[i]!),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Text(
                  controller.templateTitle.value,
                  style: TextStyle(
                    color: color == ColorPalette.black
                        ? ColorPalette.white
                        : ColorPalette.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontFamily,
                    fontSize: 26,
                  ),
                )
              : TextField(
                  controller: controller.templateTitleController,
                  maxLength: 15,
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
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Text(
                  controller.templateDescription.value,
                  style: TextStyle(
                    color: color == ColorPalette.black
                        ? ColorPalette.white
                        : ColorPalette.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 14,
                  ),
                )
              : TextField(
                  controller: controller.templateDescriptionController,
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
      ],
    ),
  );
}

template3EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    color: color,
    child: Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Align(
                  alignment: Alignment.centerLeft,
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
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: isColorFontChange == true
              ? Align(
                  alignment: Alignment.centerLeft,
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
                if (controller.templateItemImages.isEmpty)
                  GestureDetector(
                    onTap: () {
                      controller.selectImages(ImageType.templateItem);
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
                if (controller.templateItemImages.isNotEmpty)
                  for (int i = 0; i < controller.templateItemImages.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (isColorFontChange == false) {
                          controller.selectImages(ImageType.templateItem);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.width * 0.78,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(controller.templateItemImages[i]!),
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

<<<<<<< Updated upstream
template4EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      children: [
        isColorFontChange == true
            ? Align(
                alignment: Alignment.centerLeft,
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
        SizedBox(height: 6),
        SizedBox(
          height: Get.width * 0.56,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: Get.width * 0.1),
                    Expanded(
                      child: selectImageWidget(
                          controller.templateItemImages.isEmpty,
                          isColorFontChange,
                          0),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: selectImageWidget(
                          controller.templateItemImages.isEmpty,
                          isColorFontChange,
                          1),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: selectImageWidget(
                          controller.templateItemImages.isEmpty,
                          isColorFontChange,
                          2),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: selectImageWidget(
                          controller.templateItemImages.isEmpty,
                          isColorFontChange,
                          3),
                    ),
                    SizedBox(height: Get.width * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        isColorFontChange == true
            ? Align(
                alignment: Alignment.centerLeft,
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
      ],
    ),
  );
}

template5EditWidget(Color color, String fontFamily, bool isColorFontChange) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(16),
    color: color,
    child: Column(
      children: [
        isColorFontChange == true
            ? Text(
                controller.templateTitle.value,
                style: TextStyle(
                  color: color == ColorPalette.black
                      ? ColorPalette.white
                      : ColorPalette.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontFamily,
                  fontSize: 26,
                ),
              )
            : TextField(
                controller: controller.templateTitleController,
                maxLength: 15,
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
        SizedBox(height: 8),
        isColorFontChange == true
            ? Text(
                controller.templateDescription.value,
                style: TextStyle(
                  color: color == ColorPalette.black
                      ? ColorPalette.white
                      : ColorPalette.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: fontFamily,
                  fontSize: 14,
                ),
              )
            : TextField(
                controller: controller.templateDescriptionController,
                maxLines: 5,
                minLines: 1,
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
        SizedBox(height: 6),
        SizedBox(
          height: Get.width * 0.7093,
          child: Row(
            children: [
              Expanded(
                child: selectImageWidget(controller.templateItemImages.isEmpty,
                    isColorFontChange, 0),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: selectImageWidget(
                          controller.templateItemImages.isEmpty,
                          isColorFontChange,
                          1),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: selectImageWidget(
                                controller.templateItemImages.isEmpty,
                                isColorFontChange,
                                2),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: selectImageWidget(
                                controller.templateItemImages.isEmpty,
                                isColorFontChange,
                                3),
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

template6EditWidget(Color color, String fontFamily, bool isColorFontChange) {
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
                child: selectImageWidget(controller.templateItemImages.isEmpty,
                    isColorFontChange, 0),
              ),
              SizedBox(height: 8),
              Expanded(
                child: selectImageWidget(controller.templateItemImages.isEmpty,
                    isColorFontChange, 1),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 4, 0),
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
                SizedBox(height: 8),
                isColorFontChange == true
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
                        maxLines: 18,
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

template7EditWidget(Color color, String fontFamily, bool isColorFontChange) {
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
              SizedBox(
                width: Get.width * 0.75,
                child: Expanded(
                  child: selectImageWidget(
                      controller.templateItemImages.isEmpty,
                      isColorFontChange,
                      0),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: RotatedBox(
                  quarterTurns: 1,
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
                          maxLines: 7,
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
              ),
              Expanded(
                child: selectImageWidget(controller.templateItemImages.isEmpty,
                    isColorFontChange, 1),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

template8EditWidget(Color color, String fontFamily, bool isColorFontChange) {
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
              SizedBox(
                width: Get.width * 0.77,
                height: Get.width * 0.83,
                child: selectImageWidget(controller.templateItemImages.isEmpty,
                    isColorFontChange, 0),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RotatedBox(
                  quarterTurns: 1,
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
              ),
            ],
          ),
        )
      ],
    ),
  );
}

selectImageWidget(bool isEmpty, bool isColorFontChange, int index) {
  return isEmpty || controller.templateItemImages[index] == null
      ? GestureDetector(
          onTap: () {
            controller.selectImages(ImageType.templateItem, index: index);
          },
          child: Container(
            color: ColorPalette.grey_2,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/camera.svg',
                  colorFilter:
                      ColorFilter.mode(ColorPalette.grey_3, BlendMode.srcIn),
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
        )
      : GestureDetector(
          onTap: () {
            if (isColorFontChange == false) {
              controller.selectImages(ImageType.templateItem, index: index);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(controller.templateItemImages[index]!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
}
=======
// template4EditWidget(Color color, String fontFamily, bool isColorFontChange) {
//   return Container(
//     width: Get.width,
//     padding: EdgeInsets.all(16),
//     color: color,
//     child: Column(
//       children: [
//         isColorFontChange == true
//             ? Center(
//                 child: Text(
//                   controller.templateTitle.value,
//                   style: TextStyle(
//                     color: color == ColorPalette.black
//                         ? ColorPalette.white
//                         : ColorPalette.black,
//                     fontWeight: FontWeight.w700,
//                     fontFamily: fontFamily,
//                     fontSize: 26,
//                   ),
//                 ),
//               )
//             : TextField(
//                 controller: controller.templateTitleController,
//                 maxLength: 15,
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   hintText: '작품 이름을 입력해주세요',
//                   hintStyle: TextStyle(
//                     color: ColorPalette.grey_4,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: FontPalette.pretendard,
//                     fontSize: 26,
//                   ),
//                   counterText: '',
//                   border: InputBorder.none,
//                 ),
//                 style: TextStyle(
//                   color: ColorPalette.black,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: FontPalette.pretendard,
//                   fontSize: 26,
//                 ),
//               ),
//         SizedBox(height: 6),
//         Expanded(
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(height: Get.width * 0.1),
//                     Expanded(
//                       child: controller.itemImages.isEmpty
//                           ? GestureDetector(
//                               onTap: () {
//                                 controller.selectImages(ImageType.item);
//                               },
//                               child: Container(
//                                 color: ColorPalette.grey_2,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/icons/camera.svg',
//                                       colorFilter: ColorFilter.mode(
//                                           ColorPalette.grey_3, BlendMode.srcIn),
//                                       width: 32,
//                                       height: 32,
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       '작품 이미지를\n업로드해주세요',
//                                       style: TextStyle(
//                                         color: ColorPalette.grey_4,
//                                         fontFamily: FontPalette.pretendard,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () {
//                                 if (isColorFontChange == false) {
//                                   controller.selectImages(ImageType.item);
//                                 }
//                               },
//                               child: Container(
//                                 width: Get.width * 0.65,
//                                 height: Get.width * 0.65,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: FileImage(controller.itemImages[i]),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ),
//                     SizedBox(height: 8),
//                     Expanded(
//                       child: CachedNetworkImage(
//                         imageUrl: imageUrlList[1],
//                         imageBuilder: (context, imageProvider) => Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: CachedNetworkImage(
//                         imageUrl: imageUrlList[2],
//                         imageBuilder: (context, imageProvider) => Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Expanded(
//                       child: CachedNetworkImage(
//                         imageUrl: imageUrlList[3],
//                         imageBuilder: (context, imageProvider) => Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: Get.width * 0.1),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 8),
//         isColorFontChange == true
//             ? Center(
//                 child: Text(
//                   controller.templateDescription.value,
//                   style: TextStyle(
//                     color: color == ColorPalette.black
//                         ? ColorPalette.white
//                         : ColorPalette.black,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: fontFamily,
//                     fontSize: 14,
//                   ),
//                 ),
//               )
//             : TextField(
//                 controller: controller.templateDescriptionController,
//                 maxLines: 5,
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   hintText: '여기에 작품에 대한 설명을 적어주세요',
//                   hintStyle: TextStyle(
//                     color: ColorPalette.grey_4,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: FontPalette.pretendard,
//                     fontSize: 14,
//                   ),
//                   counterText: '',
//                   border: InputBorder.none,
//                 ),
//                 style: TextStyle(
//                   color: ColorPalette.black,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: FontPalette.pretendard,
//                   fontSize: 14,
//                 ),
//               ),
//       ],
//     ),
//   );
// }
>>>>>>> Stashed changes
