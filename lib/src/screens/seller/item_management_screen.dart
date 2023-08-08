import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_order_list_controller.dart';
import 'package:leporemart/src/controllers/item_management_controller.dart';
import 'package:leporemart/src/controllers/review_controller.dart';
import 'package:leporemart/src/controllers/seller_profile_controller.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/screens/buyer/review_star_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/bottom_sheet.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class ItemManagementScreen extends GetView<ItemManagementController> {
  const ItemManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '판매 관리',
        onTapLeadingIcon: () {
          Get.find<SellerProfileController>().fetch();
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.orders.isEmpty && !controller.isLoading.value) {
            return _emptyItemListWidget();
          } else {
            return _itemManagementListWidget();
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
          Text('아직 등록한 물품이 없어요.',
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.grey_5,
                fontFamily: FontPalette.pretenderd,
              )),
        ],
      ),
    );
  }

  _itemManagementListWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: _orderList(),
      ),
    );
  }

  _orderList() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          return _orderItem(index);
        },
      ),
    );
  }

  _orderItem(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: controller.orders[index].thumbnailImage,
                    height: Get.width * 0.23,
                    width: Get.width * 0.23,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '주문일자 ${controller.orders[index].orderedDatetime.split('T')[0].replaceAll('-', '/')}',
                            style: TextStyle(
                              color: ColorPalette.grey_4,
                              fontWeight: FontWeight.bold,
                              fontFamily: "PretendardVariable",
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                            ),
                          ),
                          _topButton(controller.orders[index]),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        controller.orders[index].title,
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        controller.orders[index].buyerNickname,
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (controller.orders[index].orderStatus != '주문취소')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorPalette.grey_1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        controller.orders[index].orderStatus == '주문완료'
                            ? 'assets/icons/deliver_on.svg'
                            : 'assets/icons/deliver_off.svg',
                        width: 16,
                        height: 16),
                    SizedBox(width: 6),
                    Text(
                      '배송 준비 중',
                      style: TextStyle(
                        color: controller.orders[index].orderStatus == '주문완료'
                            ? ColorPalette.black
                            : ColorPalette.grey_4,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 31.5,
                      height: 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: ColorPalette.grey_3),
                    ),
                    SvgPicture.asset(
                        controller.orders[index].orderStatus == '배송중'
                            ? 'assets/icons/deliver_on.svg'
                            : 'assets/icons/deliver_off.svg',
                        width: 16,
                        height: 16),
                    SizedBox(width: 6),
                    Text(
                      '배송 중',
                      style: TextStyle(
                        color: controller.orders[index].orderStatus == '배송중'
                            ? ColorPalette.black
                            : ColorPalette.grey_4,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 31.5,
                      height: 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: ColorPalette.grey_3),
                    ),
                    SvgPicture.asset(
                        controller.orders[index].orderStatus == '배송완료'
                            ? 'assets/icons/deliver_on.svg'
                            : 'assets/icons/deliver_off.svg',
                        width: 16,
                        height: 16),
                    SizedBox(width: 6),
                    Text(
                      '배송 완료',
                      style: TextStyle(
                        color: controller.orders[index].orderStatus == '배송완료'
                            ? ColorPalette.black
                            : ColorPalette.grey_4,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  _topButton(Order order) {
    if (order.orderStatus == "주문취소") {
      return _cancelText();
    } else {
      return _moreButton(order);
    }
  }

  _cancelText() {
    return Text(
      '주문 취소됨',
      style: TextStyle(
        color: ColorPalette.red,
        fontWeight: FontWeight.bold,
        fontFamily: "PretendardVariable",
        fontStyle: FontStyle.normal,
        fontSize: 11.0,
      ),
    );
  }

  _moreButton(Order order) {
    return GestureDetector(
      onTap: () {
        logAnalytics(name: "order_detail", parameters: {"order_id": order.id});
        Get.dialog(Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorPalette.white),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: order.orderStatus == "주문완료"
                            ? () {
                                logAnalytics(name: "order_detail", parameters: {
                                  "order_id": order.id,
                                  "status": "배송 중"
                                });
                                controller.deliveryStart(order.id);
                                Get.back();
                              }
                            : () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              '배송 중',
                              style: TextStyle(
                                color: order.orderStatus == "주문완료"
                                    ? ColorPalette.black
                                    : ColorPalette.grey_4,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(color: ColorPalette.grey_2, thickness: 1),
                      GestureDetector(
                        onTap: order.orderStatus == "배송중"
                            ? () {
                                logAnalytics(name: "order_detail", parameters: {
                                  "order_id": order.id,
                                  "status": "배송 완료"
                                });
                                controller.deliveryComplete(order.id);
                                Get.back();
                              }
                            : () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              '배송 완료',
                              style: TextStyle(
                                color: order.orderStatus == "배송중"
                                    ? ColorPalette.black
                                    : ColorPalette.grey_4,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(color: ColorPalette.grey_2, thickness: 1),
                      GestureDetector(
                        onTap: order.orderStatus == "주문완료"
                            ? () {
                                logAnalytics(name: "order_detail", parameters: {
                                  "order_id": order.id,
                                  "status": "주문 취소 확인"
                                });
                                Get.back();
                                Get.bottomSheet(
                                  MyBottomSheet(
                                    title: '주문을 취소할까요?',
                                    description: "선택하신 주문 건의 주문을 취소하시겠습니까?",
                                    height: Get.height * 0.3,
                                    buttonType: BottomSheetType.twoButton,
                                    onCloseButtonPressed: () {
                                      Get.back();
                                    },
                                    leftButtonText: '이전으로',
                                    onLeftButtonPressed: () {
                                      Get.back();
                                    },
                                    rightButtonText: '주문 취소하기',
                                    onRightButtonPressed: () {
                                      logAnalytics(
                                          name: "order_detail",
                                          parameters: {
                                            "order_id": order.id,
                                            "status": "주문 취소 확정"
                                          });
                                      controller.cancel(order.id);
                                      controller.fetch();
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
                              }
                            : () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              '주문 취소',
                              style: TextStyle(
                                color: order.orderStatus == "주문완료"
                                    ? ColorPalette.red
                                    : ColorPalette.grey_4,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 17),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorPalette.white),
                    child: Center(
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
      child: SvgPicture.asset(
        'assets/icons/more.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
      ),
    );
  }
}
