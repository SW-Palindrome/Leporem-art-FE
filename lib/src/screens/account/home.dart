import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/seller_app.dart';

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
    return Container();
  }

  _onAfterBuild() async {
    if (isLoginProceed) {
      await Get.putAsync(() => MessageController().init());
      ChattingSocketSingleton();
      Get.offAll(BuyerApp());
    } else {
      Get.offAll(LoginScreen());
      Get.put(NicknameController());
    }
  }
}
