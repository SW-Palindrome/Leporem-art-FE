import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/buyer/auction_screen.dart';
import 'package:leporemart/src/screens/buyer/message_screen.dart';
import 'package:leporemart/src/screens/buyer/home_screen.dart';
import 'package:leporemart/src/screens/buyer/profile_screen.dart';
import 'package:leporemart/src/screens/buyer/flop_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class BuyerApp extends GetView<MyBottomNavigationbarController> {
  const BuyerApp({super.key});

  @override
  Widget build(BuildContext context) {
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

  Scaffold _homeScaffold() {
    return Scaffold(
      appBar: MyAppBar(
          appBarType: AppBarType.buyerMainPageAppBar,
          onTapFirstActionIcon: () => Get.toNamed('/buyer/search')),
      body: BuyerHomeScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  Widget _auctionScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: AuctionScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  Widget _messageScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: MessageScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  Widget _flopScaffold() {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.none),
      body: FlopScreen(),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }

  Widget _profileScaffold() {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(child: BuyerProfileScreen()),
      bottomNavigationBar:
          MyBottomNavigationBar(type: MyBottomNavigationBarType.buyer),
    );
  }
}
