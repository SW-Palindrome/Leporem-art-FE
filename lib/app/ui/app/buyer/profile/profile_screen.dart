import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/profile/buyer_profile_controller.dart';
import '../../../../controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';

class BuyerProfileScreen extends GetView<BuyerProfileController> {
  BuyerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(color: ColorPalette.purple));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                _titleRow(),
                SizedBox(height: Get.height * 0.03),
                _profileRow(),
                Divider(color: ColorPalette.grey_2, thickness: 10),
                _menuColumn(
                  title: '작품관리',
                  contents: ['주문 내역', /*'관심 작품',*/ '최근 본 작품'],
                  icons: ['list', /*'heart_outline',*/ 'history'],
                  onTaps: [
                    () {
                      logAnalytics(name: 'enter_order_list');
                      Get.toNamed(Routes.BUYER_ORDER);
                    },
                    /*() {},*/
                    () {
                      logAnalytics(name: 'enter_recent_item');
                      Get.toNamed(Routes.BUYER_RECENT_ITEM);
                    }
                  ],
                ),
                // Divider(color: ColorPalette.grey_2, thickness: 10),
                // _menuColumn(
                //   title: '커뮤니티 관리',
                //   contents: ['팔로잉 목록', '차단 목록'],
                //   icons: ['followers', 'block'],
                //   onTaps: [
                //     () {},
                //     () {},
                //   ],
                // ),
                if (!controller.buyerProfile.value.isSeller)
                  Divider(color: ColorPalette.grey_2, thickness: 10),
                if (!controller.buyerProfile.value.isSeller)
                  _menuColumn(
                    title: '판매자 인증',
                    contents: ['학교 이메일 인증'],
                    icons: ['mail'],
                    onTaps: [
                      () {
                        logAnalytics(name: 'enter_seller_signup');
                        Get.toNamed(Routes.EMAIL);
                      },
                    ],
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  _titleRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '마이페이지',
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 24.0,
            ),
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: SvgPicture.asset(
          //     'assets/icons/setting.svg',
          //     width: 24,
          //     height: 24,
          //     colorFilter: ColorFilter.mode(
          //       ColorPalette.grey_4,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  _profileRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Get.width * 0.1),
                child: CachedNetworkImage(
                  imageUrl: controller.buyerProfile.value.profileImage,
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    logAnalytics(name: 'enter_buyer_profile_edit');
                    Get.toNamed(Routes.BUYER_PROFILE_EDIT);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorPalette.grey_2,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          ColorPalette.grey_5,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorPalette.purple,
                ),
                child: Text(
                  '구매자',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                controller.buyerProfile.value.nickname,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Spacer(),
          if (controller.buyerProfile.value.isSeller)
            GestureDetector(
              onTap: () async {
                logAnalytics(name: 'swap_seller');
                Get.find<MyBottomNavigationbarController>()
                    .changeSellerIndex(3);
                Get.offAllNamed(Routes.SELLER_APP);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorPalette.grey_2,
                ),
                child: Row(
                  children: [
                    Text(
                      '판매자 전환',
                      style: TextStyle(
                        color: ColorPalette.grey_7,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      width: 12,
                      height: 12,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.grey_5,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  _menuColumn({
    required String title,
    required List<String> contents,
    required List<String> icons,
    required List<Function()> onTaps,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorPalette.black,
              fontWeight: FontWeight.w600,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          for (int i = 0; i < contents.length; i++)
            _menuColumnItem(
              content: contents[i],
              icon: icons[i],
              onTap: onTaps[i],
            ),
        ],
      ),
    );
  }

  _menuColumnItem(
      {required String content,
      required String icon,
      required Function() onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.013),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.grey_2,
                ),
                child: Transform.scale(
                  scale: 0.6,
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ColorPalette.gradientPurple.createShader(bounds);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/$icon.svg',
                    ),
                  ),
                ),
              ),
              SizedBox(width: Get.width * 0.03),
              Text(
                content,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
