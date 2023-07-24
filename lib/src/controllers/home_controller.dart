import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<Item> items = <Item>[].obs;
  List<String> searchTypes = ['정렬', '작품 종류', '가격대'];
  Rx<int> selectedSearchType = 0.obs;
  List<String> sortTypes = ['최신순', '인기순', '가격 낮은 순', '가격 높은 순'];
  Rx<int> selectedSortType = 0.obs;
  List<String> categoryTypes = ['머그컵', '술잔', '화병', '오브제', '그릇', '기타'];
  RxList<bool> selectedCategoryType = List.generate(6, (index) => false).obs;
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
      final List<Item> fetchedItems =
          await _homeRepository.fetchItems(currentPage);
      items.addAll(fetchedItems);
      currentPage++;
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
    selectedCategoryType[index] = !selectedCategoryType[index];
  }

  void resetSelectedCategoryType() {
    selectedCategoryType.value = List.generate(6, (index) => false);
  }

  void changeSelectedPriceRange(RangeValues range) {
    selectedPriceRange.value = range;
  }

  void resetSelected() {
    selectedSortType.value = 0;
    resetSelectedCategoryType();
    selectedPriceRange.value = RangeValues(0, 36);
  }

  bool isResetValid() {
    return selectedSortType.value != 0 ||
        selectedCategoryType.value.contains(true) ||
        selectedPriceRange.value != RangeValues(0, 36);
  }

  void pageReset() {
    items.clear();
    resetSelected();
    currentPage = 1;
    fetch();
  }
}
