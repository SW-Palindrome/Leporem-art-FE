import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/controller/buyer/exhibition/buyer_exhibition_controller.dart';

import '../../../controller/buyer/home/buyer_home_controller.dart';
import '../../../controller/buyer/profile/buyer_profile_controller.dart';
import '../../../controller/buyer/search/buyer_search_controller.dart';
import '../../../controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import '../../../routes/app_pages.dart';
import '../../theme/app_theme.dart';
import '../buyer/profile/profile_screen.dart';
import '../common/message/message_screen.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_bottom_navigationbar.dart';
import 'exhibition/exhibition_screen.dart';
import 'home/home_screen.dart';

class BuyerApp extends GetView<MyBottomNavigationbarController> {
  const BuyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedBuyerIndex.value) {
        case 0:
          return _homeScaffold();
        case 1:
          Get.find<BuyerExhibitionController>().fetchBuyerExhibitions();
          return _exhibitionScaffold();
        case 2:
          return _messageScaffold();
        case 3:
          Get.find<BuyerProfileController>().fetch();
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
              },
            )
          : MyAppBar(
              appBarType: AppBarType.mainPageAppBar,
              onTapFirstActionIcon: () => Get.toNamed(Routes.BUYER_SEARCH)),
      body: BuyerHomeScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _exhibitionScaffold() {
    return Scaffold(
      body: SafeArea(child: BuyerExhibitionScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: BuyerMessageScreen(),
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
