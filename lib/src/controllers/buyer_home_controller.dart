import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/buyer_search_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class BuyerHomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<BuyerHomeItem> items = <BuyerHomeItem>[].obs;
  List<String> searchTypes = ['정렬', '작품 종류', '가격대'];
  Rx<int> selectedSearchType = 0.obs;
  List<String> sortTypes = ['최신순', '인기순', '가격 낮은 순', '가격 높은 순'];
  Rx<int> selectedSortType = 0.obs;
  List<String> categoryTypes = ['그릇', '접시', '컵', '화분', '기타'];
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

  Future<void> fetch({bool isPagination = false}) async {
    try {
      String category = '';
      for (int i = 0; i < categoryTypes.length; i++) {
        if (displayedCategoryType[i]) {
          category += '${categoryTypes[i]},';
        }
      }
      String ordering = '';
      switch (displayedSortType.value) {
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
          ordering = 'price_high';
          break;
      }
      String price =
          '${priceRange[displayedPriceRange.value.start.toInt()]},${priceRange[displayedPriceRange.value.end.toInt()]}';

      if (isPagination!) currentPage++;
      final List<BuyerHomeItem> fetchedItems =
          await _homeRepository.fetchBuyerHomeItems(
        currentPage,
        keyword: Get.find<BuyerSearchController>().searchController.text,
        price: price,
        category: category,
        ordering: ordering,
        isPagination: isPagination,
      );
      items.addAll(fetchedItems);
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
    pageReset();
  }

  void changeSelectedPriceRange(RangeValues range) {
    selectedPriceRange.value = range;
  }

  void resetSelectedPriceRange() {
    selectedPriceRange.value = RangeValues(0, 36);
    displayedPriceRange.value = RangeValues(0, 36);
    pageReset();
  }

  Future<void> resetSelected() async {
    selectedSortType.value = 0;
    displayedSortType.value = 0;
    resetSelectedCategoryType();
    resetSelectedPriceRange();
    await fetch();
    await applyFilter();
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

  Future<void> pageReset() async {
    items.clear();
    currentPage = 1;
    await fetch();
  }

  Future<void> applyFilter() async {
    displayedSortType.value = selectedSortType.value;
    displayedCategoryType.value = selectedCategoryType.value;
    displayedPriceRange.value = selectedPriceRange.value;
    await pageReset();
  }

  Future<void> like(int itemId) async {
    try {
      print('좋아요');
      // API 요청
      final response = await DioSingleton.dio.post('/items/like',
          data: {'item_id': itemId},
          options: Options(
            headers: {
              "Authorization":
                  "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
            },
          ));
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
      items.firstWhere((element) => element.id == itemId).like();
      items.refresh();
    } catch (e) {
      // 에러 처리
      print('Error fetching like $itemId in home $e');
    }
  }

  Future<void> unlike(int itemId) async {
    try {
      print('좋아요 해제');
      // API 요청
      final response = await DioSingleton.dio.delete('/items/like',
          data: {'item_id': itemId},
          options: Options(
            headers: {
              "Authorization":
                  "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
            },
          ));
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
      //items중 id값이 itemId인 아이템의 is_liked를 false로 바꿔줌
      items.firstWhere((element) => element.id == itemId).unlike();
      items.refresh();
    } catch (e) {
      // 에러 처리
      print('Error fetching like $itemId in home $e');
    }
  }

  Future<void> view(int itemId) async {
    try {
      // API 요청
      final response = await DioSingleton.dio.post('/items/viewed',
          data: {'item_id': itemId},
          options: Options(
            headers: {
              "Authorization":
                  "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
            },
          ));
      if (response.statusCode != 201) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
    } catch (e) {
      // 에러 처리
      print('Error fetching viewed $itemId in home $e');
    }
  }
}
