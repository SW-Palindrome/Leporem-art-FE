import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leporemart/app/routes/app_pages.dart';

import '../../../../configs/login_config.dart';
import '../../../../configs/firebase_config.dart';
import '../../../../controller/common/message/message_controller.dart';
import '../../../../data/provider/dio.dart';
import '../../../../data/repositories/item_detail_repository.dart';
import '../../../../data/repositories/message_repository.dart';
import '../../../../data/repositories/order_list_repository.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../../utils/chatting_socket_singleton.dart';
import '../../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  final bool isLoginProceed;
  const HomeScreen({super.key, required this.isLoginProceed});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild());
    return Container(
      color: ColorPalette.grey_1,
      child: Center(
        child: CircularProgressIndicator(
          color: ColorPalette.purple,
        ),
      ),
    );
  }

  _onAfterBuild() async {
    if (isLoginProceed) {
      await getLoginProceed();
      await Get.putAsync(() => MessageController(
              messageRepository: MessageRepository(apiClient: DioClient()),
              itemDetailRepository:
                  ItemDetailRepository(apiClient: DioClient()),
              orderListRepository: OrderListRepository(apiClient: DioClient()),
              profileRepository: ProfileRepository(apiClient: DioClient()))
          .init());

      registerFcmDevice();
      ChattingSocketSingleton();
      FlutterNativeSplash.remove();
      Get.toNamed(Routes.BUYER_APP);
    } else {
      FlutterNativeSplash.remove();
      Get.toNamed(Routes.LOGIN);
    }
  }
}
