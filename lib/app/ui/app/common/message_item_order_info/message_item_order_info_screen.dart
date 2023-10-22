import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/common/message_item_order_info/message_item_order_info_controller.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';

class MessageItemOrderInfoScreen extends GetView<MessageItemOrderInfoController> {
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
              _orderAddressEdit(),
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
          TextFormField(
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

  _orderAddressEdit() {
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
          TextFormField(
            controller: controller.address,
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

  _orderPhoneNumberEdit() {
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
          TextFormField(
            controller: controller.phoneNumber,
            maxLength: 11,
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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
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
        animation: Listenable.merge([controller.name, controller.address, controller.phoneNumber]),
        builder: (BuildContext context, Widget? child) {
          return NextButton(
            text: '주문하기',
            value: controller.isFilled,
            onTap: () {
              controller.order();
              Get.back();
              Get.snackbar('주문 완료', '주문이 성공적으로 처리되었습니다.');
            },
          );
        },
      ),
    );
  }
}