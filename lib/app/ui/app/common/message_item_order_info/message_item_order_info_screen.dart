import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/common/message_item_order_info/message_item_order_info_controller.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import '../message_item_order_address/message_item_order_address_screen.dart';

class MessageItemOrderInfoScreen
    extends GetView<MessageItemOrderInfoController> {
  const MessageItemOrderInfoScreen({super.key});

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
          '주문 정보 입력',
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
              _orderNameEdit(),
              SizedBox(height: 30),
              _orderAddressEdit(context),
              SizedBox(height: 30),
              _orderPhoneNumberEdit(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomButton(),
    );
  }

  _orderNameEdit() {
    return Column(children: [
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
      TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller.name,
        style: TextStyle(
          color: ColorPalette.black,
          fontSize: 18,
          height: 1,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.grey_4,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.purple,
            ),
          ),
        ),
      ),
    ]);
  }

  _orderAddressEdit(BuildContext context) {
    return Obx(() {
      return Column(children: [
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
        GestureDetector(
          onTap: () async {
            DataModel model = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MessageItemOrderAddressScreen(),
              ),
            );
            controller.address.value = model.address;
            controller.zipCode.value = model.zonecode;
            controller.isAddressLoaded.value = true;
            controller.update();
          },
          child: Container(
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
                controller.isAddressLoaded.value
                    ? '[${controller.zipCode.value}] ${controller.address.value}'
                    : '주소 검색',
                style: TextStyle(
                  color: controller.isAddressLoaded.value
                      ? ColorPalette.black
                      : ColorPalette.grey_4,
                  fontSize: 18,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
        if (controller.isAddressLoaded.value) SizedBox(height: 10),
        if (controller.isAddressLoaded.value)
          TextField(
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            controller: controller.addressDetail,
            style: TextStyle(
              color: ColorPalette.black,
              fontSize: 18,
              height: 1,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.purple,
                ),
              ),
              hintText: '상세 주소',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
              ),
            ),
          ),
      ]);
    });
  }

  _orderPhoneNumberEdit() {
    return Column(children: [
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
      TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller.phoneNumber,
        maxLength: 13,
        style: TextStyle(
          color: ColorPalette.black,
          fontSize: 18,
          height: 1,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.grey_4,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.purple,
            ),
          ),
          hintText: '010-0000-0000',
          hintStyle: TextStyle(
            color: ColorPalette.grey_4,
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]+$')),
        ],
      ),
    ]);
  }

  _bottomButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 30,
        top: 20,
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          controller.name,
          controller.phoneNumber,
          controller.addressDetail
        ]),
        builder: (BuildContext context, Widget? child) {
          return NextButton(
            text: '주문하기',
            value: controller.isFilled,
            onTap: () {
              controller.order();
              Get.back();
              Get.back();
              Get.snackbar('주문 완료', '주문이 성공적으로 처리되었습니다.');
            },
          );
        },
      ),
    );
  }
}
