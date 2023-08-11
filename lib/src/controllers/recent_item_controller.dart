import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/recent_item_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class RecentItemController extends GetxController {
  final RecentItemRepository _recentItemRepository = RecentItemRepository();

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
          await _recentItemRepository.fetchRecentItems();
      items.assignAll(fetchedItems);
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      print('Error fetching recent items: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> delete(int itemId) async {
    try {
      // API 요청
      final response = await DioSingleton.dio.delete('/items/viewed',
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
      //itemId가 일치하는 아이템 삭제
      items.removeWhere((element) => element.id == itemId);
      items.refresh();
    } catch (e) {
      // 에러 처리
      print('Error delete $itemId in home $e');
    }
  }

  void totalDelete() {
    // items에 있는 모든 items를 삭제하는 함수
    for (int i = items.length - 1; i >= 0; i--) {
      delete(items[i].id);
    }
  }

  Future<void> like(int itemId) async {
    try {
      items.firstWhere((element) => element.id == itemId).like();
      items.refresh();
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
    } catch (e) {
      // 에러 처리
      print('Error fetching like $itemId in home $e');
    }
  }

  Future<void> unlike(int itemId) async {
    try {
      items.firstWhere((element) => element.id == itemId).unlike();
      items.refresh();
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
    } catch (e) {
      // 에러 처리
      print('Error fetching like $itemId in home $e');
    }
  }
}
