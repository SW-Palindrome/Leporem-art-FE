import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/profile/profile_screen.dart';
import 'package:leporemart/app/ui/app/seller/search/search_screen.dart';

import '../../../controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import '../../../controller/seller/home/seller_home_controller.dart';
import '../../../controller/seller/profile/seller_profile_controller.dart';
import '../../../controller/seller/search/seller_search_controller.dart';
import '../../theme/app_theme.dart';
import '../common/message/message_screen.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_bottom_navigationbar.dart';
import 'exhibition/exhibition_screen.dart';
import 'home/home_screen.dart';

class SellerApp extends GetView<MyBottomNavigationbarController> {
  const SellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedSellerIndex.value) {
        case 0:
          return _homeScaffold();
        case 1:
          return _exhibitionScaffold();
        case 2:
          return _messageScaffold();
        case 3:
          Get.find<SellerProfileController>().fetch();
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

  _exhibitionScaffold() {
    return Scaffold(
      body: SafeArea(child: SellerExhibitionScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: SellerMessageScreen(),
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
