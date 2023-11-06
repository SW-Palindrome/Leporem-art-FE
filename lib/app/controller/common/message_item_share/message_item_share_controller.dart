import 'package:get/get.dart';

import '../../../data/models/item.dart';
import '../../../data/models/message.dart';
import '../../../data/repositories/message_item_repository.dart';
import '../message/message_controller.dart';
import '../user_global_info/user_global_info_controller.dart';

class MessageItemShareController extends GetxController {
  final MessageItemRepository repository;
  MessageItemShareController({required this.repository})
      : assert(repository != null);

  List<MessageItem> items = <MessageItem>[];
  RxList<MessageItem> displayItems = <MessageItem>[].obs;
  Rx<int> selectItemId = 0.obs;
  Rx<bool> isSelect = false.obs;

  // 검색을 위한 텍스트 저장
  String keyword = '';

  // 페이지네이션을 위한 페이지변수와 스크롤 컨트롤러
  int currentPage = 1;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      while (true) {
        List<MessageItem> fetchedMessageItems = await repository
            .fetchShareMessageItem(currentPage, nickname: sellerNickname);
        if (fetchedMessageItems.isEmpty) break;
        items.addAll(fetchedMessageItems);
        displayItems.addAll(fetchedMessageItems);
        currentPage++;
      }
    } catch (e) {
      print(e);
    }
  }

  //items에서 title안에 keyword가 포함된 item들만 반환해서 displayItems에 넣어주기
  void search() {
    if (keyword.isEmpty) {
      displayItems.assignAll(items);
      return;
    }
    displayItems.assignAll(
        items.where((item) => item.title.contains(keyword)).toList());
  }

  void select(int itemId) {
    if (selectItemId.value == itemId) {
      isSelect.value = !isSelect.value;
    } else {
      selectItemId.value = itemId;
      isSelect.value = true;
    }
  }

  bool isSelected(int itemId) {
    return selectItemId.value == itemId && isSelect.value;
  }

  String get sellerNickname {
    ChatRoom chatRoom = Get.find<MessageController>().chatRoom;
    return chatRoom.isBuyerRoom
        ? chatRoom.opponentNickname
        : Get.find<UserGlobalInfoController>().nickname;
  }

  void sendMessage() {
    MessageController messageController = Get.find<MessageController>();
    if (messageController.chatRoom.isRegistered) {
      Get.find<MessageController>().sendMessage(
        Get.arguments['chatRoomUuid'],
        selectItemId.value.toString(),
        MessageType.itemShare,
      );
    } else {
      Get.find<MessageController>().createChatRoom(
        Get.arguments['chatRoomUuid'],
        sellerNickname,
        selectItemId.value.toString(),
        MessageType.itemShare,
      );
    }
  }
}
