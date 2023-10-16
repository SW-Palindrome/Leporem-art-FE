import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/home_repository.dart';
import 'package:leporemart/app/data/repositories/recent_item_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/item.dart';

class RecentItemController extends GetxController {
  final HomeRepository homeRepository;
  final RecentItemRepository recentItemRepository;
  RecentItemController(
      {required this.homeRepository, required this.recentItemRepository})
      : assert(homeRepository != null && recentItemRepository != null);

  RxList<RecentItem> items = <RecentItem>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      isLoading.value = true;
      List<RecentItem> fetchedItems =
          await recentItemRepository.fetchRecentItems();
      items.assignAll(fetchedItems);
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching recent items: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> delete(int itemId) async {
    if (await recentItemRepository.deleteRecentItem(itemId)) {
      items.removeWhere((element) => element.id == itemId);
      items.refresh();
    }
  }

  void totalDelete() {
    // items에 있는 모든 items를 삭제하는 함수
    for (int i = items.length - 1; i >= 0; i--) {
      delete(items[i].id);
    }
  }

  Future<void> like(int itemId) async {
    items.firstWhere((element) => element.id == itemId).like();
    items.refresh();
    homeRepository.like(itemId);
  }

  Future<void> unlike(int itemId) async {
    items.firstWhere((element) => element.id == itemId).unlike();
    items.refresh();
    homeRepository.unlike(itemId);
  }
}
