import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/buyer_app.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/controllers/seller_profile_controller.dart';
import 'package:leporemart/src/controllers/seller_profile_edit_controller.dart';
import 'package:leporemart/src/screens/seller/item_management_screen.dart';
import 'package:leporemart/src/screens/seller/profile_edit_screen.dart';
import 'package:leporemart/src/seller_app.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/plant_temperature.dart';

class SellerProfileScreen extends GetView<SellerProfileController> {
  SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!controller.initialized) {
      return CircularProgressIndicator();
    }
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            _titleRow(),
            SizedBox(height: Get.height * 0.03),
            _profileRow(),
            Divider(color: ColorPalette.grey_2, thickness: 10),
            _menuColumn(
              title: '작품 관리',
              contents: ['판매 관리'],
              icons: ['list', 'heart_outline', 'history'],
              onTaps: [
                () {
                  Get.to(ItemManagementScreen());
                },
                () {},
                () {},
              ],
            ),
            Divider(color: ColorPalette.grey_2, thickness: 10),
            _menuColumn(
              title: '커뮤니티 관리',
              contents: ['차단 목록'],
              icons: ['block'],
              onTaps: [
                () {},
              ],
            ),
            Divider(color: ColorPalette.grey_2, thickness: 10),
            _menuColumn(
              title: 'SNS 연동',
              contents: ['인스타그램 연동'],
              icons: ['instagram'],
              onTaps: [
                () {},
              ],
            ),
            Divider(color: ColorPalette.grey_2, thickness: 10),
            _menuColumn(
              title: '기타 기능',
              contents: ['요금 플랜 가입하기', '포트폴리오'],
              icons: ['plan', 'portfolio'],
              onTaps: [
                () {},
                () {},
              ],
            ),
          ],
        ),
      ),
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
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/setting.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                ColorPalette.grey_4,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
    );
  }

  _profileRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Get.width * 0.1),
                    child: Image.network(
                      controller.sellerProfile.value.profileImage,
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
                        Get.to(SellerProfileEditScreen());
                        Get.put(SellerProfileEditController());
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
                      '판매자',
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
                    controller.sellerProfile.value.nickname,
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
              GestureDetector(
                onTap: () async {
                  MyBottomNavigationbarController.to.changeBuyerIndex(4);
                  Get.offAll(() => BuyerApp());
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
                        '구매자 전환',
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
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '성장률',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: PlantTemperature(
                  temperature: controller.sellerProfile.value.temperature,
                  type: PlantTemperatureType.text,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: PlantTemperature(
                    temperature: controller.sellerProfile.value.temperature,
                    type: PlantTemperatureType.image),
              ),
              Spacer(),
              Container(
                width: Get.width * 0.35,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPalette.grey_1,
                ),
                child: Column(
                  children: [
                    Text(
                      '재구매희망률',
                      style: TextStyle(
                        color: ColorPalette.grey_6,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${controller.sellerProfile.value.retentionRate.toInt().toString()}%',
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: Get.width * 0.35,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPalette.grey_1,
                ),
                child: Column(
                  children: [
                    Text(
                      '거래횟수',
                      style: TextStyle(
                        color: ColorPalette.grey_6,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${controller.sellerProfile.value.totalTransaction}회',
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  _menuColumnItem({
    required String content,
    required String icon,
    required Function() onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.013),
      child: GestureDetector(
        onTap: onTap,
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
                child: icon == 'instagram'
                    ? Image.asset(
                        'assets/icons/$icon.png',
                      )
                    : ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return ColorPalette.gradientPurple
                              .createShader(bounds);
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
    );
  }
}
