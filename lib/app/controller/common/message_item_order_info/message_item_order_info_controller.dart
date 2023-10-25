import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/message.dart';
import '../../../data/repositories/message_item_repository.dart';
import '../message/message_controller.dart';

class MessageItemOrderInfoController extends GetxController {
  final MessageItemRepository repository;

  MessageItemOrderInfoController({required this.repository}) : assert(repository != null);

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
  Rx<String> address = Rx<String>('');
  Rx<String> zipCode = Rx<String>('');
  Rx<bool> isAddressLoaded = false.obs;

  String get chatRoomUuid => Get.arguments['chatRoomUuid'];
  int get itemId => Get.arguments['itemId'];
  bool get isFilled {
    return name.text.isNotEmpty
        && phoneNumber.text.isNotEmpty && phoneNumber.text.length >= 9
        && isAddressLoaded.value
        && addressDetail.text.isNotEmpty;
  }

  Future<void> order() async {
    int? orderId = await repository.orderItem(
      itemId,
      name.text,
      address.value,
      addressDetail.text,
      zipCode.value,
      phoneNumber.text,
    );
    if (orderId == null) {
      Get.snackbar('주문 실패', '주문에 실패했습니다.');
      Get.back();
      return;
    }
    MessageController messageController = Get.find<MessageController>();
    if (messageController.chatRoom.isRegistered) {
      await Get.find<MessageController>().sendMessage(
        chatRoomUuid,
        orderId.toString(),
        MessageType.order,
      );
    } else {
      Get.find<MessageController>().createChatRoom(
        chatRoomUuid,
        Get.find<MessageController>().chatRoom.opponentNickname,
        orderId.toString(),
        MessageType.order,
      );
    }
  }
}
