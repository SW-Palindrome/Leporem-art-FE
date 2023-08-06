import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/configs/firebase_config.dart';
import 'package:leporemart/src/utils/induce_membership.dart';
import 'package:leporemart/src/utils/log_analytics.dart';

class MyBottomNavigationbarController extends GetxController {
  static MyBottomNavigationbarController get to => Get.find();

  // 현재 선택된 탭 아이템 번호 저장
  final Rx<int> selectedBuyerIndex = 0.obs;
  final Rx<int> selectedSellerIndex = 0.obs;

  // 탭 이벤트가 발생할 시 selectedIndex값을 변경해줄 함수
  void changeBuyerIndex(int index) {
    if (index == 2 || index == 4) {
      induceMembership(() {
        selectedBuyerIndex.value = index;
      });
    } else {
      selectedBuyerIndex.value = index;
    }
    //하단바 선택시 로그
    late String pageStr;
    switch (index) {
      case 0:
        pageStr = "Home";
        break;
      case 1:
        pageStr = "Auction";
        break;
      case 2:
        pageStr = "Shorts";
        break;
      case 3:
        pageStr = "Chat";
        break;
      case 4:
        pageStr = "MyPage";
        break;
    }

    if (kDebugMode) {
      logAnalytics(name: "Page View", parameters: {"Page Name": pageStr});
    }
  }

  void changeSellerIndex(int index) {
    selectedSellerIndex(index);
    //하단바 선택시 로그
    late String pageStr;
    switch (index) {
      case 0:
        pageStr = "List";
        break;
      case 1:
        pageStr = "Custom Order";
        break;
      case 2:
        pageStr = "Chat";
        break;
      case 3:
        pageStr = "MyPage";
        break;
    }

    if (kDebugMode) {
      logAnalytics(name: "Page View", parameters: {"Page Name": pageStr});
    }
  }
}
