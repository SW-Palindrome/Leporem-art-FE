import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class BuyerItemCreatorController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  RxList<BuyerHomeItem> items = <BuyerHomeItem>[].obs;

  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch({bool isPagination = false}) async {
    try {
      if (isPagination!) currentPage++;
      final List<BuyerHomeItem> fetchedItems =
          await _homeRepository.fetchBuyerCreatorItems(
        currentPage,
        nickname: Get.arguments['nickname'],
        isPagination: isPagination,
      );
      items.addAll(fetchedItems);
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer home items in controller: $e');
    }
  }

  Future<void> pageReset() async {
    items.clear();
    currentPage = 1;
    await fetch();
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
}
