import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/auction_screen.dart';
import 'package:leporemart/src/screens/chat_screen.dart';
import 'package:leporemart/src/screens/home_screen.dart';
import 'package:leporemart/src/screens/mypage_screen.dart';
import 'package:leporemart/src/screens/shorts_screen.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class App extends GetView<BottomNavigationbarController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.buyerMainPageAppBar),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeScreen(),
            AuctionScreen(),
            ChatScreen(),
            ShortsScreen(),
            MypageScreen(),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
