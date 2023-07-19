import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';
import 'package:leporemart/src/widgets/plant_temperature.dart';
import 'package:video_player/video_player.dart';

class BuyerItemDetailScreen extends GetView<ItemDetailController> {
  const BuyerItemDetailScreen({Key? key}) : super(key: key);

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
              _itemTitle(),
              _itemThumbnail(),
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
                controller.itemDetail.isLiked
                    ? 'assets/icons/heart_fill.svg'
                    : 'assets/icons/heart_outline.svg',
                width: 30,
                colorFilter: ColorFilter.mode(
                    controller.itemDetail.isLiked
                        ? ColorPalette.purple
                        : ColorPalette.grey_4,
                    BlendMode.srcIn),
              ),
              SizedBox(width: 10),
              Text(
                '${controller.itemDetail.price.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    )}원',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.itemDetail.name,
            style: TextStyle(
              color: Color(0xff191f28),
              fontWeight: FontWeight.w600,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        controller.itemDetail.profileImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    controller.itemDetail.creator,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              PlantTemperature(temperature: controller.itemDetail.temperature),
            ],
          ),
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
            for (String imageUrl in controller.itemDetail.imagesUrl)
              Image.network(
                imageUrl,
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
                      for (int i = 0;
                          i < controller.itemDetail.imagesUrl.length;
                          i++)
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
                          color: controller.index.value ==
                                  controller.itemDetail.imagesUrl.length
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

  Container _categoryWidget(String category) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
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
    );
  }

  Padding _itemDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (String tag in controller.itemDetail.tags)
                    _categoryWidget(tag),
                ],
              ),
              Text(
                "잔여 ${controller.itemDetail.remainAmount}점",
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
          SizedBox(height: 16),
          Text(
            controller.itemDetail.description,
            style: TextStyle(
              color: Color(0xff191f28),
              fontWeight: FontWeight.w400,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}