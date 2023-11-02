import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_preview_controller.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import 'widgets/exhibition_widget.dart';
import 'widgets/item_widget.dart';
import 'widgets/seller_widget.dart';

class ExhibitionPreviewScreen extends GetView<ExhibitionPreviewController> {
  const ExhibitionPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        isWhite: true,
        appBarType: AppBarType.backAppBar,
        title: '기획전 미리보기',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: Obx(
        () {
          if (controller.isLoading.value == true) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  exhibitionWidget(),
                  sellerWidget(),
                  itemWidget(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
