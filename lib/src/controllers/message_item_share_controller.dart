import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/message_item_repository.dart';

class MessageItemShareController extends GetxController {
  final MessageItemRepository _messageItemRepository = MessageItemRepository();

  List<MessageItem> items = <MessageItem>[];
  RxList<MessageItem> displayItems = <MessageItem>[].obs;
  Rx<int> selectItemId = 0.obs;
  Rx<bool> isSelect = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      List<MessageItem> fetchedMessageItems =
          await _messageItemRepository.fetchShareMessageItem();

      items.assignAll(fetchedMessageItems);
      displayItems.assignAll(fetchedMessageItems);
    } catch (e) {
      print(e);
    }
  }

  //items에서 title안에 keyword가 포함된 item들만 반환해서 displayItems에 넣어주기
  void search(String keyword) {
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
}
