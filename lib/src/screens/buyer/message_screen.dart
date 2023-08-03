import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/controllers/message_item_share_controller.dart';
import 'package:leporemart/src/screens/buyer/message_item_share_screen.dart';
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
    });
  }

  _emptyItemListWidget() {
    return GestureDetector(
        onTap: () {
          Get.to(MessageItemShareScreen());
          Get.put(MessageItemShareController());
        },
        child: Text('작폼공유'));
    // return Center(
    //   child: Column(
    //     children: [
    //       SizedBox(height: 144),
    //       Image.asset(
    //         'assets/images/rabbit.png',
    //         height: 200,
    //       ),
    //       SizedBox(height: 24),
    //       Text(
    //         '아직 채팅 내역이 없어요.',
    //         style: TextStyle(
    //           fontSize: 16,
    //           color: ColorPalette.grey_5,
    //           fontFamily: FontPalette.pretenderd,
    //         )
    //       ),
    //     ],
    //   ),
    // );
  }

  _chatRoomListWidget() {
    return Column(
      children: [
        for (final chatRoom in controller.chatRoomList)
          _chatRoomWidget(chatRoom)
      ],
    );
  }

  _chatRoomWidget(ChatRoom chatRoom) {
    return Container(
      color: ColorPalette.white,
      height: 72,
      margin: EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.36, // Slide 된 위젯 사이즈
            motion: ScrollMotion(),
            children: [
              _turnOffAlarmWidget(),
              _leaveChatRoomWidget(),
            ],
          ),
          child: _chatRoomInfoWidget(chatRoom),
        ),
      ),
    );
  }

  _chatRoomInfoWidget(ChatRoom chatRoom) {
    return Row(children: [
      SizedBox(width: 12),
      _profileImageWidget(chatRoom),
      SizedBox(width: 8),
      _profileDetailInfoWidget(chatRoom),
    ]);
  }

  _profileImageWidget(ChatRoom chatRoom) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Get.width * 0.1),
      child: Image.network(
        chatRoom.opponentProfileImageUrl,
        width: 48,
        height: 48,
      ),
    );
  }

  _turnOffAlarmWidget() {
    return CustomSlidableAction(
      onPressed: (BuildContext context) {},
      backgroundColor: ColorPalette.grey_3,
      child: Text('알림끄기',
          style: TextStyle(
            fontSize: 11,
            fontFamily: FontPalette.pretenderd,
          )),
    );
  }

  _profileDetailInfoWidget(ChatRoom chatRoom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(chatRoom.opponentNickname,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: FontPalette.pretenderd,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 6),
            Text(
                DateFormat('aa hh:mm', 'ko')
                    .format(chatRoom.lastMessageDatetime),
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: FontPalette.pretenderd,
                    color: ColorPalette.grey_4)),
          ],
        ),
        SizedBox(height: 8),
        Text(chatRoom.lastMessage,
            style: TextStyle(
                fontSize: 12,
                fontFamily: FontPalette.pretenderd,
                color: ColorPalette.grey_6)),
      ],
    );
  }

  _leaveChatRoomWidget() {
    return CustomSlidableAction(
      onPressed: (BuildContext context) {},
      backgroundColor: ColorPalette.red,
      child: Text('나가기',
          style: TextStyle(
            fontSize: 11,
            fontFamily: FontPalette.pretenderd,
          )),
    );
  }
}
