import 'package:get/get.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../repositories/message_repository.dart';
import '../utils/chatting_socket_singleton.dart';

class BuyerMessageController extends GetxController {
  final MessageRepository _messageRepository = MessageRepository();

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
    chatRoomList.addAll(fetchedBuyerChatRoomList);
    chatRoomList.addAll(fetchedSellerChatRoomList);
    isLoading.value = false;
  }

  Future<void> sendMessage(chatRoomUuid, message) async {
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
    );
    chatRoom.tempMessageList.add(messageInfo);
    ChattingSocketSingleton().sendMessage(
        chatRoomUuid, opponentUserId, messageInfo.message, messageInfo.messageUuid);
  }

  registerMessage(chatRoomUuid, messageTempId, messageUuid) {
    ChatRoom sendChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid);
    Message tempMessage = sendChatRoom.tempMessageList
        .firstWhere((message) => message.messageUuid == messageTempId);
    sendChatRoom.tempMessageList.remove(tempMessage);
    tempMessage.messageUuid = messageUuid.toString();
    sendChatRoom.messageList.add(tempMessage);
    chatRoomList.remove(sendChatRoom);
    chatRoomList.insert(0, sendChatRoom);
    chatRoomList.refresh();
  }

  receiveMessage(chatRoomUuid, messageUuid, message) {
    ChatRoom receiveChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomUuid == chatRoomUuid);
    receiveChatRoom.messageList.add(Message(
      messageUuid: messageUuid,
      userId: receiveChatRoom.opponentUserId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
    ));
    chatRoomList.remove(receiveChatRoom);
    chatRoomList.insert(0, receiveChatRoom);
    chatRoomList.refresh();
  }

  getChatRoom(chatRoomUuid) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.chatRoomUuid == chatRoomUuid) {
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
}
