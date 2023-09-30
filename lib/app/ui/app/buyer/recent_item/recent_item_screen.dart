import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/home/buyer_home_controller.dart';
import '../../../../controller/buyer/recent_item/recent_item_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';

class RecentItemScreen extends GetView<RecentItemController> {
  const RecentItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '최근 본 상품',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.items.isEmpty && !controller.isLoading.value) {
            return _emptyItemListWidget();
          } else {
            return _recentItemListWidget();
          }
        }),
      ),
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
          Text('아직 최근 본 작품이 없어요.',
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.grey_5,
                fontFamily: FontPalette.pretenderd,
              )),
        ],
      ),
    );
  }

  _recentItemListWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                _deleteButton(),
              ],
            ),
            SizedBox(height: 14),
            _recentItemList(),
          ],
        ),
      ),
    );
  }

  _deleteButton() {
    return GestureDetector(
      onTap: () {
        logAnalytics(
            name: 'recent_item', parameters: {'action': 'total_delete'});
        controller.totalDelete();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorPalette.grey_3,
        ),
        child: Text(
          '전체 삭제',
          style: TextStyle(
            color: ColorPalette.grey_7,
            fontWeight: FontWeight.w500,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  _recentItemList() {
    return Obx(
      () => Column(
        children: [
          for (int i = 0; i < controller.items.length; i++) _recentItem(i)
        ],
      ),
    );
  }

  _recentItem(int index) {
    return GestureDetector(
      onTap: () async {
        logAnalytics(name: 'recent_item', parameters: {
          'action': 'item_detail ${controller.items[index].id}'
        });
        Get.toNamed(Routes.BUYER_ITEM_DETAIL, arguments: {
          'item_id': controller.items[index].id,
        });
        await Get.find<BuyerHomeController>().view(controller.items[index].id);
        await controller.fetch();
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: controller.items[index].thumbnailImage,
                height: Get.width * 0.23,
                width: Get.width * 0.23,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.items[index].nickname,
                        style: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 10,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          logAnalytics(name: 'recent_item', parameters: {
                            'action': 'delete ${controller.items[index].id}'
                          });
                          await controller.delete(controller.items[index].id);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '삭제',
                            style: TextStyle(
                              color: ColorPalette.grey_4,
                              fontFamily: "PretendardVariable",
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.items[index].title,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${CurrencyFormatter().numberToCurrency(controller.items[index].price)}원',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Spacer(),
                      controller.items[index].isLiked
                          ? GestureDetector(
                              onTap: () async {
                                logAnalytics(name: 'recent_item', parameters: {
                                  'action':
                                      'unlike ${controller.items[index].id}'
                                });
                                await controller
                                    .unlike(controller.items[index].id);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/heart_fill.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    ColorPalette.purple, BlendMode.srcIn),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                logAnalytics(name: 'recent_item', parameters: {
                                  'action': 'like ${controller.items[index].id}'
                                });
                                await controller
                                    .like(controller.items[index].id);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/heart_outline.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    ColorPalette.grey_4, BlendMode.srcIn),
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
