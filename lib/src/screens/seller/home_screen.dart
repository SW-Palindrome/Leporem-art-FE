import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/seller_home_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/screens/seller/item_create_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class SellerHomeScreen extends GetView<SellerHomeController> {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ColorPalette.grey_1,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _searchDropDown(),
                  Text(
                    '총 ${controller.items.length}개',
                    style: TextStyle(
                      color: ColorPalette.grey_5,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      return _itemWidget(controller.items[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Get.width * 0.05,
          right: Get.width * 0.05,
          child: GestureDetector(
            onTap: () {
              Get.to(ItemCreateScreen());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, -0.07),
                  end: Alignment(-1, 0.07),
                  colors: [Color(0xFF9C00E6), Color(0xFF594BF8)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: 20,
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(ColorPalette.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '작품등록',
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _searchDropDown() {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          _searchSheetWidget(),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
        );
      },
      child: _sortDropDown(),
    );
  }

  _searchSheetWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '정렬',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: Get.width * 0.1),
              _sortModal(),
              SizedBox(height: Get.width * 0.1),
              _searchModalBottom(),
            ],
          ),
        ),
      ),
    );
  }

  _sortModal() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.changeSelectedSortType(0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  '최신순',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: controller.selectedSortType.value == 0
                        ? ColorPalette.purple
                        : ColorPalette.black,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                controller.selectedSortType.value == 0
                    ? SvgPicture.asset(
                        'assets/icons/check.svg',
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2),
        GestureDetector(
          onTap: () => controller.changeSelectedSortType(1),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  '인기순',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: controller.selectedSortType.value == 1
                        ? ColorPalette.purple
                        : ColorPalette.black,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                controller.selectedSortType.value == 1
                    ? SvgPicture.asset(
                        'assets/icons/check.svg',
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2),
        GestureDetector(
          onTap: () => controller.changeSelectedSortType(2),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  '가격 낮은 순',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: controller.selectedSortType.value == 2
                        ? ColorPalette.purple
                        : ColorPalette.black,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                controller.selectedSortType.value == 2
                    ? SvgPicture.asset(
                        'assets/icons/check.svg',
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2),
        GestureDetector(
          onTap: () => controller.changeSelectedSortType(3),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  '가격 높은 순',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: controller.selectedSortType.value == 3
                        ? ColorPalette.purple
                        : ColorPalette.black,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                controller.selectedSortType.value == 3
                    ? SvgPicture.asset(
                        'assets/icons/check.svg',
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _searchModalBottom() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.resetSelected();
            },
            child: Container(
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                border: Border.all(
                    color: controller.isResetValid()
                        ? ColorPalette.grey_7
                        : ColorPalette.grey_3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/refresh.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          controller.isResetValid()
                              ? ColorPalette.grey_7
                              : ColorPalette.grey_4,
                          BlendMode.srcIn),
                    ),
                    SizedBox(width: 3),
                    Text(
                      '초기화',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: controller.isResetValid()
                            ? ColorPalette.grey_7
                            : ColorPalette.grey_4,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        NextButton(
          text: '적용하기',
          value: controller.isResetValid(),
          onTap: () => Get.back(),
          width: Get.width * 0.5,
        ),
      ],
    );
  }

  _sortDropDown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.grey_3),
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.sortTypes[controller.selectedSortType.value],
              style: TextStyle(
                fontSize: 12,
                color: ColorPalette.grey_6,
              ),
            ),
          ),
          SizedBox(width: 5),
          SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            height: 10,
            width: 10,
            colorFilter: ColorFilter.mode(
              ColorPalette.grey_4,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  _itemWidget(SellerHomeItem item) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPalette.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.thumbnailUrl,
              height: Get.width * 0.25,
              width: Get.width * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/star_fill.svg',
                          height: 12,
                          width: 12,
                          colorFilter: ColorFilter.mode(
                              ColorPalette.yellow, BlendMode.srcIn),
                        ),
                        SizedBox(width: 2),
                        Text(
                          item.star.toString(),
                          style: TextStyle(
                            color: ColorPalette.yellow,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${CurrencyFormatter().numberToCurrency(item.price)}원',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '잔여 ${item.remainAmount}점',
                  style: TextStyle(
                    color: ColorPalette.grey_5,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        item.likes != 0
                            ? Row(
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
                                    item.likes.toString(),
                                    style: TextStyle(
                                      color: ColorPalette.purple,
                                      fontFamily: "PretendardVariable",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0,
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                        SizedBox(width: 5),
                        item.messages != 0
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/message_fill.svg',
                                    height: 12,
                                    width: 12,
                                    colorFilter: ColorFilter.mode(
                                        ColorPalette.purple, BlendMode.srcIn),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    item.messages.toString(),
                                    style: TextStyle(
                                      color: ColorPalette.purple,
                                      fontFamily: "PretendardVariable",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0,
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                    Text(
                      item.timeAgo,
                      style: TextStyle(
                        color: ColorPalette.grey_4,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 11.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
