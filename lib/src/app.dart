import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/auction_screen.dart';
import 'package:leporemart/src/screens/chat_screen.dart';
import 'package:leporemart/src/screens/home_screen.dart';
import 'package:leporemart/src/screens/item_search_screen.dart';
import 'package:leporemart/src/screens/mypage_screen.dart';
import 'package:leporemart/src/screens/shorts_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class App extends GetView<BottomNavigationbarController> {
  const App({Key? key});

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
                  return MyAppBar(appBarType: AppBarType.buyerMainPageAppBar);
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
                    return HomeScreen();
                  case 1:
                    return AuctionScreen();
                  case 2:
                    return ChatScreen();
                  case 3:
                    return ShortsScreen();
                  case 4:
                    return MypageScreen();
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
