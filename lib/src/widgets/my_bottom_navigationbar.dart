import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class MyBottomNavigationBar extends GetView<BottomNavigationbarController> {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 10)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            elevation: 0,
            onTap: controller.changeIndex,
            selectedItemColor: ColorPalette.black,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: ColorPalette.grey_4,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: ColorPalette.black,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/auction.svg',
                  color: ColorPalette.grey_4,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/auction.svg',
                  color: ColorPalette.black,
                ),
                label: '경매',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  color: ColorPalette.grey_4,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  color: ColorPalette.black,
                ),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/shorts.svg',
                  color: ColorPalette.grey_4,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/shorts.svg',
                  color: ColorPalette.black,
                ),
                label: '쇼츠',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/mypage.svg',
                  color: Color(0xffADB3BE),
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/mypage.svg',
                  color: ColorPalette.black,
                ),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
