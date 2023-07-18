import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/buyer/auction_screen.dart';
import 'package:leporemart/src/screens/buyer/message_screen.dart';
import 'package:leporemart/src/screens/buyer/home_screen.dart';
import 'package:leporemart/src/screens/buyer/item_search_screen.dart';
import 'package:leporemart/src/screens/buyer/profile_screen.dart';
import 'package:leporemart/src/screens/buyer/flop_screen.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class BuyerApp extends GetView<BottomNavigationbarController> {
  const BuyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              final selectedIndex = controller.selectedIndex.value;
              switch (selectedIndex) {
                case 0:
                  return MyAppBar(
                      appBarType: AppBarType.buyerMainPageAppBar,
                      onTapFirstActionIcon: () => Get.toNamed('/buyer/search'));
                case 1:
                  return MyAppBar(appBarType: AppBarType.none);
                case 2:
                  return MyAppBar(appBarType: AppBarType.none);
                case 3:
                  return MyAppBar(appBarType: AppBarType.none);
                case 4:
                  return MyAppBar(appBarType: AppBarType.none);
                default:
                  return SizedBox.shrink();
              }
            }),
            Expanded(
              child: Obx(() {
                final selectedIndex = controller.selectedIndex.value;
                switch (selectedIndex) {
                  case 0:
                    return BuyerHomeScreen();
                  case 1:
                    return AuctionScreen();
                  case 2:
                    return MessageScreen();
                  case 3:
                    return FlopScreen();
                  case 4:
                    return ProfileScreen();
                  default:
                    return SizedBox.shrink();
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
