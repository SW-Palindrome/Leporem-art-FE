import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/item_management/item_management_controller.dart';
import '../../../theme/app_theme.dart';

class SellerItemOrderInfoScreen extends GetView<ItemManagementController> {
  const SellerItemOrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
            ),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          '배송지 정보 조회',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorPalette.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              _orderName(),
              SizedBox(height: 30),
              _orderZipCode(),
              SizedBox(height: 30),
              _orderAddress(),
              SizedBox(height: 30),
              _orderPhoneNumber(),
            ],
          ),
        ),
      ),
    );
  }

  _orderName() {
    return Obx(() {
      return Column(
          children: [
            Row(
              children: [
                Text(
                  '주문자명',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: Get.width,
              height: 58,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.currentOrder.buyerName,
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
              ),
            ),
          ]);
    });
  }

  _orderZipCode() {
    return Obx(() {
      return Column(
          children: [
            Row(
              children: [
                Text(
                  '우편 번호',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: Get.width,
              height: 58,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.currentOrder.zipCode,
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
              ),
            ),
          ]);
    });
  }

  _orderAddress() {
    return Obx(() {
      return Column(
          children: [
            Row(
              children: [
                Text(
                  '주소',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: Get.width,
              height: 58,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${controller.currentOrder.address} ${controller.currentOrder.addressDetail}',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
              ),
            ),
          ]);
    });
  }

  _orderPhoneNumber() {
    return Obx(() {
      return Column(
          children: [
            Row(
              children: [
                Text(
                  '전화번호',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: Get.width,
              height: 58,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.currentOrder.phoneNumber,
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
              ),
            ),
          ]);
    });
  }

}