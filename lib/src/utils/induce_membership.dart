import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:leporemart/src/screens/account/login_screen.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/bottom_sheet.dart';

void induceMembership(Function() callback) {
  switch (Get.find<UserGlobalInfoController>().userType) {
    case UserType.member:
      callback();
      break;
    case UserType.guest:
      Get.bottomSheet(
        MyBottomSheet(
          title: "로그인이 필요해요!",
          description: "로그인을 해야 진행할 수 있습니다.\n로그인을 하시겠습니까?",
          height: Get.height * 0.3,
          buttonType: BottomSheetType.oneButton,
          leftButtonText: '로그인하고 계속하기',
          onLeftButtonPressed: () {
            logAnalytics(name: "induce_login");
            Get.offAll(LoginScreen());
          },
          onCloseButtonPressed: () {
            Get.back();
          },
        ),
        isDismissible: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
      );
      break;
  }
}
