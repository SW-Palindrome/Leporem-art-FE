import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_item_creator_controller.dart';
import 'package:leporemart/src/controllers/buyer_item_detail_controller.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:leporemart/src/screens/buyer/item_creator_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/utils/induce_membership.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/bottom_sheet.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';
import 'package:leporemart/src/widgets/plant_temperature.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/message_controller.dart';
import '../../models/message.dart';
import 'message_detail_screen.dart';

class BuyerItemDetailScreen extends GetView<BuyerItemDetailController> {
  const BuyerItemDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.buyerItemDetailAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
        onTapFirstActionIcon: () {
          Get.bottomSheet(
            MyBottomSheet(
              title: '게시물 신고',
              description: "해당 게시물을 신고하시겠습니까?",
              height: Get.height * 0.3,
              buttonType: BottomSheetType.twoButton,
              onCloseButtonPressed: () {
                Get.back();
              },
              leftButtonText: '이전으로',
              onLeftButtonPressed: () {
                Get.back();
              },
              rightButtonText: '신고하기',
              onRightButtonPressed: () {
                logAnalytics(name: 'item_detail_report');
                launchUrl(Uri.parse(
                    'mailto:swm.palindrome@gmail.com?subject=[게시물 신고] ${controller.itemDetail.value.id}번 게시물&body=신고 사유를 적어주세요.\n'));
                Get.back();
              },
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
          );
        },
        isWhite: true,
      ),
      body: SafeArea(
        child: Obx(() {
          // isLoading 변수에 따라 로딩창 또는 원래 화면을 표시
          return controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: ColorPalette.purple))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _itemTitle(),
                      _itemThumbnail(),
                      _itemDescription(),
                    ],
                  ),
                );
        }),
      ),
      bottomNavigationBar: _itemBottomNavigationBar(),
    );
  }

  _itemBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (Get.find<UserGlobalInfoController>().userType ==
                  UserType.member)
                Obx(
                  () => GestureDetector(
                    onTap: controller.itemDetail.value.isLiked
                        ? () async {
                            logAnalytics(
                                name: "item_detail_unlike",
                                parameters: {
                                  "item_id": controller.itemDetail.value.id
                                });
                            await controller.unlike();
                          }
                        : () async {
                            logAnalytics(name: "item_detail_like", parameters: {
                              "item_id": controller.itemDetail.value.id
                            });
                            await controller.like();
                          },
                    child: Obx(
                      () => SvgPicture.asset(
                        controller.itemDetail.value.isLiked
                            ? 'assets/icons/heart_fill.svg'
                            : 'assets/icons/heart_outline.svg',
                        width: 30,
                        colorFilter: ColorFilter.mode(
                            controller.itemDetail.value.isLiked
                                ? ColorPalette.purple
                                : ColorPalette.grey_4,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 10),
              Obx(
                () => Text(
                  controller.itemDetail.value.currentAmount == 0
                      ? '판매 완료'
                      : '${CurrencyFormatter().numberToCurrency(controller.itemDetail.value.price)}원',
                  style: TextStyle(
                    color: Color(0xff191f28),
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          NextButton(
            text: "채팅하기",
            value: true,
            onTap: () {
              induceMembership(() async {
                logAnalytics(name: "item_detail_message", parameters: {
                  "nickname": controller.itemDetail.value.nickname
                });
                MessageController messageController =
                    Get.find<MessageController>();
                ChatRoom? chatRoom =
                    messageController.getChatRoomByOpponentNicknameFromBuyer(
                        controller.itemDetail.value.nickname);
                if (chatRoom != null) {
                  Get.to(() => MessageDetailScreen(), arguments: {
                    'chatRoomUuid': messageController
                        .getChatRoomByOpponentNicknameFromBuyer(
                            controller.itemDetail.value.nickname)
                        .chatRoomUuid,
                    'fromItemId': controller.itemDetail.value.id,
                  });
                  return;
                }
                ChatRoom newChatRoom = await messageController
                    .createTempChatRoom(controller.itemDetail.value.nickname);
                Get.to(() => MessageDetailScreen(), arguments: {
                  'chatRoomUuid': newChatRoom.chatRoomUuid,
                  'fromItemId': controller.itemDetail.value.id
                });
              });
            },
            width: Get.width * 0.35,
          ),
        ],
      ),
    );
  }

  _itemTitle() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorPalette.grey_2,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.itemDetail.value.title,
              style: TextStyle(
                color: Color(0xff191f28),
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              induceMembership(() {
                logAnalytics(name: "enter_seller_profile", parameters: {
                  "nickname": controller.itemDetail.value.nickname,
                });
                Get.off(ItemCreatorScreen(), arguments: {
                  'nickname': controller.itemDetail.value.nickname
                });
                Get.put(BuyerItemCreatorController());
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CachedNetworkImage(
                          imageUrl: controller.itemDetail.value.profileImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Obx(
                      () => Text(
                        controller.itemDetail.value.nickname,
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => PlantTemperature(
                      temperature:
                          controller.itemDetail.value.temperature ?? 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _itemThumbnail() {
    return Stack(
      children: [
        Obx(
          () => CarouselSlider(
            options: CarouselOptions(
              height: Get.width,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                controller.changeIndex(index);
              },
            ),
            items: [
              CachedNetworkImage(
                imageUrl: controller.itemDetail.value.thumbnailImage,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.width,
              ),
              for (String imageUrl in controller.itemDetail.value.images)
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.width,
                ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: controller.togglePlay,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controller.videoPlayerController),
                        Obx(
                          () => AnimatedOpacity(
                            opacity: controller.isIconVisible.value ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: controller.isPlaying.value
                                ? Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.pause,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: controller.toggleVolume,
                      child: Obx(
                        () => Icon(
                          controller.isMuted.value
                              ? Icons.volume_off
                              : Icons.volume_up,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Row(
                    children: [
                      for (int i = 0;
                          i < controller.itemDetail.value.images.length + 1;
                          i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.index.value == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.index.value ==
                                  controller.itemDetail.value.images.length + 1
                              ? ColorPalette.purple
                              : ColorPalette.purple.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _categoryWidget(String category) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: ColorPalette.grey_3,
        ),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: Color(0xff191f28),
            fontWeight: FontWeight.w400,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  _itemDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  children: [
                    for (String tag in controller.itemDetail.value.category)
                      _categoryWidget(tag),
                  ],
                ),
              ),
              Obx(
                () => Text(
                  "잔여 ${controller.itemDetail.value.currentAmount}점",
                  style: TextStyle(
                    color: Color(0xff594bf8),
                    fontWeight: FontWeight.w400,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Obx(
            () => Text(
              controller.itemDetail.value.description,
              style: TextStyle(
                color: Color(0xff191f28),
                fontWeight: FontWeight.w400,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 13.0,
              ),
            ),
          ),
          SizedBox(height: 16),
          if (controller.itemDetail.value.width != null ||
              controller.itemDetail.value.height != null ||
              controller.itemDetail.value.depth != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.grey_2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '작품 크기',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      if (controller.itemDetail.value.width != null)
                        Text(
                          '가로 ${controller.itemDetail.value.width}cm',
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0,
                          ),
                        ),
                      if (controller.itemDetail.value.width != null &&
                          (controller.itemDetail.value.depth != null ||
                              controller.itemDetail.value.height != null))
                        SvgPicture.asset(
                          'assets/icons/cancel.svg',
                          width: 10,
                          height: 10,
                          colorFilter: ColorFilter.mode(
                              ColorPalette.black, BlendMode.srcIn),
                        ),
                      if (controller.itemDetail.value.depth != null)
                        Text(
                          '세로 ${controller.itemDetail.value.depth}cm',
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0,
                          ),
                        ),
                      if (controller.itemDetail.value.depth != null &&
                          controller.itemDetail.value.height != null)
                        SvgPicture.asset(
                          'assets/icons/cancel.svg',
                          width: 10,
                          height: 10,
                          colorFilter: ColorFilter.mode(
                              ColorPalette.black, BlendMode.srcIn),
                        ),
                      if (controller.itemDetail.value.height != null)
                        Text(
                          '높이 ${controller.itemDetail.value.height}cm',
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
