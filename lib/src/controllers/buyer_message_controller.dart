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

  Future<void> sendMessage(chatRoomId, message) async {
    int opponentUserId = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId)
        .opponentUserId;
    ChatRoom chatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    UserGlobalInfoController userGlobalInfoController =
        Get.find<UserGlobalInfoController>();
    Message messageInfo = Message(
      messageId: Uuid().v4(),
      userId: userGlobalInfoController.userId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
    );
    chatRoom.tempMessageList.add(messageInfo);
    ChattingSocketSingleton().sendMessage(
        chatRoomId, opponentUserId, messageInfo.message, messageInfo.messageId);
  }

  registerMessage(chatRoomId, messageTempId, messageId) {
    ChatRoom sendChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    Message tempMessage = sendChatRoom.tempMessageList
        .firstWhere((message) => message.messageId == messageTempId);
    sendChatRoom.tempMessageList.remove(tempMessage);
    tempMessage.messageId = messageId.toString();
    sendChatRoom.messageList.add(tempMessage);
    chatRoomList.remove(sendChatRoom);
    chatRoomList.insert(0, sendChatRoom);
    chatRoomList.refresh();
  }

  receiveMessage(chatRoomId, messageId, message) {
    ChatRoom receiveChatRoom = chatRoomList
        .firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    receiveChatRoom.messageList.add(Message(
      messageId: messageId.toString(),
      userId: receiveChatRoom.opponentUserId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
    ));
    chatRoomList.remove(receiveChatRoom);
    chatRoomList.insert(0, receiveChatRoom);
    chatRoomList.refresh();
  }

  getChatRoom(chatRoomId) {
    for (final chatRoom in chatRoomList.value) {
      if (chatRoom.chatRoomId == chatRoomId) {
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
