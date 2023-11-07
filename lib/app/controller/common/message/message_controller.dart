import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/app/data/repositories/item_detail_repository.dart';
import 'package:leporemart/app/data/repositories/order_list_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/item_detail.dart';
import '../../../data/models/message.dart';
import '../../../data/models/order.dart';
import '../../../data/models/profile.dart';
import '../../../data/repositories/message_repository.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../utils/chatting_socket_singleton.dart';
import '../../../utils/log_analytics.dart';
import '../user_global_info/user_global_info_controller.dart';

class MessageController extends GetxService {
  final scrollController = ScrollController().obs;
  final MessageRepository messageRepository;
  final ItemDetailRepository itemDetailRepository;
  final OrderListRepository orderListRepository;
  final ProfileRepository profileRepository;
  MessageController(
      {required this.messageRepository,
      required this.itemDetailRepository,
      required this.orderListRepository,
      required this.profileRepository})
      : assert(messageRepository != null &&
            itemDetailRepository != null &&
            orderListRepository != null &&
            profileRepository != null);

  RxList<ChatRoom> chatRoomList = <ChatRoom>[].obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isPlusButtonClicked = false.obs;
  Rx<bool> isLoadingScroll = false.obs;
  RxList<File> imageFile = RxList<File>([]);

  Future<MessageController> init() async {
    await fetch();
    return this;
  }

  @override
  void onInit() {
    _chatRoomMessagesScroll();
    super.onInit();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    List<ChatRoom> fetchedBuyerChatRoomList =
        await messageRepository.fetchBuyerChatRooms();
    List<ChatRoom> fetchedSellerChatRoomList = [];
    if (Get.find<UserGlobalInfoController>().isSeller) {
      fetchedSellerChatRoomList
          .addAll(await messageRepository.fetchSellerChatRooms());
    }

    chatRoomList.clear();
    chatRoomList.addAll(fetchedBuyerChatRoomList);
    chatRoomList.addAll(fetchedSellerChatRoomList);
    isLoading.value = false;
  }

  Future<void> sendMessage(
      String chatRoomUuid, String message, MessageType messageType) async {
    int opponentUserId = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid)
        .opponentUserId;
    ChatRoom chatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid);
    UserGlobalInfoController userGlobalInfoController =
        Get.find<UserGlobalInfoController>();
    Message messageInfo = Message(
      messageUuid: Uuid().v4(),
      userId: userGlobalInfoController.userId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
      type: messageType,
    );
    await fetchItemInfo(messageInfo);
    chatRoom.tempMessageList.add(messageInfo);
    if (chatRoom.isRegistered) {
      ChattingSocketSingleton().sendMessage(
        chatRoomUuid,
        opponentUserId,
        messageInfo.message,
        messageInfo.messageUuid,
        messageInfo.type,
      );
    }
    chatRoomList.refresh();
  }

  Future<void> selectImage({bool isGallery = true}) async {
    XFile? pickedFile;
    pickedFile = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile == null) return;

    // 압축한 이미지를 저장할 공간
    // 이미지를 압축하고 압축한 이미지를 compressedImage에 추가
    // 이미지 크기를 계산하기위해 변수생성
    int totalImageSize = 0;
    final compressedImage = await compressImage(pickedFile!);

    if (compressedImage == null) return;

    final compressedFile = File('${pickedFile.path}.compressed.jpg')
      ..writeAsBytesSync(compressedImage);
    totalImageSize = compressedFile.lengthSync();
    if (isFileLargerThanMB(totalImageSize, 10)) return;
    imageFile.assignAll([compressedFile]);
    final response = await messageRepository.getMessageImagePresignedUrl(imageFile.first.path.split('.').last);

    final String presignedUrl = response.data['url'];
    Map<String, dynamic> payload = response.data['fields'];
    final imageUrl = payload['key'];
    payload.addAll({
      'file': await MultipartFile.fromFile(
        imageFile.first.path,
        filename: imageFile.first.path.split('/').last,
      ),
    });

    final uploadResponse = await Dio().post(
      presignedUrl,
      data: FormData.fromMap(payload),
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (uploadResponse.statusCode != 204) return;

    if (chatRoom.isRegistered) {
      sendMessage(
        Get.arguments['chatRoomUuid'],
        '$presignedUrl$imageUrl',
        MessageType.image,
      );
    } else {
      createChatRoom(
        Get.arguments['chatRoomUuid'],
        chatRoom.opponentNickname,
        '$presignedUrl$imageUrl',
        MessageType.image
      );
    }
  }

  bool isFileLargerThanMB(int totalSize, int size) {
    if (totalSize > size * 1024 * 1024) {
      logAnalytics(name: 'size_too_big');
      Get.snackbar(
        '경고',
        '파일 크기가 너무 큽니다. 다시 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    }
    return false;
  }

  Future<Uint8List?> compressImage(XFile imageFile) async {
    final File file = File(imageFile.path);
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 30, // 이미지 품질 설정 (0 ~ 100, 기본값은 80)
    );
    return result;
  }

  sendTempMessage(String chatRoomUuid) {
    ChatRoom currentChatRoom = getChatRoom(chatRoomUuid);
    for (final messageInfo in currentChatRoom.tempMessageList) {
      ChattingSocketSingleton().sendMessage(
        chatRoomUuid,
        currentChatRoom.opponentUserId,
        messageInfo.message,
        messageInfo.messageUuid,
        messageInfo.type,
      );
    }
  }

  registerMessage(chatRoomUuid, messageUuid) {
    ChatRoom sendChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid);
    Message tempMessage = sendChatRoom.tempMessageList
        .firstWhere((message) => message.messageUuid == messageUuid);
    sendChatRoom.tempMessageList.remove(tempMessage);
    tempMessage.messageUuid = messageUuid.toString();
    sendChatRoom.messageList.add(tempMessage);
    chatRoomList.remove(sendChatRoom);
    chatRoomList.insert(0, sendChatRoom);
    chatRoomList.refresh();
  }

  receiveMessage(chatRoomUuid, messageUuid, message, messageType) {
    ChatRoom receiveChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid);
    if (receiveChatRoom.opponentUserId ==
        Get.find<UserGlobalInfoController>().userId) {
      return;
    }
    Message receiveMessage = Message(
      messageUuid: messageUuid,
      userId: receiveChatRoom.opponentUserId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
      type: messageType,
    );
    fetchItemInfo(receiveMessage);
    receiveChatRoom.messageList.add(receiveMessage);
    receiveChatRoom.unreadMessageCount += 1;
    chatRoomList.remove(receiveChatRoom);
    chatRoomList.insert(0, receiveChatRoom);
    chatRoomList.refresh();
  }

  createTempChatRoom(sellerNickname) async {
    SellerProfile? sellerProfile =
        await profileRepository.fetchCreatorProfile(sellerNickname);
    if (sellerProfile == null) {
      //TODO: 에러처리
      return;
    }

    String chatRoomUuid = Uuid().v4();

    ChatRoom newChatRoom = ChatRoom(
      chatRoomUuid: chatRoomUuid,
      opponentUserId: sellerProfile.userId,
      opponentNickname: sellerProfile.nickname,
      opponentProfileImageUrl: sellerProfile.profileImage,
      messageList: [],
      isRegistered: false,
    );
    newChatRoom.isBuyerRoom = true;
    chatRoomList.insert(0, newChatRoom);
    chatRoomList.refresh();
    return newChatRoom;
  }

  createChatRoom(
    String chatRoomUuid,
    String sellerNickname,
    String message,
    MessageType messageType,
  ) async {
    SellerProfile? sellerProfile =
        await profileRepository.fetchCreatorProfile(sellerNickname);
    if (sellerProfile == null) {
      //TODO: 에러처리
      return;
    }
    UserGlobalInfoController userGlobalInfoController =
        Get.find<UserGlobalInfoController>();
    ChatRoom chatRoom = getChatRoom(chatRoomUuid);
    String messageUuid = Uuid().v4();
    Message messageInfo = Message(
      messageUuid: messageUuid,
      userId: userGlobalInfoController.userId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
      type: messageType,
    );
    chatRoom.messageList.add(messageInfo);
    chatRoomList.remove(chatRoom);
    chatRoomList.insert(0, chatRoom);
    chatRoomList.refresh();
    await fetchItemInfo(messageInfo);
    ChattingSocketSingleton().createChatRoom(
      chatRoomUuid,
      sellerProfile.sellerId,
      message,
      messageUuid,
      sellerProfile.userId,
      messageType,
    );
  }

  fetchChatRoomMessages(String chatRoomUuid) async {
    ChatRoom chatRoom = getChatRoom(chatRoomUuid);
    if (!chatRoom.hasMoreMessage) {
      return;
    }
    isLoadingScroll.value = true;
    final messageUuid = chatRoom.messageList.first.messageUuid;
    List<Message> fetchMessageList = await messageRepository
        .fetchChatRoomMessages(chatRoomUuid, messageUuid);
    if (fetchMessageList.isEmpty) {
      chatRoom.hasMoreMessage = false;
    }
    fetchMessageList.addAll(chatRoom.messageList);
    chatRoom.messageList = fetchMessageList;
    chatRoomList.refresh();
    isLoadingScroll.value = false;
  }

  _chatRoomMessagesScroll() async {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        fetchChatRoomMessages(Get.arguments['chatRoomUuid']);
      }
    });
  }

  getChatRoom(chatRoomUuid) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.chatRoomUuid == chatRoomUuid) {
        return chatRoom;
      }
    }
  }

  getChatRoomByOpponentNicknameFromBuyer(nickname) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.opponentNickname == nickname && chatRoom.isBuyerRoom) {
        return chatRoom;
      }
    }
  }

  getBuyerChatRooms() {
    return chatRoomList.where((chatRoom) => chatRoom.isBuyerRoom);
  }

  getSellerChatRooms() {
    return chatRoomList.where((chatRoom) => !chatRoom.isBuyerRoom);
  }

  fetchItemInfo(Message message) async {
    switch (message.type) {
      case MessageType.itemInquiry:
        BuyerItemDetail? itemDetail = await itemDetailRepository
            .fetchBuyerItemDetail(int.parse(message.message));
        if (itemDetail == null) {
          //TODO: 에러처리
          return;
        }
        message.itemInfo = ItemInfo(
          itemId: itemDetail.id,
          thumbnailImage: itemDetail.thumbnailImage,
          sellerNickname: itemDetail.nickname,
          title: itemDetail.title,
          price: itemDetail.price,
        );
        break;
      case MessageType.itemShare:
        BuyerItemDetail? itemDetail = await itemDetailRepository
            .fetchBuyerItemDetail(int.parse(message.message));
        if (itemDetail == null) {
          //TODO: 에러처리
          return;
        }
        message.itemInfo = ItemInfo(
          itemId: itemDetail.id,
          thumbnailImage: itemDetail.thumbnailImage,
          sellerNickname: itemDetail.nickname,
          title: itemDetail.title,
          price: itemDetail.price,
        );
        break;
      case MessageType.order:
        OrderInfo orderInfo =
            await orderListRepository.fetchOrder(int.parse(message.message));
        message.itemInfo = ItemInfo(
            itemId: orderInfo.itemId,
            thumbnailImage: orderInfo.thumbnailImage,
            sellerNickname: orderInfo.sellerNickname,
            title: orderInfo.title,
            price: orderInfo.price);
        break;
      default:
        break;
    }
    chatRoomList.refresh();
  }

  isDifferentUserIndex(int index) {
    if (index == reversedMessageList.length - 1) {
      return true;
    }
    if (reversedMessageList[index].userId !=
        reversedMessageList[index + 1].userId) {
      return true;
    }
    return false;
  }

  readAllMessages(String chatRoomUuid) async {
    ChatRoom chatRoom = getChatRoom(chatRoomUuid);
    Message lastMessage = chatRoom.messageList.last;
    await messageRepository.readChatRoomMessages(chatRoom, lastMessage);
    chatRoom.unreadMessageCount = 0;
    for (final message in chatRoom.messageList) {
      message.isRead = true;
    }
    chatRoomList.refresh();
  }

  ChatRoom get chatRoom => getChatRoom(Get.arguments['chatRoomUuid']);

  List<Message> get reversedMessageList =>
      chatRoom.messageList.reversed.toList();

  bool get isBuyerMessageUnread {
    for (final chatRoom in chatRoomList) {
      if (chatRoom.isBuyerRoom && chatRoom.unreadMessageCount > 0) {
        return true;
      }
    }
    return false;
  }

  bool get isSellerMessageUnread {
    for (final chatRoom in chatRoomList) {
      if (!chatRoom.isBuyerRoom && chatRoom.unreadMessageCount > 0) {
        return true;
      }
    }
    return false;
  }
}
