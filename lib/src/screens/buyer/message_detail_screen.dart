import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

import '../../controllers/user_global_info_controller.dart';
import '../../models/message.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_bottom_navigationbar.dart';

class MessageDetailScreen extends GetView<BuyerMessageController> {
  MessageDetailScreen({super.key});
  int _currentUserId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.backAppBar, onTapLeadingIcon: () => Get.back()),
      body: SafeArea(
          child: Obx(() {return _messageListWidget();})
      ),
      bottomNavigationBar: _messageBottomWidget(),
    );
  }

  _messageListWidget() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      children: [
        for (final message in controller.getChatRoom(Get.arguments['chatRoomId']).messageList)
          _messageWidget(message)
      ],
    );
  }

  _messageWidget(Message message) {
    Column widget = Column(
      children: [
        if (message.userId != _currentUserId) SizedBox(height: 8),
        _innerMessageWidget(message),
        SizedBox(height: 8),
      ],
    );
    _currentUserId = message.userId;
    return widget;
  }

  _innerMessageWidget(Message message) {
    ChatRoom currentChatRoom = controller.getChatRoom(Get.arguments['chatRoomId']);
    return currentChatRoom.opponentUserId != message.userId
        ? _myMessageWidget(message)
        : _opponentMessageWidget(message);
  }

  _myMessageWidget(Message message) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.grey_2,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.7,
            ),
            child: Text(
              message.message,
              style: TextStyle(
                fontFamily: FontPalette.pretenderd,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _opponentMessageWidget(Message message) {
    ChatRoom currentChatRoom = controller.getChatRoom(Get.arguments['chatRoomId']);
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (_currentUserId != message.userId) CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(currentChatRoom.opponentProfileImageUrl),
          ),
          if (_currentUserId == message.userId) SizedBox(width: 32),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: ColorPalette.white,
              border: Border.all(
                color: ColorPalette.grey_3,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * 0.6,
                ),
                child: Text(
                  message.message,
                  style: TextStyle(
                    fontFamily: FontPalette.pretenderd,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _messageBottomWidget() {
    return Container(
      height: 54,
      color: ColorPalette.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/icons/chatting_plus.png'),
              width: 24,
              height: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.grey_2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Text(
                    '메시지를 입력하세요',
                    style: TextStyle(
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 16,
                      color: ColorPalette.grey_4,
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
