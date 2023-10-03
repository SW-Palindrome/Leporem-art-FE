import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/repositories/delivery_info_repository.dart';

class DeliveryInfoWebViewController extends GetxController {
  final DeliveryInfoRepository repository;
  late WebViewController webViewController;
  late String url;

  DeliveryInfoWebViewController({required this.repository}) : assert(repository != null);

  @override
  void onInit() async {
    super.onInit();
    url = 'http://info.sweettracker.co.kr/tracking/5?t_code=05&t_invoice=4541217496&t_key=uAyk561vd8r79J6rtdqj7Q';
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: (error) {
          Get.snackbar('오류', '택배사 배송조회 페이지를 불러오는데 실패했습니다.');
        },
      ));
  }

  int get orderId => int.parse(Get.arguments['order_id']);
}