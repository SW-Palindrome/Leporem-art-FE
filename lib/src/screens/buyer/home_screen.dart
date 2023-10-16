import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_home_controller.dart';
import 'package:leporemart/src/controllers/buyer_item_detail_controller.dart';
import 'package:leporemart/src/controllers/buyer_search_controller.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:leporemart/src/screens/buyer/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class BuyerHomeScreen extends GetView<BuyerHomeController> {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.isEmpty &&
          Get.find<BuyerSearchController>().isSearching.value) {
        return _emptyItemListWidget();
      } else {
        return _buyerItemListWidget();
      }
    });
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

  _buyerItemListWidget() {
    return Container(
      color: ColorPalette.grey_1,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              _searchDropDown(SearchType.sort),
              SizedBox(width: 10),
              _searchDropDown(SearchType.category),
              SizedBox(width: 10),
              _searchDropDown(SearchType.price),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {},
                color: ColorPalette.purple,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification) {
                      if (controller.scrollController.position.extentAfter ==
                          0) {
                        logAnalytics(name: 'buyer_scroll_pagination');
                        controller.fetch(isPagination: true);
                      }
                      if (controller.scrollController.position.extentBefore ==
                          0) {
                        logAnalytics(name: 'buyer_scroll_refresh');
                        controller.pageReset();
                      }
                    }
                    return false;
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      childAspectRatio: 4 / 7,
                    ),
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
    );
  }

  _itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        logAnalytics(
            name: "enter_buyer_item_detail",
            parameters: {"item_id": controller.items[index].id});
        Get.to(BuyerItemDetailScreen(),
            arguments: {'item_id': controller.items[index].id});
        Get.put(BuyerItemDetailController());
        controller.view(controller.items[index].id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.items[index].thumbnailImage,
                    fit: BoxFit.cover,
                    width: Get.width * 0.5,
                    height: Get.width * 0.5,
                  ),
                  if (Get.find<UserGlobalInfoController>().userType ==
                      UserType.member)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: controller.items[index].isLiked
                          ? GestureDetector(
                              onTap: () async {
                                logAnalytics(
                                    name: "buyer_item_unlike",
                                    parameters: {
                                      "item_id": controller.items[index].id
                                    });
                                await controller
                                    .unlike(controller.items[index].id);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/heart_fill.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                    ColorPalette.purple, BlendMode.srcIn),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                logAnalytics(
                                    name: "buyer_item_like",
                                    parameters: {
                                      "item_id": controller.items[index].id
                                    });
                                await controller
                                    .like(controller.items[index].id);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/heart_outline.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                    ColorPalette.white, BlendMode.srcIn),
                              ),
                            ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.items[index].nickname,
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: Get.height * 0.04,
                    child: Text(
                      controller.items[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    controller.items[index].currentAmount == 0
                        ? '판매 완료'
                        : '${CurrencyFormatter().numberToCurrency(controller.items[index].price)}원',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.black,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart_fill.svg',
                        height: 12,
                        width: 12,
                        colorFilter: ColorFilter.mode(
                            controller.items[index].likes != 0
                                ? ColorPalette.purple
                                : Colors.transparent,
                            BlendMode.srcIn),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${controller.items[index].likes}',
                        style: TextStyle(
                          color: controller.items[index].likes != 0
                              ? ColorPalette.purple
                              : Colors.transparent,
                          fontSize: 10,
                        ),
                      ),
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

  _searchDropDown(SearchType searchType) {
    switch (searchType) {
      case SearchType.sort:
        return GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_search_filter_change",
                parameters: {"search_type": "sort"});
            controller.changeSelectedSearchType(0);
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
      case SearchType.category:
        return GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_search_filter_change",
                parameters: {"search_type": "category"});
            controller.changeSelectedSearchType(1);
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
          child: _categoryDropDown(),
        );
      case SearchType.price:
        return GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_search_filter_change",
                parameters: {"search_type": "price"});
            controller.changeSelectedSearchType(2);
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
          child: _priceDropDown(),
        );
    }
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

  _categoryDropDown() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border.all(
              color:
                  controller.displayedCategoryType.value.contains(true) == false
                      ? ColorPalette.grey_3
                      : ColorPalette.purple),
          borderRadius: BorderRadius.circular(20),
          color: controller.displayedCategoryType.value.contains(true) == false
              ? ColorPalette.white
              : ColorPalette.purple,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(
              controller.displayedCategoryType.value.contains(true) == false
                  ? '작품 종류'
                  : (controller.displayedCategoryType
                              .where((element) => element == true)
                              .length ==
                          1
                      ? controller.categoryTypes[
                          controller.displayedCategoryType.value.indexOf(true)]
                      : controller.displayedCategoryType.value
                          .where((element) => element == true)
                          .length
                          .toString()),
              style: TextStyle(
                fontSize: 12,
                color: controller.displayedCategoryType.value.contains(true) ==
                        false
                    ? ColorPalette.grey_6
                    : ColorPalette.white,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                logAnalytics(
                    name: "buyer_search_filter_reset",
                    parameters: {"search_type": "category"});
                controller.resetSelectedCategoryType();
              },
              child: SvgPicture.asset(
                controller.displayedCategoryType.value.contains(true) == false
                    ? 'assets/icons/arrow_down.svg'
                    : 'assets/icons/cancel.svg',
                height: 10,
                width: 10,
                colorFilter: ColorFilter.mode(
                  controller.displayedCategoryType.value.contains(true) == false
                      ? ColorPalette.grey_4
                      : ColorPalette.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _priceDropDown() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: controller.displayedPriceRange.value == RangeValues(0, 36)
                  ? ColorPalette.grey_3
                  : ColorPalette.purple),
          borderRadius: BorderRadius.circular(20),
          color: controller.displayedPriceRange.value == RangeValues(0, 36)
              ? ColorPalette.white
              : ColorPalette.purple,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(
              controller.displayedPriceRange.value == RangeValues(0, 36)
                  ? '가격대'
                  : '${controller.priceRange[controller.displayedPriceRange.value.start.toInt()].toString().replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      )}원 ~ ${controller.priceRange[controller.displayedPriceRange.value.end.toInt()].toString().replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      )}원',
              style: TextStyle(
                fontSize: 12,
                color:
                    controller.displayedPriceRange.value == RangeValues(0, 36)
                        ? ColorPalette.grey_6
                        : ColorPalette.white,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                controller.resetSelectedPriceRange();
              },
              child: SvgPicture.asset(
                controller.displayedPriceRange.value == RangeValues(0, 36)
                    ? 'assets/icons/arrow_down.svg'
                    : 'assets/icons/cancel.svg',
                height: 10,
                width: 10,
                colorFilter: ColorFilter.mode(
                  controller.displayedPriceRange.value == RangeValues(0, 36)
                      ? ColorPalette.grey_4
                      : ColorPalette.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchSheetWidget() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    logAnalytics(
                        name: "buyer_search_filter_change",
                        parameters: {"search_type": "sort"});
                    controller.changeSelectedSearchType(0);
                  },
                  child: Text(
                    '정렬',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: controller.selectedSearchType.value == 0
                          ? ColorPalette.black
                          : ColorPalette.grey_4,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    logAnalytics(
                        name: "buyer_search_filter_change",
                        parameters: {"search_type": "category"});
                    controller.changeSelectedSearchType(1);
                  },
                  child: Text(
                    '작품 종류',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: controller.selectedSearchType.value == 1
                          ? ColorPalette.black
                          : ColorPalette.grey_4,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    logAnalytics(
                        name: "buyer_search_filter_change",
                        parameters: {"search_type": "price"});
                    controller.changeSelectedSearchType(2);
                  },
                  child: Text(
                    '가격대',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: controller.selectedSearchType.value == 2
                          ? ColorPalette.black
                          : ColorPalette.grey_4,
                      fontSize: 18,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/cancel.svg',
                    height: 24,
                    width: 24,
                    colorFilter:
                        ColorFilter.mode(ColorPalette.black, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (controller.selectedSearchType.value == 0) _sortModal(),
            if (controller.selectedSearchType.value == 1) _categoryModal(),
            if (controller.selectedSearchType.value == 2) _priceModal(),
            SizedBox(height: 48),
            _searchModalBottom(),
          ],
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
                name: "buyer_sort_filter_change",
                parameters: {"sort_type": "recent"});
            controller.changeSelectedSortType(0);
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
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
                    : SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2, thickness: 2),
        GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_sort_filter_change",
                parameters: {"sort_type": "like"});
            controller.changeSelectedSortType(1);
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
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
                    : SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2, thickness: 2),
        GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_sort_filter_change",
                parameters: {"sort_type": "price_low"});
            controller.changeSelectedSortType(2);
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
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
                    : SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Divider(color: ColorPalette.grey_2, thickness: 2),
        GestureDetector(
          onTap: () {
            logAnalytics(
                name: "buyer_sort_filter_change",
                parameters: {"sort_type": "price_-high"});
            controller.changeSelectedSortType(3);
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
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
                    : SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _categoryModal() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (int i = 0; i < controller.categoryTypes.length; i++)
          GestureDetector(
            onTap: () {
              controller.changeSelectedCategoryType(i);
              logAnalytics(name: "buyer_category_filter_change", parameters: {
                "category_type": i,
                "value": controller.selectedCategoryType[i].toString()
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: controller.selectedCategoryType.value[i]
                    ? ColorPalette.purple
                    : Colors.white,
                border: Border.all(
                    color: controller.selectedCategoryType.value[i]
                        ? ColorPalette.purple
                        : ColorPalette.grey_3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                controller.categoryTypes[i],
                style: TextStyle(
                  color: controller.selectedCategoryType.value[i]
                      ? Colors.white
                      : ColorPalette.black,
                  fontSize: 14,
                ),
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
            onTap: () async {
              logAnalytics(name: "buyer_filter_reset");
              await controller.resetSelected();
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
          value: controller.isApplyValid(),
          onTap: () {
            logAnalytics(name: "buyer_filter_apply");
            controller.applyFilter();
            Get.back();
          },
          width: Get.width * 0.5,
        ),
      ],
    );
  }

  _priceModal() {
    return Column(
      children: [
        Text(
          //int a = 10000 일때 10,000원으로 표시하기 위해 000단위마다 ,를 찍어줌
          '${controller.priceRange[controller.selectedPriceRange.value.start.toInt()].toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              )}원 ~ ${controller.priceRange[controller.selectedPriceRange.value.end.toInt()].toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              )}원',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.w600,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 18.0,
          ),
        ),
        RangeSlider(
          values: controller.selectedPriceRange.value,
          min: 0,
          max: controller.priceRange.length - 1,
          onChanged: (RangeValues newRange) {
            controller.changeSelectedPriceRange(newRange);
          },
          activeColor: ColorPalette.purple,
          inactiveColor: ColorPalette.grey_3,
          labels: RangeLabels(
            controller
                .priceRange[controller.selectedPriceRange.value.start.toInt()]
                .toString(),
            controller
                .priceRange[controller.selectedPriceRange.value.end.toInt()]
                .toString(),
          ),
        ),
      ],
    );
  }
}

enum SearchType {
  sort,
  category,
  price,
}
