import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<Item> items = <Item>[].obs;
  Rx<int> selectedSearchType = 0.obs; //0 정렬, 1 작품 종류, 2 가격대
  Rx<int> selectedSortType = 0.obs; //0 최신순, 1 인기순, 2 가격 낮은 순, 3 가격 높은 순
  Rx<int> selectCategoryType =
      (-1).obs; //0 머그컵, 1 술잔, 2 화병, 3 오브제, 4 그릇, 5 기타, -1 아무것도 선택하지 않은 상태
  Rx<RangeValues> selectedPriceRange = RangeValues(0, 36).obs;
  List<int> priceRange = [
    1000,
    2000,
    3000,
    4000,
    5000,
    6000,
    7000,
    8000,
    9000,
    10000,
    15000,
    20000,
    25000,
    30000,
    35000,
    40000,
    45000,
    50000,
    55000,
    60000,
    65000,
    70000,
    75000,
    80000,
    85000,
    90000,
    95000,
    100000,
    200000,
    300000,
    400000,
    500000,
    600000,
    700000,
    800000,
    900000,
    1000000
  ];
  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      final List<Item> fetchedItems = await _homeRepository.fetchItems();
      items.assignAll(fetchedItems);
    } catch (e) {
      // 에러 처리
      print('Error fetching items in controller: $e');
    }
  }

  void changeSelectedSearchType(int index) {
    selectedSearchType.value = index;
  }

  void changeSelectedSortType(int index) {
    selectedSortType.value = index;
  }

  void changeSelectedCategoryType(int index) {
    if (selectCategoryType.value == index) {
      selectCategoryType.value = -1;
      return;
    }
    selectCategoryType.value = index;
  }

  void changeSelectedPriceRange(RangeValues range) {
    selectedPriceRange.value = range;
  }

  void resetSelected() {
    selectedSortType.value = 0;
    selectCategoryType.value = -1;
    selectedPriceRange.value = RangeValues(0, 36);
  }

  bool isResetValid() {
    return selectedSortType.value != 0 ||
        selectCategoryType.value != -1 ||
        selectedPriceRange.value != RangeValues(0, 36);
  }
}
