import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/controllers/seller_home_controller.dart';
import 'package:leporemart/src/controllers/seller_profile_controller.dart';
import 'package:leporemart/src/controllers/seller_search_controller.dart';
import 'package:leporemart/src/screens/buyer/auction_screen.dart';
import 'package:leporemart/src/screens/buyer/message_screen.dart';
import 'package:leporemart/src/screens/seller/home_screen.dart';
import 'package:leporemart/src/screens/seller/profile_screen.dart';
import 'package:leporemart/src/screens/seller/search_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class SellerApp extends GetView<MyBottomNavigationbarController> {
  const SellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.lazyPut(() => SellerProfileController());
      Get.lazyPut(() => SellerHomeController());
      Get.lazyPut(() => SellerSearchController());
      switch (controller.selectedSellerIndex.value) {
        case 0:
          return _homeScaffold();
        case 1:
          return _customOrderScaffold();
        case 2:
          return _messageScaffold();
        case 3:
          return _profileScaffold();
        default:
          return _homeScaffold();
      }
    });
  }

  _homeScaffold() {
    return Scaffold(
      appBar: Get.find<SellerSearchController>().isSearching.value
          ? MyAppBar(
              appBarType: AppBarType.sellerSearchAppBar,
              onTapLeadingIcon: () async {
                Get.find<SellerSearchController>().isSearching.value = false;
                Get.find<SellerSearchController>().searchController.clear();
                Get.find<SellerHomeController>().items.clear();
                Get.find<SellerHomeController>().currentPage = 1;
                await Get.find<SellerHomeController>().fetch();
                Get.back();
              },
            )
          : MyAppBar(
              appBarType: AppBarType.mainPageAppBar,
              onTapFirstActionIcon: () => Get.to(SellerSearchScreen())),
      body: SellerHomeScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  _customOrderScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: AuctionScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: MessageScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  _profileScaffold() {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(child: SellerProfileScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }
}
