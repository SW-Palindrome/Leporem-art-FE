import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../controller/buyer/delivery_info_webview/delivery_info_webview_controller.dart';
import '../../widgets/my_app_bar.dart';

class DeliveryInfoWebViewScreen extends GetView<DeliveryInfoWebViewController> {
  DeliveryInfoWebViewScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}