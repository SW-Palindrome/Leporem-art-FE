import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../utils/induce_membership.dart';
import '../../../utils/log_analytics.dart';

class MyBottomNavigationbarController extends GetxService {
  // 현재 선택된 탭 아이템 번호 저장
  final Rx<int> selectedBuyerIndex = 0.obs;
  final Rx<int> selectedSellerIndex = 0.obs;

  // 탭 이벤트가 발생할 시 selectedIndex값을 변경해줄 함수
  void changeBuyerIndex(int index) {
    if (index == 1 || index == 2) {
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
      // case 1:
      //   pageStr = "Auction";
      //   break;
      case 1:
        pageStr = "Chat";
        break;
      // case 3:
      //   pageStr = "Flop";
      //   break;
      case 2:
        pageStr = "MyPage";
        break;
    }

    if (kReleaseMode) {
      logAnalytics(
          name: "buyer_index_change", parameters: {"Page Name": pageStr});
    }
  }

  void changeSellerIndex(int index) {
    selectedSellerIndex.value = index;
    //하단바 선택시 로그
    late String pageStr;
    switch (index) {
      case 0:
        pageStr = "List";
        break;
      case 1:
        pageStr = "Exhibition";
        break;
      case 2:
        pageStr = "Chat";
        break;
      case 3:
        pageStr = "MyPage";
        break;
    }

    if (kReleaseMode) {
      logAnalytics(
          name: "seller_index_change", parameters: {"Page Name": pageStr});
    }
  }
}
