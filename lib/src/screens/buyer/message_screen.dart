import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

import '../../models/message.dart';

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
    return Container(
      child: Column(
        children: [
          for (final chatRoom in controller.chatRoomList)
            _chatRoomWidget(chatRoom)
        ],
      ),
    );
  }

  _chatRoomWidget(ChatRoom chatRoom) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorPalette.white,
      ),
      height: 72,
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 12),
          ClipRRect(
              borderRadius: BorderRadius.circular(Get.width * 0.1),
              child: Image.network(
                chatRoom.profileImageUrl,
                width: 48,
                height: 48,
              ),
          ),
          Container(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    chatRoom.nickname,
                    style: TextStyle(fontSize: 12, fontFamily: "PretendardVariable", fontWeight: FontWeight.w700)
                  ),
                  SizedBox(width: 6),
                  Text(
                    DateFormat('aa hh:mm', 'ko').format(chatRoom.lastChatDatetime),
                    style: TextStyle(fontSize: 11, fontFamily: "PretendardVariable", color: ColorPalette.grey_4)
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                chatRoom.lastChatMessage,
                style: TextStyle(fontSize: 12, fontFamily: "PretendardVariable", color: ColorPalette.grey_6)
              ),
            ],
          )
        ]
      ),
    );
  }
}
