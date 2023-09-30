import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/message_item_repository.dart';

import '../../../data/models/item.dart';
import '../../../data/models/message.dart';
import '../message/message_controller.dart';

class MessageItemOrderController extends GetxController {
  final MessageItemRepository repository;
  MessageItemOrderController({required this.repository})
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
        List<MessageItem> fetchedMessageItems =
            await repository.fetchOrderMessageItem(currentPage,
                nickname:
                    Get.find<MessageController>().chatRoom.opponentNickname);
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

  Future<void> order() async {
    int? orderId = await repository.orderItem(selectItemId.value);
    if (orderId == null) {
      //TODO: 주문 실패
      return;
    }
    MessageController messageController = Get.find<MessageController>();
    if (messageController.chatRoom.isRegistered) {
      await Get.find<MessageController>().sendMessage(
        Get.arguments['chatRoomUuid'],
        orderId.toString(),
        MessageType.order,
      );
    } else {
      Get.find<MessageController>().createChatRoom(
        Get.arguments['chatRoomUuid'],
        Get.find<MessageController>().chatRoom.opponentNickname,
        orderId.toString(),
        MessageType.order,
      );
    }
  }
}
