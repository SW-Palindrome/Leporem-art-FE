import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/seller_home_controller.dart';
import 'package:leporemart/src/controllers/seller_item_detail_controller.dart';
import 'package:leporemart/src/controllers/seller_search_controller.dart';
import 'package:leporemart/src/screens/seller/item_create_screen.dart';
import 'package:leporemart/src/screens/seller/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class SellerHomeScreen extends GetView<SellerHomeController> {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.isEmpty && !controller.isLoading.value) {
        if (Get.find<SellerSearchController>().isSearching.value) {
          return _emptySearchListWidget();
        } else {
          return _emptyItemListWidget();
        }
      } else {
        return _sellerItemListWidget();
      }
    });
  }

  _emptySearchListWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text('검색한 결과가 없어요.',
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.grey_5,
                fontFamily: FontPalette.pretenderd,
              )),
        ],
      ),
    );
  }

  _emptyItemListWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text(
            '아직 등록한 작품이 없어요.\n작품을 등록해보세요!',
            style: TextStyle(
              fontSize: 16,
              color: ColorPalette.grey_5,
              fontFamily: FontPalette.pretenderd,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              logAnalytics(name: "enter_item_create");
              Get.to(ItemCreateScreen());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, -0.07),
                  end: Alignment(-1, 0.07),
                  colors: [Color(0xFF9C00E6), Color(0xFF594BF8)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: 20,
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(ColorPalette.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '작품 등록하기',
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 16,
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

  _sellerItemListWidget() {
    return Stack(
      children: [
        Container(
          color: ColorPalette.grey_1,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _searchDropDown(),
                  Obx(
                    () => Text(
                      '총 ${controller.totalCount.value}개',
                      style: TextStyle(
                        color: ColorPalette.grey_5,
                        fontFamily: FontPalette.pretenderd,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Obx(
                  () => RefreshIndicator(
                    onRefresh: () async {},
                    color: ColorPalette.purple,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification) {
                          if (controller
                                  .scrollController.position.extentAfter ==
                              0) {
                            logAnalytics(name: 'seller_scroll_pagination');
                            controller.fetch(isPagination: true);
                          }
                          if (controller
                                  .scrollController.position.extentBefore ==
                              0) {
                            logAnalytics(name: 'seller_scroll_refresh');
                            controller.pageReset();
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: controller.scrollController,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          return _itemWidget(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Get.width * 0.03,
          right: Get.width * 0.05,
          child: GestureDetector(
            onTap: () {
              logAnalytics(name: "enter_item_create");
              Get.to(ItemCreateScreen());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 11.5),
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
                  SizedBox(width: 4),
                  Text(
                    '작품등록',
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 14,
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
        logAnalytics(
            name: "seller_search_filter_change",
            parameters: {"search_type": "sort"});
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
          onTap: () {
            logAnalytics(
                name: "seller_sort_filter_change",
                parameters: {"sort_type": "recent"});
            controller.changeSelectedSortType(0);
          },
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
          onTap: () {
            logAnalytics(
                name: "seller_sort_filter_change",
                parameters: {"sort_type": "like"});
            controller.changeSelectedSortType(1);
          },
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
          onTap: () {
            logAnalytics(
                name: "seller_sort_filter_change",
                parameters: {"sort_type": "price_low"});
            controller.changeSelectedSortType(2);
          },
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
          onTap: () {
            logAnalytics(
                name: "seller_sort_filter_change",
                parameters: {"sort_type": "price_high"});
            controller.changeSelectedSortType(3);
          },
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
              logAnalytics(name: "seller_filter_reset");
              controller.resetSelected();
              Get.back();
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
          onTap: () {
            logAnalytics(name: "seller_filter_apply");
            controller.applyFilter();
            Get.back();
          },
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
              controller.sortTypes[controller.displayedSortType.value],
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

  _itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        logAnalytics(
            name: "enter_seller_item_detail",
            parameters: {"item_id": controller.items[index].id});
        Get.to(SellerItemDetailScreen(),
            arguments: {'item_id': controller.items[index].id});
        Get.put(SellerItemDetailController());
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                controller.items[index].thumbnailImage,
                height: Get.width * 0.23,
                width: Get.width * 0.23,
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
                        controller.items[index].title,
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
                            controller.items[index].star.toString(),
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
                  SizedBox(height: 8),
                  Text(
                    '${CurrencyFormatter().numberToCurrency(controller.items[index].price)}원',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '잔여 ${controller.items[index].currentAmount}점',
                    style: TextStyle(
                      color: ColorPalette.grey_5,
                      fontWeight: FontWeight.w400,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.items[index].timeDiff,
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
      ),
    );
  }
}
