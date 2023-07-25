import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_search_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class BuyerHomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<BuyerHomeItem> items = <BuyerHomeItem>[].obs;
  List<String> searchTypes = ['정렬', '작품 종류', '가격대'];
  Rx<int> selectedSearchType = 0.obs;
  List<String> sortTypes = ['최신순', '인기순', '가격 낮은 순', '가격 높은 순'];
  Rx<int> selectedSortType = 0.obs;
  List<String> categoryTypes = ['그릇', '컵', '접시', '그릇', '기타'];
  RxList<bool> selectedCategoryType = List.generate(5, (index) => false).obs;
  Rx<RangeValues> selectedPriceRange = RangeValues(0, 36).obs;

  Rx<int> displayedSortType = 0.obs;
  RxList<bool> displayedCategoryType = List.generate(5, (index) => false).obs;
  Rx<RangeValues> displayedPriceRange = RangeValues(0, 36).obs;

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

  // 페이지네이션을 위한 페이지변수와 스크롤 컨트롤러
  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      String category = '';
      for (int i = 0; i < categoryTypes.length; i++) {
        if (selectedCategoryType[i]) {
          category += '${categoryTypes[i]},';
        }
      }
      String ordering = '';
      switch (selectedSortType.value) {
        case 0:
          ordering = 'recent';
          break;
        case 1:
          ordering = 'likes';
          break;
        case 2:
          ordering = 'price_low';
          break;
        case 3:
          ordering = 'price_hight';
          break;
      }
      String price =
          '${priceRange[selectedPriceRange.value.start.toInt()]},${priceRange[selectedPriceRange.value.end.toInt()]}';
      final List<BuyerHomeItem> fetchedItems =
          await _homeRepository.fetchBuyerHomeItems(
        currentPage,
        keyword: Get.find<BuyerSearchController>().searchController.text,
        price: price,
        category: category,
        ordering: ordering,
      );
      items.addAll(fetchedItems);
      currentPage++;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer home items in controller: $e');
    }
  }

  void changeSelectedSearchType(int index) {
    selectedSearchType.value = index;
  }

  void changeSelectedSortType(int index) {
    selectedSortType.value = index;
  }

  void changeSelectedCategoryType(int index) {
    selectedCategoryType[index] = !selectedCategoryType[index];
  }

  void resetSelectedCategoryType() {
    selectedCategoryType.value = List.generate(6, (index) => false);
    displayedCategoryType.value = List.generate(6, (index) => false);
  }

  void changeSelectedPriceRange(RangeValues range) {
    selectedPriceRange.value = range;
  }

  void resetSelectedPriceRange() {
    selectedPriceRange.value = RangeValues(0, 36);
    displayedPriceRange.value = RangeValues(0, 36);
  }

  void resetSelected() {
    selectedSortType.value = 0;
    displayedSortType.value = 0;
    resetSelectedCategoryType();
    resetSelectedPriceRange();
    applyFilter();
  }

  bool isResetValid() {
    return selectedSortType.value != 0 ||
        selectedCategoryType.value.contains(true) ||
        selectedPriceRange.value != RangeValues(0, 36);
  }

  bool isApplyValid() {
    return selectedSortType.value != displayedSortType.value ||
        selectedCategoryType.value.contains(true) ||
        selectedPriceRange.value != displayedPriceRange.value;
  }

  void pageReset() async {
    items.clear();
    resetSelected();
    currentPage = 1;
    await fetch();
  }

  void applyFilter() {
    displayedSortType.value = selectedSortType.value;
    displayedCategoryType.value = selectedCategoryType.value;
    displayedPriceRange.value = selectedPriceRange.value;
    print('정렬: ${selectedSortType.value}\n'
        '카테고리: ${selectedCategoryType.value}\n'
        '가격: ${selectedPriceRange.value}');
    print('적용된 정렬: ${displayedSortType.value}\n'
        '적용된 카테고리: ${displayedCategoryType.value}\n'
        '적용된 가격: ${displayedPriceRange.value}');
    update();
  }

  void search(String keyword) async {
    String category = '';
    String ordering = '';
    String price =
        '${selectedPriceRange.value.start.toString()},${selectedPriceRange.value.end.toString()}';
    for (int i = 0; i < categoryTypes.length; i++) {
      if (selectedCategoryType[i]) {
        category += '${categoryTypes[i]},';
      }
    }
  }
}
