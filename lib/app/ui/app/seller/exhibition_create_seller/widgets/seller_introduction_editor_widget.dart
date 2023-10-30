import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

sellerIntroductionEditorWidget() {
  final controller = Get.find<ExhibitionController>();
  return controller.isSellerTemplateUsed.value == true
      ? Container(
          width: Get.width,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorPalette.white,
            border: Border.all(
              color: ColorPalette.grey_2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ABOUT',
                style: TextStyle(
                  color: ColorPalette.purple,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .seller,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  controller.selectImages(ImageType.seller);
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Get.width),
                      child: controller.sellerImage.isEmpty
                          ? Container(
                              width: Get.width * 0.53,
                              height: Get.width * 0.53,
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
                                    '소개 이미지를\n업로드해주세요',
                                    style: TextStyle(
                                      color: ColorPalette.grey_4,
                                      fontFamily: FontPalette.pretendard,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: Get.width * 0.53,
                              height: Get.width * 0.53,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(controller.sellerImage[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    if (controller.sellerImage.isNotEmpty)
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectImages(ImageType.seller);
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: ColorPalette.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorPalette.grey_2,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/edit.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  ColorPalette.grey_5,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                textAlign: TextAlign.center,
                controller: controller.sellerIntroductionController,
                maxLines: 5,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: '작가 소개를 입력해주세요.',
                  hintStyle: TextStyle(
                    color: ColorPalette.grey_4,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 14,
                  ),
                  counterText: '',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretendard,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      : Container(
          width: Get.width,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorPalette.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ABOUT',
                style: TextStyle(
                  color: Colors.transparent,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .seller,
                style: TextStyle(
                  color: Colors.transparent,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  controller.selectImages(ImageType.seller);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width),
                  child: controller.sellerImage.isEmpty
                      ? Container(
                          width: Get.width * 0.53,
                          height: Get.width * 0.53,
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
                                '소개 이미지를\n업로드해주세요',
                                style: TextStyle(
                                  color: ColorPalette.grey_4,
                                  fontFamily: FontPalette.pretendard,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: Get.width * 0.53,
                          height: Get.width * 0.53,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(controller.sellerImage[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                controller.exhibitions
                    .firstWhere((element) =>
                        element.id == Get.arguments['exhibition_id'])
                    .seller,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
}
