import 'package:get/get.dart';

import '../models/message.dart';
import '../repositories/message_repository.dart';

class BuyerMessageController extends GetxController {
  final MessageRepository _messageRepository = MessageRepository();
  RxList<ChatRoom> chatRoomList = <ChatRoom>[].obs;
  int currentPage = 1;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    List<ChatRoom> fetchedChatRoomList = await _messageRepository.fetchChatRooms(currentPage);
    chatRoomList.addAll(fetchedChatRoomList);
    currentPage++;
  }
}
