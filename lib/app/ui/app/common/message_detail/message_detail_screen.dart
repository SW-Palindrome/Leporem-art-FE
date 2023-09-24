import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/common/message/message_controller.dart';
import '../../../../controller/common/user_global_info/user_global_info_controller.dart';
import '../../../../data/models/message.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';

class MessageDetailScreen extends GetView<MessageController> {
  MessageDetailScreen({super.key});
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () => Get.back(),
        isWhite: true,
        title: controller.chatRoom.opponentNickname,
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
    List<Message> messageList = controller.reversedMessageList;
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        reverse: true,
        shrinkWrap: true,
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          return _messageWidget(messageList[index], index);
        },
      ),
    );
  }

  _messageWidget(Message message, int index) {
    Column widget = Column(
      children: [
        if (controller.isDifferentUserIndex(index)) SizedBox(height: 8),
        _innerMessageWidget(message, index),
        SizedBox(height: 8),
      ],
    );
    return widget;
  }

  _innerMessageWidget(Message message, int index) {
    return controller.chatRoom.opponentUserId != message.userId
        ? _myMessageWidget(message)
        : _opponentMessageWidget(message, index);
  }

  _myMessageWidget(Message message) {
    return Container(
      alignment: Alignment.centerRight,
      child: _messageProcessWidget(message, _myMessageBoxDecoration()),
    );
  }

  _myMessageBoxDecoration() {
    return BoxDecoration(
      color: ColorPalette.grey_2,
      borderRadius: BorderRadius.circular(18),
    );
  }

  _opponentMessageWidget(Message message, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (controller.isDifferentUserIndex(index))
            CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage(controller.chatRoom.opponentProfileImageUrl),
            ),
          if (!controller.isDifferentUserIndex(index)) SizedBox(width: 32),
          SizedBox(width: 8),
          _messageProcessWidget(message, _opponentMessageBoxDecoration()),
        ],
      ),
    );
  }

  _opponentMessageBoxDecoration() {
    return BoxDecoration(
      color: ColorPalette.white,
      border: Border.all(
        color: ColorPalette.grey_3,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(18),
    );
  }

  _messageProcessWidget(Message message, BoxDecoration boxDecoration) {
    switch (message.type) {
      case MessageType.text:
        return _textMessageWidget(message, boxDecoration);
      case MessageType.image:
        return Container();
      case MessageType.itemShare:
        return _itemShareWidget(message, boxDecoration);
      case MessageType.itemInquiry:
        return _itemInquiryWidget(message, boxDecoration);
      case MessageType.order:
        return _orderWidget(message, boxDecoration);
    }
  }

  _itemInfoWidget(String description, Message message,
      BoxDecoration boxDecoration, Function onTapAction) {
    ItemInfo? item = message.itemInfo;
    if (item == null) {
      controller.fetchItemInfo(message);
      return CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: () {
        onTapAction(item);
      },
      child: Container(
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: item.thumbnailImage,
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
                    description,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretenderd,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.sellerNickname,
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
                      item.title,
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
                    '${CurrencyFormatter().numberToCurrency(item.price)}원',
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

  _itemShareWidget(Message message, BoxDecoration boxDecoration) {
    return _itemInfoWidget('작품 공유', message, boxDecoration, (item) {
      if (controller.chatRoom.isBuyerRoom) {
        Get.toNamed(Routes.BUYER_ITEM_DETAIL,
            arguments: {'item_id': item.itemId});
      } else {
        Get.toNamed(Routes.SELLER_ITEM_DETAIL,
            arguments: {'item_id': item.itemId});
      }
    });
  }

  _itemInquiryWidget(Message message, BoxDecoration boxDecoration) {
    return _itemInfoWidget(
      '작품 문의',
      message,
      boxDecoration,
      (item) {
        if (controller.chatRoom.isBuyerRoom) {
          Get.toNamed(Routes.BUYER_ITEM_DETAIL,
              arguments: {'item_id': item.itemId});
        } else {
          Get.toNamed(Routes.SELLER_ITEM_DETAIL,
              arguments: {'item_id': item.itemId});
        }
      },
    );
  }

  _orderWidget(Message message, BoxDecoration boxDecoration) {
    return _itemInfoWidget('주문 신청', message, boxDecoration, (item) {
      if (controller.chatRoom.isBuyerRoom) {
        logAnalytics(name: 'enter_order_list');
        Get.toNamed(Routes.BUYER_ORDER);
      } else {
        logAnalytics(name: "enter_item_management");
        Get.toNamed(Routes.SELLER_ITEM_MANAGEMENT);
      }
    });
  }

  _textMessageWidget(Message message, BoxDecoration boxDecoration) {
    return Container(
      decoration: boxDecoration,
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
                              String text = _textEditingController.text;
                              bool isRegistered =
                                  controller.chatRoom.isRegistered;
                              if (text.isEmpty) {
                                return;
                              }
                              _textEditingController.clear();
                              if (Get.arguments['fromItemId'] != null) {
                                if (!isRegistered) {
                                  await controller.createChatRoom(
                                    Get.arguments['chatRoomUuid'],
                                    controller.chatRoom.opponentNickname,
                                    Get.arguments['fromItemId'].toString(),
                                    MessageType.itemInquiry,
                                  );
                                  isRegistered = true;
                                } else {
                                  await controller.sendMessage(
                                    Get.arguments['chatRoomUuid'],
                                    Get.arguments['fromItemId'].toString(),
                                    MessageType.itemInquiry,
                                  );
                                }
                                Get.arguments.remove('fromItemId');
                              }
                              if (!isRegistered) {
                                await controller.createChatRoom(
                                    Get.arguments['chatRoomUuid'],
                                    controller.chatRoom.opponentNickname,
                                    text,
                                    MessageType.text);
                                isRegistered = true;
                              } else {
                                await controller.sendMessage(
                                    Get.arguments['chatRoomUuid'],
                                    text,
                                    MessageType.text);
                              }
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
            height: controller.isPlusButtonClicked.value ? 110 : 0,
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
                            Get.toNamed(Routes.MESSAGE_SHARE, arguments: {
                              'chatRoomUuid': Get.arguments['chatRoomUuid']
                            });
                          },
                        ),
                        // _messageBottomPlusIcon(
                        //   '앨범',
                        //   'image',
                        //   ColorPalette.pink,
                        //   () {},
                        // ),
                        // _messageBottomPlusIcon(
                        //   '카메라',
                        //   'camera',
                        //   ColorPalette.green,
                        //   () {},
                        // ),
                        // _messageBottomPlusIcon(
                        //   '주소 공유',
                        //   'location',
                        //   ColorPalette.yellow,
                        //   () {},
                        // ),
                        // _messageBottomPlusIcon(
                        //   '번호 공유',
                        //   'contact',
                        //   ColorPalette.orange,
                        //   () {},
                        // ),
                        if (controller.chatRoom.isBuyerRoom &&
                            controller.chatRoom.opponentNickname !=
                                Get.find<UserGlobalInfoController>().nickname)
                          _messageBottomPlusIcon(
                            '주문 넣기',
                            'cart',
                            Color(0xff9d00e7),
                            () {
                              Get.toNamed(Routes.MESSAGE_ORDER, arguments: {
                                'chatRoomUuid': Get.arguments['chatRoomUuid']
                              });
                            },
                          ),
                        // if (controller.chatRoom.isBuyerRoom)
                        //   _messageBottomPlusIcon(
                        //     '주문제작 요청',
                        //     'paper_outline',
                        //     ColorPalette.purple,
                        //     () {},
                        //   ),
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
