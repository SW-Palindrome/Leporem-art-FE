import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/message.dart';
import '../../../data/repositories/message_item_repository.dart';
import '../message/message_controller.dart';

class MessageItemOrderInfoController extends GetxController {
  final MessageItemRepository repository;

  MessageItemOrderInfoController({required this.repository}) : assert(repository != null);

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  String get chatRoomUuid => Get.arguments['chatRoomUuid'];
  int get itemId => Get.arguments['itemId'];
  bool get isFilled {
    return name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty && phoneNumber.text.length == 11;
  }

  Future<void> order() async {
    int? orderId = await repository.orderItem(itemId);
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
