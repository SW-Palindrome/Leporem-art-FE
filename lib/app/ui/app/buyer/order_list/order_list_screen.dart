import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leporemart/app/data/provider/dio.dart';

import '../../../../controller/buyer/delivery_info_webview/delivery_info_webview_controller.dart';
import '../../../../controller/buyer/order_list/order_list_controller.dart';
import '../../../../data/models/order.dart';
import '../../../../data/repositories/delivery_info_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/my_app_bar.dart';
import '../delivery_info_webview/delivery_info_webview_screen.dart';

class OrderListScreen extends GetView<OrderListController> {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '주문 내역',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.orders.isEmpty && !controller.isLoading.value) {
            return _emptyListWidget();
          } else {
            return _orderListWidget();
          }
        }),
      ),
    );
  }

  _emptyListWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text('아직 주문 내역이 없어요.',
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.grey_5,
                fontFamily: FontPalette.pretendard,
              )),
        ],
      ),
    );
  }

  _orderListWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
      onTap: () {
        logAnalytics(name: 'order_list', parameters: {
          'action': 'order_detail ${controller.orders[index].id}'
        });
        Get.toNamed(Routes.BUYER_ORDER_INFO_EDIT,
            arguments: {'order_id': controller.orders[index].id});
      },
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
                GestureDetector(
                  onTap: () {
                    logAnalytics(name: 'order_list', parameters: {
                      'action': 'item_detail ${controller.orders[index].itemId}'
                    });
                    Get.toNamed(Routes.BUYER_ITEM_DETAIL,
                      arguments: {'item_id': controller.orders[index].itemId});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: controller.orders[index].thumbnailImage,
                      height: Get.width * 0.23,
                      width: Get.width * 0.23,
                      fit: BoxFit.cover,
                    ),
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
                          Obx(() {
                            return _topButton(controller.orders[index]);
                          }),
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
                        '${CurrencyFormatter().numberToCurrency(
                          controller.orders[index].price,
                        )}원',
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
    if (order.isReviewed) {
      return _reviewText();
    } else {
      switch (order.orderStatus) {
        case "주문완료":
          return _cancelButton(order.id);
        case "배송중":
          return _deliveryButton(order);
        case "배송완료":
          return _reviewButton(order);
        case "주문취소":
          return _cancelText();
      }
    }
  }

  _cancelButton(int orderId) {
    return GestureDetector(
      onTap: () {
        logAnalytics(
            name: 'order_list', parameters: {'action': 'cancel_start'});
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
                  name: 'order_list',
                  parameters: {'action': 'cancel_complete'});
              controller.cancel(orderId);
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
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorPalette.grey_3,
        ),
        child: Text(
          '주문 취소',
          style: TextStyle(
            color: ColorPalette.red,
            fontWeight: FontWeight.bold,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  _deliveryButton(Order order) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.BUYER_DELIVERY_INFO_WEBVIEW, arguments: {'order_id': order.id});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorPalette.grey_3,
        ),
        child: Text(
          '배송 조회',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.bold,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  _reviewButton(Order order) {
    return GestureDetector(
      onTap: () {
        logAnalytics(name: 'order_list', parameters: {'action': 'review'});
        Get.toNamed(Routes.BUYER_REVIEW_STAR, arguments: {'order': order});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorPalette.grey_3,
        ),
        child: Text(
          '후기 작성',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.bold,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 11.0,
          ),
        ),
      ),
    );
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

  _reviewText() {
    return Text(
      '후기 작성완료',
      style: TextStyle(
        color: ColorPalette.black,
        fontWeight: FontWeight.bold,
        fontFamily: "PretendardVariable",
        fontStyle: FontStyle.normal,
        fontSize: 11.0,
      ),
    );
  }
}
