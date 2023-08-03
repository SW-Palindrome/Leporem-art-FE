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
      appBar: MyAppBar(appBarType: AppBarType.backAppBar),
      body: Obx(() {return _messageListWidget();}),
      bottomNavigationBar: MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _messageListWidget() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      children: [
        for (final message in controller.getChatRoomMessageList(Get.arguments['chatRoomId']))
          _messageWidget(message)
      ],
    );
  }

  _messageWidget(Message message) {
    return Column(
      children: [
        if (message.userId != _currentUserId) SizedBox(height: 8),
        _innerMessageWidget(message),
        SizedBox(height: 8),
      ],
    );
  }

  _innerMessageWidget(Message message) {
    _currentUserId = message.userId;
    UserGlobalInfoController userGlobalInfoController = Get.find<UserGlobalInfoController>();
    return userGlobalInfoController.userId == message.userId
        ? _myMessageWidget(message)
        : _opponentMessageWidget(message);
  }

  _myMessageWidget(Message message) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.grey_2,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message.message),
      ),
    );
  }

  _opponentMessageWidget(Message message) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.white,
        border: Border.all(
          color: ColorPalette.grey_3,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message.message),
      ),

    );
  }
}
