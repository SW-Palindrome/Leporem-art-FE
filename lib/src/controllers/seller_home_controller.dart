import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/seller_profile_controller.dart';
import 'package:leporemart/src/controllers/seller_search_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class SellerHomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<SellerHomeItem> items = <SellerHomeItem>[].obs;
  Rx<int> totalCount = 0.obs;
  List<String> sortTypes = ['최신순', '인기순', '가격 낮은 순', '가격 높은 순'];
  Rx<int> selectedSortType = 0.obs;
  Rx<int> displayedSortType = 0.obs;

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
      if (isPagination!) currentPage++;
      final List<SellerHomeItem> fetchedItems =
          await _homeRepository.fetchSellerHomeItems(
        currentPage,
        nickname:
            Get.find<SellerProfileController>().sellerProfile.value.nickname,
        keyword: Get.find<SellerSearchController>().searchController.text,
        ordering: ordering,
      );
      items.addAll(fetchedItems);
    } catch (e) {
      // 에러 처리
      print('Error fetching seller home items in controller: $e');
    }
  }

  void changeSelectedSortType(int index) {
    selectedSortType.value = index;
  }

  Future<void> resetSelected() async {
    selectedSortType.value = 0;
    displayedSortType.value = 0;
    await fetch();
    await applyFilter();
  }

  bool isResetValid() {
    return selectedSortType.value != 0;
  }

  bool isApplyValid() {
    return selectedSortType.value != displayedSortType.value;
  }

  Future<void> pageReset() async {
    items.clear();
    currentPage = 1;
    await fetch();
  }

  Future<void> applyFilter() async {
    displayedSortType.value = selectedSortType.value;
    await pageReset();
  }
}
