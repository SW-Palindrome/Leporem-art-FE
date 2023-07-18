import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class ItemCreateDetailScreen extends GetView<ItemCreateDetailController> {
  const ItemCreateDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '작품 등록',
        onTapLeadingIcon: () {
          Get.back();
        },
        isWhite: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: ColorPalette.grey_1,
          child: Column(
            children: [
              _mediaInput(),
              SizedBox(height: 20),
              _categoryInput(),
              SizedBox(height: 20),
              _titleInput(),
              SizedBox(height: 20),
              _descriptionInput(),
              SizedBox(height: 20),
              _sizeInput(),
              SizedBox(height: 20),
              _priceInput(),
              SizedBox(height: 20),
              _amountInput(),
              SizedBox(height: 20),
              Obx(
                () => NextButton(
                  text: "작품 등록하기",
                  value: controller.isValidCreate(),
                  onTap: () async {
                    await controller.createItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '사진과 플롭영상을 올려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '(최소 3장)',
                style: TextStyle(
                  color: ColorPalette.grey_4,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => controller.selectImages(),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: ColorPalette.grey_4,
                    radius: Radius.circular(5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                        ),
                        Positioned(
                          top: Get.height * 0.025,
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg',
                            colorFilter: ColorFilter.mode(
                              ColorPalette.grey_4,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Get.height * 0.025,
                          child: Text(
                            '${controller.images.length}/10',
                            style: TextStyle(
                              color: ColorPalette.grey_6,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PretendardVariable",
                              fontStyle: FontStyle.normal,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                for (var i = 0; i < controller.images.length; i++)
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                          border: i == 0
                              ? Border.all(
                                  color: ColorPalette.purple,
                                  width: 1,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: FileImage(controller.images[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(i),
                          child: CircleAvatar(
                            backgroundColor: ColorPalette.black,
                            radius: 10,
                            child: SvgPicture.asset(
                              'assets/icons/cancle.svg',
                              colorFilter: ColorFilter.mode(
                                ColorPalette.white,
                                BlendMode.srcIn,
                              ),
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      if (i == 0)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: ColorPalette.purple,
                            ),
                            child: Text(
                              '썸네일',
                              style: TextStyle(
                                color: ColorPalette.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "PretendardVariable",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Obx(
          () => Row(
            children: [
              GestureDetector(
                onTap: () => controller.selectVideo(),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorPalette.grey_4,
                  radius: Radius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                      ),
                      Positioned(
                        top: Get.height * 0.025,
                        child: SvgPicture.asset(
                          'assets/icons/shorts.svg',
                          colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Get.height * 0.025,
                        child: Text(
                          '${controller.videos.length}/1',
                          style: TextStyle(
                            color: ColorPalette.grey_6,
                            fontWeight: FontWeight.w600,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (var i = 0; i < controller.videos.length; i++)
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: Get.width * 0.2,
                      width: Get.width * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.memory(
                          controller.thumbnail.value!,
                          fit: BoxFit.cover,
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => controller.removeVideo(i),
                        child: CircleAvatar(
                          backgroundColor: ColorPalette.black,
                          radius: 10,
                          child: SvgPicture.asset(
                            'assets/icons/cancle.svg',
                            colorFilter: ColorFilter.mode(
                              ColorPalette.white,
                              BlendMode.srcIn,
                            ),
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  _categoryInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '작품의 카테고리를 알려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.width),
            border: Border.all(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '카테고리 선택',
                style: TextStyle(
                  color: ColorPalette.grey_6,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              SvgPicture.asset(
                'assets/icons/arrow_down.svg',
                colorFilter: ColorFilter.mode(
                  ColorPalette.grey_4,
                  BlendMode.srcIn,
                ),
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _titleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '작품의 이름을 알려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorPalette.grey_4,
                width: 1,
              ),
            ),
          ),
          child: TextField(
            controller: controller.titleController,
            maxLength: 46,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '이름',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }

  _descriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '작품에 대한 설명을 알려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
          child: TextField(
            maxLength: 255,
            maxLines: null,
            controller: controller.descriptionController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '작품에 대한 상세한 설명을 적어주세요.',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _sizeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '작품의 크기를 알려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '(선택)',
                style: TextStyle(
                  color: ColorPalette.grey_4,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '가로',
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ColorPalette.grey_4,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: controller.widthController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        suffixText: 'cm',
                        suffixStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '세로',
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ColorPalette.grey_4,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: controller.depthController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        suffixText: 'cm',
                        suffixStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '높이',
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ColorPalette.grey_4,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: controller.heightController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        suffixText: 'cm',
                        suffixStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _priceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '가격을 알려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorPalette.grey_4,
                width: 1,
              ),
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller.priceController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyFormatter(), // 사용자 정의 CurrencyFormatter 적용
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              suffix: Text(
                '원',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              hintText: '판매가 입력',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _amountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            '수량',
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => controller.decreaseQuantity(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.grey_2,
                ),
                child: SvgPicture.asset(
                  'assets/icons/minus.svg',
                  colorFilter: ColorFilter.mode(
                    ColorPalette.grey_6,
                    BlendMode.srcIn,
                  ),
                  width: 16.0,
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            Container(
              height: Get.width * 0.1,
              width: Get.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorPalette.grey_4,
                  width: 1,
                ),
              ),
              child: Obx(
                () => Center(
                  child: Text(
                    '${controller.amount.value}',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            GestureDetector(
              onTap: () => controller.increaseQuantity(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.grey_2,
                ),
                child: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  colorFilter: ColorFilter.mode(
                    ColorPalette.grey_6,
                    BlendMode.srcIn,
                  ),
                  width: 16.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
