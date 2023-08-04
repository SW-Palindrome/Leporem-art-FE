import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

import '../../models/message.dart';
import '../../widgets/my_app_bar.dart';

class MessageDetailScreen extends GetView<BuyerMessageController> {
  MessageDetailScreen({super.key});
  int _currentUserId = -1;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () => Get.back(),
        isWhite: true,
        title: controller
            .getChatRoom(Get.arguments['chatRoomId'])
            .opponentNickname,
      ),
      backgroundColor: ColorPalette.white,
      body: SafeArea(child: Obx(() {
        return Container(
          color: ColorPalette.white,
          child: Column(
            children: [
              Expanded(
                child: _messageListWidget(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _messageBottomWidget(),
              ),
            ],
          ),
        );
      })),
    );
  }

  _messageListWidget() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      reverse: true,
      children: [
        for (final message
            in controller.getChatRoom(Get.arguments['chatRoomId']).messageList)
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
    ChatRoom currentChatRoom =
        controller.getChatRoom(Get.arguments['chatRoomId']);
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
    );
  }

  _opponentMessageWidget(Message message) {
    ChatRoom currentChatRoom =
        controller.getChatRoom(Get.arguments['chatRoomId']);
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (_currentUserId != message.userId)
            CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage(currentChatRoom.opponentProfileImageUrl),
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
    return Column(
      children: [
        Container(
          // height: 54,
          color: ColorPalette.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isPlusButtonClicked.value =
                        !controller.isPlusButtonClicked.value;
                  },
                  child: Obx(
                    () => SvgPicture.asset(
                      controller.isPlusButtonClicked.value
                          ? 'assets/icons/cancel.svg'
                          : 'assets/icons/plus.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          ColorPalette.grey_5, BlendMode.srcIn),
                    ),
                  ),
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
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: null,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () async {
                              await controller.sendMessage(
                                  Get.arguments['chatRoomId'],
                                  _textEditingController.text);
                              _textEditingController.clear();
                            },
                            child: Text(
                              '보내기',
                              style: TextStyle(
                                fontFamily: FontPalette.pretenderd,
                                fontSize: 14,
                                color: ColorPalette.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: '메시지를 입력하세요.',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: FontPalette.pretenderd,
                            fontSize: 16,
                            color: ColorPalette.grey_4,
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: FontPalette.pretenderd,
                          fontSize: 16,
                          color: ColorPalette.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          return (controller.isPlusButtonClicked.value
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                            SizedBox(width: 32),
                            _messageBottomPlusIcon(
                                '작품 공유', 'link', Color(0xff4A9dff)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox());
        }),
      ],
    );
  }

  _messageBottomPlusIcon(String text, String icon, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: SvgPicture.asset(
            'assets/icons/$icon.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(ColorPalette.white, BlendMode.srcIn),
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            color: ColorPalette.black,
            fontFamily: FontPalette.pretenderd,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
