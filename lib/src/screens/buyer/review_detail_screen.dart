import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/review_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class ReviewDetailScreen extends GetView<ReviewController> {
  const ReviewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '가로등 빛 받은 나뭇잎 컵',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _mediaInput(),
              SizedBox(height: 40),
              _descriptionInput(),
              Spacer(),
              Obx(
                () => NextButton(
                  text: '후기 작성하기',
                  value: controller.description.value != '',
                  onTap: () {
                    print('후기 작성');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mediaInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              '사진을 올려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.bold,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '(선택)',
              style: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.bold,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
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
                  controller.isImagesLoading[i] == true
                      ? SizedBox(
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                          child: Center(
                            child: SizedBox(
                              height: Get.width * 0.1,
                              width: Get.width * 0.1,
                              child: CircularProgressIndicator(
                                color: ColorPalette.grey_3,
                              ),
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              height: Get.width * 0.2,
                              width: Get.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: FileImage(controller.images[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(i),
                                child: CircleAvatar(
                                  backgroundColor: ColorPalette.black,
                                  radius: 10,
                                  child: SvgPicture.asset(
                                    'assets/icons/cancle.svg',
                                    colorFilter: ColorFilter.mode(
                                      ColorPalette.white,
                                      BlendMode.srcIn,
                                    ),
                                    width: 20,
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
      ],
    );
  }

  _descriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '상세한 후기를 작성해주세요.',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.bold,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
          child: TextField(
            maxLength: 255,
            maxLines: null,
            controller: controller.descriptionController,
            onChanged: (value) {
              controller.description.value = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '구매하신 작품의 후기를 남겨주시면 다른 구매자들에게도 도움이 됩니다.',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
