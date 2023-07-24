import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class SellerHomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<SellerHomeItem> sellerHomeItems = <SellerHomeItem>[].obs;
  List<String> sortTypes = ['최신순', '인기순', '가격 낮은 순', '가격 높은 순'];
  Rx<int> selectedSortType = 0.obs;

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
      final List<SellerHomeItem> fetchedSellerHomeItems =
          await _homeRepository.fetchSellerHomeItems(currentPage);
      sellerHomeItems.addAll(fetchedSellerHomeItems);
      currentPage++;
    } catch (e) {
      // 에러 처리
      print('Error fetching seller home items in controller: $e');
    }
  }

  void changeSelectedSortType(int index) {
    selectedSortType.value = index;
  }

  void resetSelected() {
    selectedSortType.value = 0;
  }

  bool isResetValid() {
    return selectedSortType.value != 0;
  }

  void pageReset() async {
    resetSelected();
    currentPage = 1;
    await fetch();
  }
}
