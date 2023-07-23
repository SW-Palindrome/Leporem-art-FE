import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

enum MyBottomNavigationBarType { buyer, seller }

class MyBottomNavigationBar extends GetView<MyBottomNavigationbarController> {
  const MyBottomNavigationBar({super.key, required this.type});

  final MyBottomNavigationBarType type;

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
            currentIndex: type == MyBottomNavigationBarType.buyer
                ? controller.selectedBuyerIndex.value
                : controller.selectedSellerIndex.value,
            elevation: 0,
            onTap: type == MyBottomNavigationBarType.buyer
                ? controller.changeBuyerIndex
                : controller.changeSellerIndex,
            selectedItemColor: ColorPalette.purple,
            items: type == MyBottomNavigationBarType.buyer
                ? [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '홈',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/auction.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/auction.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '경매',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/message_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/message_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '채팅',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/flop.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/flop.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '플롭',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '마이페이지',
                    ),
                  ]
                : [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/view.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/view.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '작품목록',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/paper_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/paper_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '주문제작',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/message_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/message_fill.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '채팅',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
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
