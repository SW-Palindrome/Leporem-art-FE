import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

final controller = Get.find<ExhibitionController>();
itemEditWidget() {
  return template1EditWidget();
}

template1EditWidget() {
  CarouselController carouselController = CarouselController();
  return Container(
    width: Get.width,
    color: ColorPalette.white,
    padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
    child: Column(
      children: [
        TextField(
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
              carouselController: carouselController,
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
                        controller.selectImages(ImageType.item);
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
          child: TextField(
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
