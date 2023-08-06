import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/controllers/buyer_home_controller.dart';
import 'package:leporemart/src/controllers/message_controller.dart';
import 'package:leporemart/src/controllers/buyer_profile_controller.dart';
import 'package:leporemart/src/controllers/buyer_search_controller.dart';
import 'package:leporemart/src/screens/buyer/auction_screen.dart';
import 'package:leporemart/src/screens/buyer/message_screen.dart';
import 'package:leporemart/src/screens/buyer/home_screen.dart';
import 'package:leporemart/src/screens/buyer/profile_screen.dart';
import 'package:leporemart/src/screens/buyer/flop_screen.dart';
import 'package:leporemart/src/screens/buyer/search_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/chatting_socket_singleton.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

import 'controllers/user_global_info_controller.dart';

class BuyerApp extends GetView<MyBottomNavigationbarController> {
  const BuyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.find<UserGlobalInfoController>().userType == UserType.member) {
      Get.put(MessageController());
      ChattingSocketSingleton();
    }
    Get.lazyPut(() => BuyerSearchController());
    Get.lazyPut(() => BuyerHomeController());
    Get.lazyPut(() => BuyerProfileController());
    return Obx(() {
      switch (controller.selectedBuyerIndex.value) {
        case 0:
          return _homeScaffold();
        case 1:
          return _auctionScaffold();
        case 2:
          return _messageScaffold();
        case 3:
          return _flopScaffold();
        case 4:
          return _profileScaffold();
        default:
          return _homeScaffold();
      }
    });
  }

  _homeScaffold() {
    return Scaffold(
      appBar: Get.find<BuyerSearchController>().isSearching.value
          ? MyAppBar(
              appBarType: AppBarType.buyerSearchAppBar,
              onTapLeadingIcon: () async {
                Get.find<BuyerSearchController>().isSearching.value = false;
                Get.find<BuyerSearchController>().searchController.clear();
                Get.find<BuyerHomeController>().items.clear();
                Get.find<BuyerHomeController>().currentPage = 1;
                await Get.find<BuyerHomeController>().fetch();
                Get.back();
              },
            )
          : MyAppBar(
              appBarType: AppBarType.mainPageAppBar,
              onTapFirstActionIcon: () => Get.to(BuyerSearchScreen())),
      body: BuyerHomeScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _auctionScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: AuctionScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.noticeAppBar),
      body: BuyerMessageScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _flopScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: FlopScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _profileScaffold() {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(child: BuyerProfileScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }
}
