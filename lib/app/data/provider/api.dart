import 'dart:io';

import 'package:dio/dio.dart';

import '../models/exhibition.dart';
import '../models/delivery_info.dart';
import '../models/item.dart';
import '../models/item_detail.dart';
import '../models/message.dart';
import '../models/order.dart';
import '../models/profile.dart';

abstract class ApiClient {
  // 계정관리부분
  Future<void> sendEmail(String emailAddress);
  Future<bool> checkCode(String emailCode);
  Future<bool> isDuplicate(String nickname);
  Future<bool> signupWithKakao(String nickname);
  Future<bool> signupWithApple(String userIdentifier, String nickname);

  //fcm
  Future<void> registerFcmDevice();

  // 작품 좋아요
  Future<void> like(int itemId);
  Future<void> unlike(int itemId);

  // 최근본작품
  Future<void> view(int itemId);
  Future<bool> deleteRecentItem(int itemId);
  Future<List<RecentItem>> fetchRecentItems();

  // 프로필조회
  Future<BuyerProfile?> fetchBuyerProfile();
  Future<SellerProfile?> fetchSellerProfile();
  Future<SellerProfile?> fetchCreatorProfile(String nickname);

  // 계정관리
  Future<void> editBuyerProfile(bool isNicknameChanged,
      bool isProfileImageChanged, String nickname, File profileImage);
  Future<void> editSellerProfile(
      bool isNicknameChanged,
      bool isProfileImageChanged,
      bool isDescriptionChanged,
      String nickname,
      File profileImage,
      String description);
  Future<void> inactive();

  // 로그인
  Future<dynamic> getUserInfo();

  // 리뷰작성
  Future<void> createReview(int orderId, int star, String description);

  // 판매자 작품등록 및 수정
  Future<dynamic> getPreSignedShortsUrl(String extension);
  Future<dynamic> createItem(FormData formData);
  Future<dynamic> editItem(int itemId, FormData formData);
  Future<dynamic> increaseAmount(int itemId);
  Future<dynamic> decreaseAmount(int itemId);

  // 작품 목록 조회
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  });
  Future<List<BuyerHomeItem>> fetchGuestHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  });
  Future<List<BuyerHomeItem>> fetchBuyerCreatorItems(
    int page, {
    String? nickname,
    isPagination = false,
  });
  Future<List<SellerHomeItem>> fetchSellerHomeItems(
    int page, {
    String? nickname,
    String? ordering,
    String? keyword,
    isPagination = false,
  });

  // 작품 상세 조회
  Future<BuyerItemDetail?> fetchBuyerItemDetail(int itemID);
  Future<SellerItemDetail?> fetchSellerItemDetail(int itemID);

  // 메시지 플러스 기능
  Future<List<MessageItem>> fetchShareMessageItem(int page, {String? nickname});
  Future<List<MessageItem>> fetchOrderMessageItem(int page, {String? nickname});
  Future<int?> orderItem(int itemId, String name, String address,
      String zipCode, String addressDetail, String phoneNumber);
  Future<List<ChatRoom>> fetchBuyerChatRooms();
  Future<List<ChatRoom>> fetchSellerChatRooms();
  Future<List<BuyerOrder>> fetchBuyerOrders();
  Future<List<SellerOrder>> fetchSellerOrders();
  Future<List<Message>> fetchChatRoomMessages(
      String chatRoomUuid, String? messageUuid);
  Future<void> readChatRoomMessages(ChatRoom chatRoom, Message message);

  // 배송상태 변경
  Future<void> deliveryStartOrder(int orderId);
  Future<void> deliveryCompleteOrder(int orderId);
  Future<void> cancelOrder(int orderId);
  Future<OrderInfo> fetchOrder(int orderId);
  Future<String?> fetchDeliveryInfoUrl(int orderId);
  Future<void> updateDeliveryInfo(
      int orderId, String deliveryCompany, String invoiceNumber);
  Future<DeliveryInfo?> fetchDeliveryInfo(int orderId);

  // 전시전
  Future<List<Exhibition>> fetchSellerExhibitions();
  Future<ExhibitionArtist?> fetchExhibitionArtistById(int exhibitionId);
  Future<List<ExhibitionItem>> fetchExhibitionItemById(int exhibitionId);
  Future<dynamic> removeExhibitionItem(int exhibitionId, int itemId);
  Future<dynamic> saveExhibitionIntroductionById(
      int exhibitionId, FormData formData);
  Future<dynamic> saveExhibitionArtistById(int exhibitionId, FormData formData);
  Future<dynamic> createExhibitionItemById(int exhibitionId, FormData formData);
  Future<dynamic> editExhibitionItemById(
      int exhibitionId, int itemId, FormData formData);
  Future<dynamic> getPreSignedSoundUrl(String extension);
}
