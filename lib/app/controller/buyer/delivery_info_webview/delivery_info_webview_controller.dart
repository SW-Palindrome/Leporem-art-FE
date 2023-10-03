import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeliveryInfoWebViewController extends GetxController {
  late WebViewController webViewController;
  final String url;

  DeliveryInfoWebViewController({required this.url});

  @override
  void onInit() async {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: (error) {
          Get.snackbar('오류', '택배사 배송조회 페이지를 불러오는데 실패했습니다.');
        },
      ));
  }
}