import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class ItemCreateDetailScreen extends GetView<ItemCreateDetailController> {
  const ItemCreateDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '작품 등록',
        onTapLeadingIcon: () {
          Get.back();
        },
        isWhite: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: ColorPalette.grey_1,
        child: Column(
          children: [
            _mediaInput(),
            // _categoryInput(),
            // _titleInput(),
            // _descriptionInput(),
            // _sizeInput(),
            // _sellTypeInput(),
          ],
        ),
      ),
    );
  }

  Widget _mediaInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Text(
                '사진과 플롭영상을 올려주세요.',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '(최소 3장)',
                style: TextStyle(
                  color: ColorPalette.grey_4,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => controller.selectImages(),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: ColorPalette.grey_4,
                    radius: Radius.circular(5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                        ),
                        Positioned(
                          top: Get.height * 0.025,
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg',
                            colorFilter: ColorFilter.mode(
                              ColorPalette.grey_4,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Get.height * 0.025,
                          child: Text(
                            '${controller.images.length}/10',
                            style: TextStyle(
                              color: ColorPalette.grey_6,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PretendardVariable",
                              fontStyle: FontStyle.normal,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                for (var i = 0; i < controller.images.length; i++)
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(controller.images[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(i),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Obx(
          () => Row(
            children: [
              GestureDetector(
                onTap: () => controller.selectVideo(),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorPalette.grey_4,
                  radius: Radius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                      ),
                      Positioned(
                        top: Get.height * 0.025,
                        child: SvgPicture.asset(
                          'assets/icons/shorts.svg',
                          colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Get.height * 0.025,
                        child: Text(
                          '${controller.videos.length}/1',
                          style: TextStyle(
                            color: ColorPalette.grey_6,
                            fontWeight: FontWeight.w600,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (var i = 0; i < controller.videos.length; i++)
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: Get.width * 0.2,
                      width: Get.width * 0.2,
                      child: Image.memory(
                        controller.thumbnail.value!,
                        fit: BoxFit.cover,
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () => controller.removeVideo(i),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
