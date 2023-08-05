import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/controllers/message_item_order_controller.dart';
import 'package:leporemart/src/controllers/message_item_share_controller.dart';
import 'package:leporemart/src/screens/buyer/message_item_order_screen.dart';
import 'package:leporemart/src/screens/buyer/message_item_share_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';

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
    List<Message> messageList = controller
        .getChatRoom(Get.arguments['chatRoomId'])
        .messageList
        .reversed
        .toList();
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        reverse: true,
        shrinkWrap: true,
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          return _messageWidget(messageList[index]);
        },
      ),
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
        ? _myMessageWidget2(message)
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

  _myMessageWidget2(Message message) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.grey_2,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg",
                  width: Get.width * 0.215,
                  height: Get.width * 0.215,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '작품 공유',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretenderd,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '홍준식',
                    style: TextStyle(
                      color: ColorPalette.grey_5,
                      fontFamily: FontPalette.pretenderd,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Text(
                      '가로등 빛 받은 나뭇잎 컵가로등 빛 받은 나뭇잎 컵',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontFamily: FontPalette.pretenderd,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${CurrencyFormatter().numberToCurrency(10000)}원',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretenderd,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
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
                  maxWidth: Get.width * 0.8,
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
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: controller.isPlusButtonClicked.value ? 220 : 0,
            child: controller.isPlusButtonClicked.value
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    child: GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      children: [
                        _messageBottomPlusIcon(
                          '작품 공유',
                          'link',
                          Color(0xff4A9dff),
                          () {
                            Get.to(MessageItemShareScreen(), arguments: {
                              'chatRoomId': Get.arguments['chatRoomId']
                            });
                            Get.put(MessageItemShareController());
                          },
                        ),
                        _messageBottomPlusIcon(
                          '앨범',
                          'image',
                          ColorPalette.pink,
                          () {},
                        ),
                        _messageBottomPlusIcon(
                          '카메라',
                          'camera',
                          ColorPalette.green,
                          () {},
                        ),
                        _messageBottomPlusIcon(
                          '주소 공유',
                          'location',
                          ColorPalette.yellow,
                          () {},
                        ),
                        _messageBottomPlusIcon(
                          '번호 공유',
                          'contact',
                          ColorPalette.orange,
                          () {},
                        ),
                        _messageBottomPlusIcon(
                          '주문 넣기',
                          'cart',
                          Color(0xff9d00e7),
                          () {
                            Get.to(MessageItemOrderScreen(), arguments: {
                              'chatRoomId': Get.arguments['chatRoomId']
                            });
                            Get.put(MessageItemOrderController());
                          },
                        ),
                        _messageBottomPlusIcon(
                          '주문제작 요청',
                          'paper_outline',
                          ColorPalette.purple,
                          () {},
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          );
        }),
      ],
    );
  }

  _messageBottomPlusIcon(
      String text, String icon, Color color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                width: 24,
                height: 24,
                colorFilter:
                    ColorFilter.mode(ColorPalette.white, BlendMode.srcIn),
              ),
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
      ),
    );
  }
}
