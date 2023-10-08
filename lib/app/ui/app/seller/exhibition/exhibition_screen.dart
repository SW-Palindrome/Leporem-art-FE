import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/exhibition/exhibition_controller.dart';
import 'package:leporemart/app/ui/app/seller/exhibition/widgets/empty_exhibition_widgets.dart';
import '../../../theme/app_theme.dart';
import 'widgets/exhibition_list_widget.dart';

class ExhibitionScreen extends GetView<ExhibitionController> {
  const ExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기획전',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretenderd,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            if (controller.exhibitions.isEmpty)
              emptyExhibitionWidget()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return exhibitionListWidget(
                    controller.exhibitions[index].title,
                    controller.exhibitions[index].coverImage,
                    controller.exhibitions[index].seller,
                    controller.exhibitions[index].startDate,
                    controller.exhibitions[index].endDate,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24);
                },
                itemCount: controller.exhibitions.length,
              ),
          ],
        ),
      ),
    );
  }
}
