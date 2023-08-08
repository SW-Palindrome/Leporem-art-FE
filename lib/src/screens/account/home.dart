import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buyer_app.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isLoginProceed;
  const HomeScreen({super.key, required this.isLoginProceed});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild());
    return Container();
  }

  _onAfterBuild() {
    if (isLoginProceed) {
      Get.to(BuyerApp());
    }
    else {
      Get.to(LoginScreen());
    }
  }
}
