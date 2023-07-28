import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_home_controller.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/screens/buyer/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/item_widget.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class BuyerHomeScreen extends GetView<BuyerHomeController> {
  BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              () => NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo is ScrollEndNotification) {
                    if (controller.scrollController.position.extentAfter == 0) {
                      controller.fetch(isPagination: true);
                    }
                    if (controller.scrollController.position.extentBefore ==
                        0) {
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
                    if (index < controller.items.length) {
                      return itemWidget(controller.items[index]);
                    } else {
                      // Show a loading indicator at the end of the grid
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchDropDown(SearchType searchType) {
    switch (searchType) {
      case SearchType.sort:
        return GestureDetector(
          onTap: () {
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
                controller.resetSelectedCategoryType();
              },
              child: SvgPicture.asset(
                controller.displayedCategoryType.value.contains(true) == false
                    ? 'assets/icons/arrow_down.svg'
                    : 'assets/icons/cancle.svg',
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
                    : 'assets/icons/cancle.svg',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.changeSelectedSearchType(0),
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
                    onTap: () => controller.changeSelectedSearchType(1),
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
                    onTap: () => controller.changeSelectedSearchType(2),
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
                      'assets/icons/cancle.svg',
                      height: 24,
                      width: 24,
                      colorFilter:
                          ColorFilter.mode(ColorPalette.black, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.width * 0.1),
              IndexedStack(
                index: controller.selectedSearchType.value,
                children: [
                  _sortModal(),
                  _categoryModal(),
                  _priceModal(),
                ],
              ),
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

  _categoryModal() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (int i = 0; i < controller.categoryTypes.length; i++)
          GestureDetector(
            onTap: () => controller.changeSelectedCategoryType(i),
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
