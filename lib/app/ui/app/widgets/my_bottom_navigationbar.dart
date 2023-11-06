import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import '../../../controller/common/message/message_controller.dart';
import '../../../controller/common/user_global_info/user_global_info_controller.dart';
import '../../theme/app_theme.dart';

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
                        'assets/icons/collection.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/collection.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '전시전',
                    ),
                    _chattingBottomNavigationBarItem(),
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
                        'assets/icons/collection.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/collection.svg',
                        colorFilter: ColorFilter.mode(
                            ColorPalette.purple, BlendMode.srcIn),
                      ),
                      label: '전시전',
                    ),
                    _chattingBottomNavigationBarItem(),
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

  _chattingBottomNavigationBarItem() {
    UserGlobalInfoController userGlobalInfoController =
        Get.find<UserGlobalInfoController>();
    if (userGlobalInfoController.userType == UserType.guest) {
      return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/message_fill.svg',
          colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          'assets/icons/message_fill.svg',
          colorFilter: ColorFilter.mode(ColorPalette.purple, BlendMode.srcIn),
        ),
        label: '채팅',
      );
    }
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/icons/message_fill.svg',
              colorFilter:
                  ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
            ),
            if (isMessageUnread)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: ColorPalette.purple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
      activeIcon: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/icons/message_fill.svg',
              colorFilter:
                  ColorFilter.mode(ColorPalette.purple, BlendMode.srcIn),
            ),
            if (isMessageUnread)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: ColorPalette.purple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
      label: '채팅',
    );
  }

  bool get isMessageUnread {
    MessageController messageController = Get.find<MessageController>();
    if (type == MyBottomNavigationBarType.buyer) {
      return messageController.isBuyerMessageUnread;
    } else {
      return messageController.isSellerMessageUnread;
    }
  }
}
