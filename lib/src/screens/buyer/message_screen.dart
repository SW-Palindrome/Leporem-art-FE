import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class MessageScreen extends GetView<BuyerMessageController> {
  MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if (controller.chatRoomList.isEmpty) {
          return _emptyItemListWidget();
        }
        return _chatRoomListWidget();
      }
    );
  }

  _emptyItemListWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text(
            '아직 채팅 내역이 없어요.',
            style: TextStyle(
              fontSize: 16,
              color: ColorPalette.grey_5,
              fontFamily: "PretendardVariable",
            )
          ),
        ],
      ),
    );
  }

  _chatRoomListWidget() {
    return TextField('무엇이지');
  }
}
