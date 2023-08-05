import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/message_item_repository.dart';

class MessageItemOrderController extends GetxController {
  final MessageItemRepository _messageItemRepository = MessageItemRepository();

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
            await _messageItemRepository.fetchOrderMessageItem(currentPage,
                nickname: Get.find<BuyerMessageController>()
                    .getChatRoom(Get.arguments['chatRoomUuid'])
                    .opponentNickname);

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
    try {
      await _messageItemRepository.orderItem(selectItemId.value);
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}
