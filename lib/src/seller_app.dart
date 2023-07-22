import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/buyer/auction_screen.dart';
import 'package:leporemart/src/screens/buyer/message_screen.dart';
import 'package:leporemart/src/screens/buyer/home_screen.dart';
import 'package:leporemart/src/screens/buyer/profile_screen.dart';
import 'package:leporemart/src/screens/buyer/flop_screen.dart';
import 'package:leporemart/src/screens/seller/profile_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class SellerApp extends GetView<MyBottomNavigationbarController> {
  const SellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedSellerIndex.value) {
        case 0:
          return _listScaffold();
        case 1:
          return _customOrderScaffold();
        case 2:
          return _messageScaffold();
        case 3:
          return _profileScaffold();
        default:
          return _listScaffold();
      }
    });
  }

  Scaffold _listScaffold() {
    return Scaffold(
      appBar: MyAppBar(
          appBarType: AppBarType.buyerMainPageAppBar,
          onTapFirstActionIcon: () => Get.toNamed('/buyer/search')),
      body: BuyerHomeScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  Widget _customOrderScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: AuctionScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  Widget _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: MessageScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }

  Widget _profileScaffold() {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(child: SellerProfileScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.seller),
    );
  }
}
