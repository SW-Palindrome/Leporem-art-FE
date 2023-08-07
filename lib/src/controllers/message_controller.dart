import 'package:get/get.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:uuid/uuid.dart';

import '../models/item_detail.dart';
import '../models/message.dart';
import '../models/profile.dart';
import '../repositories/item_detail_repository.dart';
import '../repositories/message_repository.dart';
import '../repositories/profile_repository.dart';
import '../utils/chatting_socket_singleton.dart';

class MessageController extends GetxController {
  final MessageRepository _messageRepository = MessageRepository();
  final ItemDetailRepository _itemDetailRepository = ItemDetailRepository();

  RxList<ChatRoom> chatRoomList = <ChatRoom>[].obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isPlusButtonClicked = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    List<ChatRoom> fetchedBuyerChatRoomList =
        await _messageRepository.fetchBuyerChatRooms();
    List<ChatRoom> fetchedSellerChatRoomList =
      await _messageRepository.fetchSellerChatRooms();
    chatRoomList.clear();
    chatRoomList.addAll(fetchedBuyerChatRoomList);
    chatRoomList.addAll(fetchedSellerChatRoomList);
    await fetchItemInfoList();
    isLoading.value = false;
  }

  Future<void> sendMessage(
    String chatRoomUuid,
    String message,
    MessageType messageType
  ) async {
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
    chatRoom.tempMessageList.add(messageInfo);
    ChattingSocketSingleton().sendMessage(
      chatRoomUuid,
      opponentUserId,
      messageInfo.message,
      messageInfo.messageUuid,
      messageType,
    );
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
    receiveChatRoom.messageList.add(Message(
      messageUuid: messageUuid,
      userId: receiveChatRoom.opponentUserId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
      type: messageType,
    ));
    chatRoomList.remove(receiveChatRoom);
    chatRoomList.insert(0, receiveChatRoom);
    chatRoomList.refresh();
  }

  createTempChatRoom(sellerNickname) async {
    final ProfileRepository profileRepository = ProfileRepository();
    SellerProfile sellerProfile = await profileRepository.fetchCreatorProfile(sellerNickname);

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
    final ProfileRepository profileRepository = ProfileRepository();
    SellerProfile sellerProfile = await profileRepository.fetchCreatorProfile(sellerNickname);
    UserGlobalInfoController userGlobalInfoController = Get.find<UserGlobalInfoController>();
    ChatRoom chatRoom = getChatRoom(chatRoomUuid);
    String messageUuid = Uuid().v4();
    chatRoom.messageList.add(Message(
      messageUuid: messageUuid,
      userId: userGlobalInfoController.userId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
      type: messageType,
    ));
    chatRoom.isRegistered = true;
    chatRoomList.remove(chatRoom);
    chatRoomList.insert(0, chatRoom);
    chatRoomList.refresh();
    ChattingSocketSingleton().createChatRoom(
      chatRoomUuid,
      sellerProfile.sellerId,
      message,
      messageUuid,
      sellerProfile.userId,
      messageType,
    );
  }

  getChatRoom(chatRoomUuid) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.chatRoomUuid == chatRoomUuid) {
        return chatRoom;
      }
    }
  }

  getChatRoomByOpponentNickname(nickname) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.opponentNickname == nickname) {
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
        ItemDetail itemDetail = await _itemDetailRepository.fetchItemDetail(
            int.parse(message.message));
        message.itemInfo = ItemInfo(
          itemId: itemDetail.id,
          thumbnailImage: itemDetail.thumbnailImage,
          sellerNickname: itemDetail.nickname,
          title: itemDetail.title,
          price: itemDetail.price,
        );
        break;
      case MessageType.itemShare:
        ItemDetail itemDetail = await _itemDetailRepository.fetchItemDetail(
            int.parse(message.message));
        message.itemInfo = ItemInfo(
          itemId: itemDetail.id,
          thumbnailImage: itemDetail.thumbnailImage,
          sellerNickname: itemDetail.nickname,
          title: itemDetail.title,
          price: itemDetail.price,
        );
        break;
      default:
        break;
    }
  }

  fetchItemInfoList() async {
    for (final chatRoom in chatRoomList) {
      for (final message in chatRoom.messageList) {
        await fetchItemInfo(message);
      }
    }
  }

  getItemInfo(itemId) {
    ChatRoom chatRoom = getChatRoom(Get.arguments['chatRoomUuid']);
    for (final message in chatRoom.messageList) {
      if ((message.itemInfo != null) && message.itemInfo!.itemId == itemId) {
        return message.itemInfo;
      }
    }
  }
}
