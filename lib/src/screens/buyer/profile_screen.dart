import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _titleRow(),
          SizedBox(height: Get.height * 0.03),
          _profileRow(),
          Divider(color: ColorPalette.grey_2, thickness: 10),
          _menuColumn(
            title: '작품관리',
            contents: ['주문 내역', '관심 작품', '최근 본 작품'],
            icons: ['list', 'heart_outline', 'history'],
          ),
          Divider(color: ColorPalette.grey_2, thickness: 10),
          _menuColumn(
            title: '커뮤니티 관리',
            contents: ['팔로잉 목록', '차단 목록'],
            icons: ['followers', 'block'],
          ),
          Divider(color: ColorPalette.grey_2, thickness: 10),
          _menuColumn(
            title: '판매자 인증',
            contents: ['학교 이메일 인증'],
            icons: ['mail'],
          ),
        ],
      ),
    );
  }

  _titleRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Get.width * 0.1),
                child: Image.network(
                  'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
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
                '이름',
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
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorPalette.grey_2,
              ),
              child: Row(
                children: [
                  Text(
                    '판매자로 바꾸기',
                    style: TextStyle(
                      color: ColorPalette.grey_7,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
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
            ),
        ],
      ),
    );
  }

  _menuColumnItem({required String content, required String icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.013),
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
    );
  }
}