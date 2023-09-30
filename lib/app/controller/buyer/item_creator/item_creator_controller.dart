import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/item.dart';
import '../../../data/models/message.dart';
import '../../../data/models/profile.dart';
import '../../../data/provider/dio.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../common/message/message_controller.dart';

class ItemCreatorController extends GetxController {
  final ProfileRepository profileRepository;
  final HomeRepository homeRepository;
  ItemCreatorController(
      {required this.profileRepository, required this.homeRepository})
      : assert(profileRepository != null && homeRepository != null);

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
            await homeRepository.fetchBuyerCreatorItems(
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
        SellerProfile? data = await profileRepository
            .fetchCreatorProfile(Get.arguments['nickname']);
        if (data == null) {
          Get.snackbar('요청 오류', '프로필을 불러올 수 없습니다.');
          return;
        }
        creatorProfile.value = data;
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
    items.firstWhere((element) => element.id == itemId).like();
    items.refresh();
    await homeRepository.like(itemId);
  }

  Future<void> unlike(int itemId) async {
    items.firstWhere((element) => element.id == itemId).unlike();
    items.refresh();
    await homeRepository.unlike(itemId);
  }

  Future<ChatRoom> getOrCreateChatRoom() async {
    MessageController messageController = Get.find<MessageController>();
    ChatRoom? chatRoom = messageController
        .getChatRoomByOpponentNicknameFromBuyer(creatorProfile.value.nickname);
    if (chatRoom != null) {
      return chatRoom;
    }
    return await messageController
        .createTempChatRoom(creatorProfile.value.nickname);
  }
}
