import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/exhibition/seller_exhibition_controller.dart';
import 'package:leporemart/app/ui/app/seller/exhibition/widgets/empty_exhibition_widgets.dart';
import '../../../theme/app_theme.dart';
import 'widgets/exhibition_carousel_widget.dart';

class SellerExhibitionScreen extends GetView<SellerExhibitionController> {
  const SellerExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '전시전',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontFamily: FontPalette.pretendard,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 24),
              if (controller.exhibitions.isEmpty)
                emptyExhibitionWidget()
              else
                exhibitionCarouselWidget()
            ],
          ),
        ),
      ),
    );
  }
}
