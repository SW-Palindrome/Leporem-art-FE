import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';
import 'package:video_player/video_player.dart';

class ItemDetail extends GetView<ItemDetailController> {
  const ItemDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.buyerItemDetailAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemThumbnail(),
              _itemTitle(),
              _itemDescription(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _itemBottomNavigationBar(),
    );
  }

  Container _itemBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 30,
                colorFilter:
                    ColorFilter.mode(ColorPalette.purple, BlendMode.srcIn),
              ),
              SizedBox(width: 10),
              Text(
                "10,000원",
                style: TextStyle(
                  color: Color(0xff191f28),
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          NextButton(
            text: "채팅하기",
            value: true,
            onTap: () {},
            width: Get.width * 0.35,
          ),
        ],
      ),
    );
  }

  Container _itemTitle() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorPalette.grey_2,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    'https://dimg.donga.com/wps/NEWS/IMAGE/2021/01/17/104953245.2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                "홍준식(준식이가준비한식사)",
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "매너온도 추가",
                style: TextStyle(
                  color: Color(0xfff04452),
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "가로등 빛 받은 나뭇잎 컵",
                style: TextStyle(
                  color: Color(0xff191f28),
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "잔여 3점",
                style: TextStyle(
                  color: Color(0xff594bf8),
                  fontWeight: FontWeight.w400,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _categoryWidget('컵'),
              _categoryWidget('머그컵'),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemThumbnail() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: Get.width,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              controller.changeIndex(index);
            },
          ),
          items: [
            Image.network(
              'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
              fit: BoxFit.cover,
            ),
            Image.network(
              'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
              fit: BoxFit.cover,
            ),
            Image.network(
              'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/vendor_inventory/7ee6/f53d1c2ed2ed6746c5f394e232c429cc62401523cf894e715cca84605c04.jpg',
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: controller.togglePlay,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(controller.videoPlayerController),
                      Obx(
                        () => AnimatedOpacity(
                          opacity: controller.isIconVisible.value ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: controller.isPlaying.value
                              ? Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.pause,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: controller.toggleVolume,
                    child: Obx(
                      () => Icon(
                        controller.isMuted.value
                            ? Icons.volume_off
                            : Icons.volume_up,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.index.value == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.index.value == 3
                              ? ColorPalette.purple
                              : ColorPalette.purple.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding _categoryWidget(String category) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: ColorPalette.grey_3,
          ),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: Color(0xff191f28),
              fontWeight: FontWeight.w400,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Container _itemDescription() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        "#감성 #채색 #유화 #도자기 #컵\n가로등 빛 받은 나뭇잎을 표현해보았습니다.\n우리 소마 생활도 항상 빛과 가득하길.",
        style: TextStyle(
          color: Color(0xff191f28),
          fontWeight: FontWeight.w400,
          fontFamily: "PretendardVariable",
          fontStyle: FontStyle.normal,
          fontSize: 13.0,
        ),
      ),
    );
  }
}
