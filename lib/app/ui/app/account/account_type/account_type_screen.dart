import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/account/account_type/account_type_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../common/home/home.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';

class AccountTypeScreen extends GetView<AccountTypeController> {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.none,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Text(
                "가입 유형을 선택해주세요",
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.selectType(0);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: controller.typeList[0]
                            ? ColorPalette.purple
                            : ColorPalette.grey_3,
                      ),
                      color: controller.typeList[0]
                          ? ColorPalette.purple.withAlpha(10)
                          : ColorPalette.white,
                    ),
                    child: Text(
                      "구매자",
                      style: TextStyle(
                        color: controller.typeList[0]
                            ? ColorPalette.purple
                            : ColorPalette.grey_6,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.selectType(1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: controller.typeList[1]
                            ? ColorPalette.purple
                            : ColorPalette.grey_3,
                      ),
                      color: controller.typeList[1]
                          ? ColorPalette.purple.withAlpha(10)
                          : ColorPalette.white,
                    ),
                    child: Text(
                      "판매자",
                      style: TextStyle(
                        color: controller.typeList[1]
                            ? ColorPalette.purple
                            : ColorPalette.grey_6,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => controller.typeList.value.first
                    ? NextButton(
                        text: "공예쁨 시작하기",
                        value: controller.isSelect.value,
                        onTap: () {
                          logAnalytics(name: 'signup', parameters: {
                            'step': 'account_type',
                            'action': 'buyer'
                          });
                          Get.offAll(HomeScreen(isLoginProceed: true));
                        },
                      )
                    : NextButton(
                        text: "다음",
                        value: controller.isSelect.value,
                        onTap: () {
                          logAnalytics(name: 'signup', parameters: {
                            'step': 'account_type',
                            'action': 'seller'
                          });
                          Get.toNamed(Routes.EMAIL);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
