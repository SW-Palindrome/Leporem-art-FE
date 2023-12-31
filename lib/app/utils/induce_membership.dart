import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/common/user_global_info/user_global_info_controller.dart';
import '../routes/app_pages.dart';
import '../ui/app/widgets/bottom_sheet.dart';
import 'log_analytics.dart';

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
            Get.offAllNamed(Routes.LOGIN);
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
