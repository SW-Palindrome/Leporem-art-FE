import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_home_controller.dart';
import 'package:leporemart/src/controllers/buyer_item_creator_controller.dart';
import 'package:leporemart/src/controllers/buyer_item_detail_controller.dart';
import 'package:leporemart/src/screens/buyer/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/plant_temperature.dart';

import '../../controllers/message_controller.dart';
import '../../models/message.dart';
import 'message_detail_screen.dart';

class ItemCreatorScreen extends GetView<BuyerItemCreatorController> {
  const ItemCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
        isWhite: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        color: ColorPalette.purple,
        child: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification) {
              if (controller.scrollController.position.extentAfter == 0) {
                controller.fetch(isPagination: true);
              }
              if (controller.scrollController.position.extentBefore == 0) {
                controller.pageReset();
              }
            }
            return false;
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Container(
              child: Column(
                children: [
                  _profileInfo(),
                  SizedBox(height: 20),
                  _itemGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _profileBottomNavigationBar(),
    );
  }

  Container _profileBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 15),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       border: Border.all(
          //         color: ColorPalette.grey_6,
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SvgPicture.asset('assets/icons/plus.svg',
          //             width: 20,
          //             height: 20,
          //             colorFilter: ColorFilter.mode(
          //               ColorPalette.black,
          //               BlendMode.srcIn,
          //             )),
          //         SizedBox(width: 10),
          //         Text(
          //           '팔로우',
          //           style: TextStyle(
          //             color: ColorPalette.grey_7,
          //             fontWeight: FontWeight.w600,
          //             fontFamily: "PretendardVariable",
          //             fontStyle: FontStyle.normal,
          //             fontSize: 16.0,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: ShapeDecoration(
                gradient: ColorPalette.gradientPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/message_fill.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      ColorPalette.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      ChatRoom chatRoom =
                          await controller.getOrCreateChatRoom();
                      Get.to(() => MessageDetailScreen(),
                          arguments: {'chatRoomUuid': chatRoom.chatRoomUuid});
                    },
                    child: Text(
                      '채팅하기',
                      style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _profileInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
        () => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Get.width * 0.25),
              child: CachedNetworkImage(
                imageUrl:
                    'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
                width: Get.width * 0.25,
                height: Get.width * 0.25,
              ),
            ),
            SizedBox(height: 10),
            Text(
              controller.creatorProfile.value.nickname,
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              controller.creatorProfile.value.description,
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 10),
            PlantTemperature(
                temperature: controller.creatorProfile.value.temperature,
                type: PlantTemperatureType.all),
            SizedBox(height: 10),
            Row(
              children: [
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 15),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: ColorPalette.grey_1,
                //     ),
                //     child: Column(
                //       children: [
                //         Text(
                //           '팔로워',
                //           style: TextStyle(
                //             color: ColorPalette.grey_6,
                //             fontFamily: "PretendardVariable",
                //             fontStyle: FontStyle.normal,
                //             fontSize: 12.0,
                //           ),
                //         ),
                //         SizedBox(height: 5),
                //         Text(
                //           '150',
                //           style: TextStyle(
                //             color: ColorPalette.black,
                //             fontFamily: "PretendardVariable",
                //             fontWeight: FontWeight.w600,
                //             fontStyle: FontStyle.normal,
                //             fontSize: 12.0,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorPalette.grey_1,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '작품',
                          style: TextStyle(
                            color: ColorPalette.grey_6,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${controller.creatorProfile.value.itemCount}',
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontFamily: "PretendardVariable",
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _itemGrid() {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(top: 20, left: 24, right: 24),
        color: ColorPalette.grey_1,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 4 / 7,
          ),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return _itemWidget(index);
          },
        ),
      ),
    );
  }

  _itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        Get.off(BuyerItemDetailScreen(),
            arguments: {'item_id': controller.items[index].id});
        Get.put(BuyerItemDetailController());
        Get.find<BuyerHomeController>().view(controller.items[index].id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.items[index].thumbnailImage,
                    fit: BoxFit.cover,
                    width: Get.width * 0.5,
                    height: Get.width * 0.5,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: controller.items[index].isLiked
                        ? GestureDetector(
                            onTap: () async {
                              await controller
                                  .unlike(controller.items[index].id);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/heart_fill.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  ColorPalette.purple, BlendMode.srcIn),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await controller.like(controller.items[index].id);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/heart_outline.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  ColorPalette.white, BlendMode.srcIn),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.items[index].nickname,
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: Get.height * 0.04,
                    child: Text(
                      controller.items[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${controller.items[index].price.toString().toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},',
                        )}원',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.black,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart_fill.svg',
                        height: 12,
                        width: 12,
                        colorFilter: ColorFilter.mode(
                            controller.items[index].likes != 0
                                ? ColorPalette.purple
                                : Colors.transparent,
                            BlendMode.srcIn),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '${controller.items[index].likes}',
                        style: TextStyle(
                          color: controller.items[index].likes != 0
                              ? ColorPalette.purple
                              : Colors.transparent,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
