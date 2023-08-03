import 'package:get/get.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../repositories/message_repository.dart';
import '../utils/chatting_socket_singleton.dart';

class BuyerMessageController extends GetxController {
  final MessageRepository _messageRepository = MessageRepository();
  RxList<ChatRoom> chatRoomList = <ChatRoom>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    List<ChatRoom> fetchedChatRoomList = await _messageRepository.fetchChatRooms();
    chatRoomList.addAll(fetchedChatRoomList);
  }

  Future<void> sendMessage(chatRoomId, message) async {
    int opponentUserId = chatRoomList.firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId).opponentUserId;
    ChatRoom chatRoom = chatRoomList.firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    UserGlobalInfoController userGlobalInfoController = Get.find<UserGlobalInfoController>();
    chatRoom.tempMessageList.add(Message(
      messageId: Uuid().v4(),
      userId: userGlobalInfoController.userId,
      writeDatetime: DateTime.now(),
      isRead: false,
      message: message,
    ));
    ChattingSocketSingleton().sendMessage(chatRoomId, opponentUserId, message);
  }

  registerMessage(chatRoomId, messageTempId, messageId) {
    ChatRoom sendChatRoom = chatRoomList.firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    Message tempMessage = sendChatRoom.tempMessageList.firstWhere((message) => message.messageId == messageTempId);
    sendChatRoom.tempMessageList.remove(tempMessage);
    tempMessage.messageId = messageId.toString();
    sendChatRoom.messageList.add(tempMessage);
  }

  receiveMessage(chatRoomId, messageId, message) {
    ChatRoom receiveChatRoom = chatRoomList.firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId);
    receiveChatRoom.messageList.add(Message(
        messageId: messageId,
        userId: receiveChatRoom.opponentUserId,
        writeDatetime: DateTime.now(),
        isRead: false,
        message: message,
    ));
  }

  getChatRoomMessageList(chatRoomId) {
    return chatRoomList.firstWhere((chatRoom) => chatRoom.chatRoomId == chatRoomId).messageList;
  }
}
