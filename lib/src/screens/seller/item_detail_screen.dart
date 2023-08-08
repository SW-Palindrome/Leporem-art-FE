import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_edit_controller.dart';
import 'package:leporemart/src/controllers/seller_item_detail_controller.dart';
import 'package:leporemart/src/screens/seller/item_edit_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/datetime_to_string.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';
import 'package:leporemart/src/widgets/plant_temperature.dart';
import 'package:video_player/video_player.dart';

class SellerItemDetailScreen extends GetView<SellerItemDetailController> {
  const SellerItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.sellerItemDetailAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
        onTapSecondActionIcon: () {
          logAnalytics(
              name: "enter_item_edit",
              parameters: {"item_id": controller.itemDetail.value.id});
          Get.to(ItemEditScreen());
          Get.put(ItemEditController());
        },
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _itemTitle(),
                      _itemThumbnail(),
                      _itemDescription(),
                      if (controller.itemDetail.value.reviews.isNotEmpty)
                        _itemReviewList(),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: _itemBottomNavigationBar(),
    );
  }

  _itemBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(
                () => Text(
                  '${controller.itemDetail.value.price.toString().replaceAllMapped(
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
              ),
            ],
          ),
          NextButton(
            text: "끌어올리기",
            value: true,
            onTap: () {},
            width: Get.width * 0.4,
          ),
        ],
      ),
    );
  }

  _itemTitle() {
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
            controller.itemDetail.value.title,
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
                      child: CachedNetworkImage(
                        imageUrl: controller.itemDetail.value.profileImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    controller.itemDetail.value.nickname,
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
              PlantTemperature(
                  temperature: controller.itemDetail.value.temperature ?? 0),
            ],
          ),
        ],
      ),
    );
  }

  _itemThumbnail() {
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
            CachedNetworkImage(
              imageUrl: controller.itemDetail.value.thumbnailImage,
              fit: BoxFit.cover,
              width: Get.width,
              height: Get.width,
            ),
            for (String imageUrl in controller.itemDetail.value.images)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.width,
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
                          i < controller.itemDetail.value.images.length + 1;
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
                                  controller.itemDetail.value.images.length + 1
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

  _categoryWidget(String category) {
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

  _itemDescription() {
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
                  for (String tag in controller.itemDetail.value.category)
                    _categoryWidget(tag),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      logAnalytics(name: "decrease_amount", parameters: {
                        "item_id": controller.itemDetail.value.id
                      });
                      controller.decreaseAmount();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.grey_2,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/minus.svg',
                        width: 12,
                        height: 12,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_6, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Obx(
                    () => Text(
                      "잔여 ${controller.itemDetail.value.currentAmount}점",
                      style: TextStyle(
                        color: Color(0xff594bf8),
                        fontWeight: FontWeight.w400,
                        fontFamily: "PretendardVariable",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      logAnalytics(name: "increase_amount", parameters: {
                        "item_id": controller.itemDetail.value.id
                      });
                      controller.increaseAmount();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.grey_2,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/plus.svg',
                        width: 12,
                        height: 12,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_6, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            controller.itemDetail.value.description,
            style: TextStyle(
              color: Color(0xff191f28),
              fontWeight: FontWeight.w400,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 13.0,
            ),
          ),
          SizedBox(height: 16),
          if (controller.itemDetail.value.width != null &&
              controller.itemDetail.value.height != null &&
              controller.itemDetail.value.depth != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.grey_2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '작품 크기',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '가로 ${controller.itemDetail.value.width}cm',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/cancel.svg',
                        width: 10,
                        height: 10,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.black, BlendMode.srcIn),
                      ),
                      Text(
                        '세로 ${controller.itemDetail.value.depth}cm',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/cancel.svg',
                        width: 10,
                        height: 10,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.black, BlendMode.srcIn),
                      ),
                      Text(
                        '높이 ${controller.itemDetail.value.height}cm',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  _itemReviewList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.itemDetail.value.reviews.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorPalette.grey_2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.itemDetail.value.reviews[index].writer,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretenderd,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    datetimeToString(controller
                        .itemDetail.value.reviews[index].writeDateTime),
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  for (int i = 0;
                      i <
                          int.parse(controller
                              .itemDetail.value.reviews[index].rating[0]);
                      i++)
                    SvgPicture.asset(
                      'assets/icons/star_fill.svg',
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                          ColorPalette.yellow, BlendMode.srcIn),
                    ),
                  for (int i = int.parse(
                          controller.itemDetail.value.reviews[index].rating[0]);
                      i < 5;
                      i++)
                    SvgPicture.asset(
                      'assets/icons/star_fill.svg',
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                          ColorPalette.grey_3, BlendMode.srcIn),
                    ),
                  SizedBox(width: 4),
                  Text(
                    controller.itemDetail.value.reviews[index].rating,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Text(
                controller.itemDetail.value.reviews[index].comment,
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretenderd,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
