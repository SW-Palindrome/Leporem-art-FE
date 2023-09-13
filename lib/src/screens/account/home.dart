import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

import '../../buyer_app.dart';
import '../../configs/login_config.dart';
import '../../controllers/message_controller.dart';
import '../../utils/chatting_socket_singleton.dart';
import 'login_screen.dart';

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
      await Get.putAsync(() => MessageController().init());
      ChattingSocketSingleton();
      FlutterNativeSplash.remove();
      Get.offAll(BuyerApp());
    } else {
      FlutterNativeSplash.remove();
      Get.offAll(LoginScreen());
      Get.put(NicknameController());
    }
  }
}
