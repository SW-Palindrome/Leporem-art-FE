import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/controller/common/user_global_info/user_global_info_controller.dart';

import '../../../data/models/item.dart';
import '../../../data/repositories/home_repository.dart';
import '../profile/seller_profile_controller.dart';
import '../search/seller_search_controller.dart';

class SellerHomeController extends GetxController {
  final HomeRepository repository;
  SellerHomeController({required this.repository}) : assert(repository != null);

  RxList<SellerHomeItem> items = <SellerHomeItem>[].obs;
  Rx<bool> isLoading = false.obs;

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
      isLoading.value = true;
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
          await repository.fetchSellerHomeItems(
        currentPage,
        nickname: Get.find<UserGlobalInfoController>().nickname,
        keyword: Get.find<SellerSearchController>().searchController.text,
        ordering: ordering,
      );
      items.addAll(fetchedItems);
      isLoading.value = false;
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
