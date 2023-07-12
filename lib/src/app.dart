import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/screens/auction.dart';
import 'package:leporemart/src/screens/chat.dart';
import 'package:leporemart/src/screens/home.dart';
import 'package:leporemart/src/screens/mypage.dart';
import 'package:leporemart/src/screens/shorts.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/my_bottom_navigationbar.dart';

class App extends GetView<BottomNavigationbarController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBarType: AppBarType.mainPageAppBar),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            Home(),
            Auction(),
            Chat(),
            Shorts(),
            Mypage(),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
