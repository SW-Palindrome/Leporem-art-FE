import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/common/notice/widgets/notice_widget.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

import '../../../../controller/common/notice/notice_controller.dart';
import '../../../theme/app_theme.dart';
import 'widgets/empty_notice_widget.dart';

class NoticeScreen extends GetView<NoticeController> {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '알림',
        onTapLeadingIcon: () {
          Get.back();
        },
        actions: [
          GestureDetector(
            onTap: () async {
              await controller.removeNotices();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                'assets/icons/trash.svg',
                width: 24,
                height: 24,
                colorFilter:
                    ColorFilter.mode(ColorPalette.grey_6, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.notices.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return noticeWidget(index);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: controller.notices.length),
                )
              : emptyNoticeWidget(),
        ),
      ),
    );
  }
}
