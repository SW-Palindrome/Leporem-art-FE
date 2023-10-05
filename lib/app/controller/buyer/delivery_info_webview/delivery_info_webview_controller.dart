import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/repositories/delivery_info_repository.dart';

class DeliveryInfoWebViewController extends GetxController {
  final DeliveryInfoRepository repository;
  late WebViewController webViewController;
  late String url;
  Rx<bool> isLoading = true.obs;

  DeliveryInfoWebViewController({required this.repository}) : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    updateWebViewController();
  }

  int get orderId => Get.arguments['order_id'];

  Future<void> updateWebViewController() async {
    url = await repository.fetchDeliveryInfoUrl(orderId);
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: (error) {
          Get.snackbar('오류', '택배사 배송조회 페이지를 불러오는데 실패했습니다.');
        }
      )
    );
    isLoading.value = false;
    update();
  }
}