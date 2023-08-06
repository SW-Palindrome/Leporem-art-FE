import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/repositories/home_repository.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

import '../models/message.dart';
import 'message_controller.dart';

class BuyerItemCreatorController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final HomeRepository _homeRepository = HomeRepository();

  RxList<BuyerHomeItem> items = <BuyerHomeItem>[].obs;
  Rx<SellerProfile> creatorProfile = SellerProfile(
    nickname: '-',
    profileImageUrl:
        'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
    itemCount: 0,
    totalTransaction: 0,
    temperature: 100,
    retentionRate: 0.0,
    description: '',
  ).obs;

  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch({bool isPagination = false}) async {
    try {
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
        throw ('Error fetching buyer home items in controller: $e');
      }
      try {
        final fetchCreatorProfile = await _profileRepository
            .fetchCreatorProfile(Get.arguments['nickname']);
        creatorProfile.value = fetchCreatorProfile;
      } catch (e) {
        // 에러 처리
        throw ('Error fetching seller profile: $e');
        // 목업 데이터 사용 또는 에러 처리 로직 추가
      }
    } catch (e) {
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

  Future<ChatRoom> getOrCreateChatRoom() async {
    MessageController messageController = Get.find<MessageController>();
    ChatRoom? chatRoom = messageController.getChatRoomByOpponentNickname(controller.creatorProfile.value.nickname);
    if (chatRoom != null) {
      return chatRoom;
    }
    return await messageController.createTempChatRoom(controller.creatorProfile.value.nickname);
  }
}
