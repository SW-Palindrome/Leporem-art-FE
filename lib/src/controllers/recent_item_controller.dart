import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/recent_item_repository.dart';

class RecentItemController extends GetxController {
  final RecentItemRepository _recentItemRepository = RecentItemRepository();

  RxList<RecentItem> items = <RecentItem>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      List<RecentItem> fetchedItems =
          await _recentItemRepository.fetchRecentItems();
      items.assignAll(fetchedItems);
    } catch (e) {
      // 에러 처리
      print('Error fetching recent items: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
