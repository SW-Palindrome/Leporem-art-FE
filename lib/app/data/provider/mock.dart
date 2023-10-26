import 'dart:io';

import 'package:dio/dio.dart';

import '../models/delivery_info.dart';
import '../models/exhibition.dart';
import '../models/item.dart';
import '../models/item_detail.dart';
import '../models/message.dart';
import '../models/order.dart';
import '../models/profile.dart';
import 'api.dart';

class MockClient implements ApiClient {
  @override
  Future<void> sendEmail(String emailAddress) async {}

  @override
  Future<bool> checkCode(String emailCode) async {
    return true;
  }

  @override
  Future<bool> isDuplicate(String nickname) async {
    return false;
  }

  @override
  Future<bool> signupWithKakao(String nickname) async {
    return true;
  }

  @override
  Future<bool> signupWithApple(String userIdentifier, String nickname) async {
    return true;
  }

  @override
  Future<void> registerFcmDevice() async {}

  @override
  Future<void> like(int itemId) async {}

  @override
  Future<void> unlike(int itemId) async {}

  @override
  Future<void> view(int itemId) async {}

  @override
  Future<bool> deleteRecentItem(int itemId) async {
    return true;
  }

  @override
  Future<List<RecentItem>> fetchRecentItems() async {
    List<RecentItem> recentItems = [];
    for (int i = 1; i < 11; i++) {
      recentItems.add(RecentItem(
          nickname: '공예쁨 $i',
          isLiked: true,
          price: 10000,
          id: i,
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시'));
    }
    return recentItems;
  }

  // 프로필조회
  @override
  Future<BuyerProfile?> fetchBuyerProfile() async {
    return BuyerProfile(
        nickname: '공예쁨',
        profileImage:
            'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
        isSeller: true);
  }

  @override
  Future<SellerProfile?> fetchSellerProfile() async {
    return SellerProfile(
        nickname: '공예쁨',
        temperature: 100,
        itemCount: 10,
        retentionRate: 100,
        totalTransaction: 5,
        sellerId: 1,
        userId: 1,
        description: '안녕하세요. 공예쁨입니다.',
        profileImageUrl:
            'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png');
  }

  @override
  Future<SellerProfile?> fetchCreatorProfile(String nickname) async {
    return SellerProfile(
        nickname: '공예쁨',
        temperature: 100,
        itemCount: 10,
        retentionRate: 100,
        totalTransaction: 5,
        sellerId: 1,
        userId: 1,
        description: '안녕하세요. 공예쁨입니다.',
        profileImageUrl:
            'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png');
  }

  @override
  Future<void> editBuyerProfile(bool isNicknameChanged,
      bool isProfileImageChanged, String nickname, File profileImage) async {}

  @override
  Future<void> editSellerProfile(
      bool isNicknameChanged,
      bool isProfileImageChanged,
      bool isDescriptionChanged,
      String nickname,
      File profileImage,
      String description) async {}

  @override
  Future<void> inactive() async {}

  @override
  Future<dynamic> getUserInfo() async {
    return Response(
        requestOptions: RequestOptions(),
        data: {
          'nickname': '공예쁨',
          'profile_image':
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
          'is_seller': true
        },
        statusCode: 200);
  }

  @override
  Future<void> createReview(int orderId, int star, String description) async {}

  @override
  Future<dynamic> getPreSignedUrl(String extension) async {}

  @override
  Future<dynamic> createItem(FormData formData) async {
    return Response(requestOptions: RequestOptions(), statusCode: 200);
  }

  @override
  Future<dynamic> editItem(int itemId, FormData formData) async {
    return Response(requestOptions: RequestOptions(), statusCode: 200);
  }

  @override
  Future<dynamic> increaseAmount(int itemId) async {
    return Response(requestOptions: RequestOptions(), statusCode: 200);
  }

  @override
  Future<dynamic> decreaseAmount(int itemId) async {
    return Response(requestOptions: RequestOptions(), statusCode: 200);
  }

  @override
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    List<BuyerHomeItem> buyerHomeItems = [];
    for (int i = 1; i < 11; i++) {
      buyerHomeItems.add(BuyerHomeItem(
          nickname: '공예쁨 $i',
          isLiked: true,
          price: 10000,
          id: i,
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시',
          likes: 3,
          currentAmount: 1));
    }
    return buyerHomeItems;
  }

  @override
  Future<List<BuyerHomeItem>> fetchGuestHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    List<BuyerHomeItem> buyerHomeItems = [];
    for (int i = 1; i < 11; i++) {
      buyerHomeItems.add(BuyerHomeItem(
          nickname: '공예쁨 $i',
          isLiked: true,
          price: 10000,
          id: i,
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시',
          likes: 3,
          currentAmount: 1));
    }
    return buyerHomeItems;
  }

  @override
  Future<List<BuyerHomeItem>> fetchBuyerCreatorItems(
    int page, {
    String? nickname,
    isPagination = false,
  }) async {
    List<BuyerHomeItem> buyerHomeItems = [];
    for (int i = 1; i < 11; i++) {
      buyerHomeItems.add(BuyerHomeItem(
          nickname: '공예쁨 $i',
          isLiked: true,
          price: 10000,
          id: i,
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시',
          likes: 3,
          currentAmount: 1));
    }
    return buyerHomeItems;
  }

  @override
  Future<List<SellerHomeItem>> fetchSellerHomeItems(
    int page, {
    String? nickname,
    String? ordering,
    String? keyword,
    isPagination = false,
  }) async {
    List<SellerHomeItem> sellerHomeItems = [];
    for (int i = 1; i < 11; i++) {
      sellerHomeItems.add(SellerHomeItem(
        nickname: '공예쁨 $i',
        price: 10000,
        id: i,
        thumbnailImage:
            'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        title: '감성 카페 접시',
        likes: 3,
        currentAmount: 1,
        star: '4.5',
        isAuction: false,
        timeDiff: '3일 전',
      ));
    }
    return sellerHomeItems;
  }

  @override
  Future<BuyerItemDetail?> fetchBuyerItemDetail(int itemID) async {
    return BuyerItemDetail(
      title: '감성 카페 접시',
      price: 10000,
      id: 1,
      thumbnailImage:
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
      isLiked: true,
      nickname: '공예쁨',
      temperature: 50,
      height: '10',
      width: '10',
      depth: '10',
      category: [],
      profileImage:
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      shorts:
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/items/item_shorts/15389329-b6f0-4dad-8318-3c43d42b3aaa.mp4',
      images: [],
      description: '감성 카페 접시입니다.',
      currentAmount: 1,
    );
  }

  @override
  Future<SellerItemDetail?> fetchSellerItemDetail(int itemID) async {
    return SellerItemDetail(
      id: 1,
      profileImage:
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      nickname: '공예쁨 1',
      temperature: 36.5,
      title: '감성카페 그릇',
      description: '이쁘죠? 사세요 ㅋㅋ \n\n\n\n\n 10일 걸려만들었습니다.',
      price: 123456,
      category: [],
      currentAmount: 10,
      thumbnailImage:
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
      images: [
        'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg'
      ],
      shorts:
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/items/item_shorts/15389329-b6f0-4dad-8318-3c43d42b3aaa.mp4',
      width: '10',
      depth: '10',
      height: '10',
      reviews: [
        Review(
            comment: '이뻐요오오오 만족합니다!!',
            rating: '5.0',
            writer: '홍준식',
            writeDateTime: '2021-08-01'),
        Review(
            comment: '이뻐요오오오 만족합니다!!',
            rating: '5.0',
            writer: '홍준식',
            writeDateTime: '2021-08-01'),
        Review(
            comment: '이뻐요오오오 만족합니다!!',
            rating: '5.0',
            writer: '홍준식',
            writeDateTime: '2021-08-01'),
      ],
    );
  }

  @override
  Future<List<MessageItem>> fetchShareMessageItem(int page,
      {String? nickname}) async {
    List<MessageItem> messageItems = [];
    for (int i = 1; i < 11; i++) {
      messageItems.add(MessageItem(
        nickname: '공예쁨 $i',
        price: 10000,
        id: i,
        thumbnailImage:
            'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        title: '감성 카페 접시',
        currentAmount: 1,
      ));
    }
    return messageItems;
  }

  @override
  Future<List<MessageItem>> fetchOrderMessageItem(int page,
      {String? nickname}) async {
    List<MessageItem> messageItems = [];
    for (int i = 1; i < 11; i++) {
      messageItems.add(MessageItem(
        nickname: '공예쁨 $i',
        price: 10000,
        id: i,
        thumbnailImage:
            'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        title: '감성 카페 접시',
        currentAmount: 1,
      ));
    }
    return messageItems;
  }

  @override
  Future<int?> orderItem(int itemId, String name, String address, String zipCode, String addressDetail, String phoneNumber) async {
    return 1;
  }

  @override
  Future<List<ChatRoom>> fetchBuyerChatRooms() async {
    List<ChatRoom> chatRooms = [];
    for (int i = 1; i < 11; i++) {
      chatRooms.add(ChatRoom(
          chatRoomUuid: '$i',
          messageList: [
            Message(
                isRead: true,
                message: 'hi',
                messageUuid: '${i * i}',
                type: MessageType.text,
                userId: i,
                writeDatetime: DateTime.now())
          ],
          opponentNickname: '공예쁨 $i',
          opponentUserId: i,
          opponentProfileImageUrl:
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
          isRegistered: true,
          unreadMessageCount: 0));
    }
    return chatRooms;
  }

  @override
  Future<List<ChatRoom>> fetchSellerChatRooms() async {
    List<ChatRoom> chatRooms = [];
    for (int i = 1; i < 11; i++) {
      chatRooms.add(ChatRoom(
          chatRoomUuid: '$i',
          messageList: [
            Message(
                isRead: true,
                message: 'hi',
                messageUuid: '${i * i}',
                type: MessageType.text,
                userId: i,
                writeDatetime: DateTime.now())
          ],
          opponentNickname: '공예쁨 $i',
          opponentUserId: i,
          opponentProfileImageUrl:
              'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
          isRegistered: true,
          unreadMessageCount: 0));
    }
    return chatRooms;
  }

  @override
  Future<List<BuyerOrder>> fetchBuyerOrders() async {
    List<BuyerOrder> buyerOrders = [];
    for (int i = 1; i < 11; i++) {
      buyerOrders.add(BuyerOrder(
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시',
          price: 10000,
          id: i,
          isReviewed: false,
          itemId: i,
          orderedDatetime: DateTime.now(),
          orderStatus: '주문완료',
          buyerName: '홍길동 $i',
          address: '서울시 강남구 도곡동 $i길',
          addressDetail: '$i동 $i호',
          zipCode: '12345',
          phoneNumber: '01012345678',
      ));
    }
    return buyerOrders;
  }

  @override
  Future<List<SellerOrder>> fetchSellerOrders() async {
    List<SellerOrder> sellerOrders = [];
    for (int i = 1; i < 11; i++) {
      sellerOrders.add(SellerOrder(
          thumbnailImage:
              'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          title: '감성 카페 접시',
          price: 10000,
          id: i,
          isReviewed: false,
          itemId: i,
          orderedDatetime: DateTime.now(),
          orderStatus: '주문완료',
          buyerNickname: '공예쁨 $i',
          buyerName: '홍길동 $i',
          address: '서울시 강남구 도곡동 $i길',
          addressDetail: '$i동 $i호',
          zipCode: '12345',
          phoneNumber: '01012345678',
      ));
    }
    return sellerOrders;
  }

  @override
  Future<List<Message>> fetchChatRoomMessages(
      String chatRoomUuid, String? messageUuid) async {
    List<Message> messages = [];
    for (int i = 1; i < 11; i++) {
      messages.add(Message(
          isRead: true,
          message: 'hi',
          messageUuid: '${i * i}',
          type: MessageType.text,
          userId: i,
          writeDatetime: DateTime.now()));
    }
    return messages;
  }

  @override
  Future<void> readChatRoomMessages(ChatRoom chatRoom, Message message) async {}

  @override
  Future<void> deliveryStartOrder(int orderId) async {}

  @override
  Future<void> deliveryCompleteOrder(int orderId) async {}

  @override
  Future<void> cancelOrder(int orderId) async {}

  @override
  Future<OrderInfo> fetchOrder(int orderId) async {
    return OrderInfo(
      thumbnailImage:
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
      title: '감성 카페 접시',
      price: 10000,
      id: 1,
      isReviewed: false,
      itemId: 1,
      orderedDatetime: DateTime.now(),
      orderStatus: '주문완료',
      sellerNickname: '공예쁨',
    );
  }

  @override
  Future<String?> fetchDeliveryInfoUrl(int orderId) async {}

  @override
  Future<void> updateDeliveryInfo(
      int orderId, String deliveryCompany, String invoiceNumber) async {}

  @override
  Future<DeliveryInfo?> fetchDeliveryInfo(int orderId) async {}

  @override
  Future<List<Exhibition>> fetchSellerExhibitions() async {
    List<Exhibition> exhibitions = [];
    for (int i = 1; i < 11; i++) {
      exhibitions.add(Exhibition(
        id: i,
        coverImage:
            'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        title: '우유병 기획전',
        endDate: '2023-10-31',
        startDate: '2023-10-24',
        seller: '유병우 작가',
      ));
    }
    return exhibitions;
  }

  @override
  Future<ExhibitionArtist?> fetchExhibitionArtistById(int exhibitionId) async {
    return ExhibitionArtist(
      imageUrl:
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      backgroundColor: '#000000',
      description: '안녕하세요',
      fontFamily: 'NotoSansKR',
      isUsingTemplate: true,
    );
  }

  @override
  Future<List<ExhibitionItem>> fetchExhibitionItemById(int exhibitionId) async {
    List<ExhibitionItem> exhibitionItems = [];
    for (int i = 1; i < 10; i++) {
      exhibitionItems.add(ExhibitionItem(
        id: i,
        title: '우유병 기획전',
        price: 10000,
        fontFamily: 'NotoSansKR',
        description: '안녕하세요',
        backgroundColor: '#000000',
        category: [],
        imageUrls: [
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
          'https://image.idus.com/image/files/506c18aad2a94c89925b8f109b2aea83_512.jpg',
        ],
        isSale: true,
        isUsingTemplate: true,
        position: i,
        currentAmount: 5,
        depth: '10',
        height: '10',
        width: '10',
        shorts:
            'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/items/item_shorts/15389329-b6f0-4dad-8318-3c43d42b3aaa.mp4',
      ));
    }
    return exhibitionItems;
  }

  @override
  Future<Exhibition?> saveExhibitionIntroductionById(int exhibitionId) async {
    return null;
  }

  @override
  Future<void> saveExhibitionArtistById(int exhibitionId) async {
    return;
  }

  @override
  Future<void> saveExhibitionItemById(int exhibitionId) async {
    return;
  }
}
