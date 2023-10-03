import 'package:get/get.dart';

import '../../controller/buyer/delivery_info_webview/delivery_info_webview_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/delivery_info_repository.dart';

class DeliveryInfoWebViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
        DeliveryInfoWebViewController(repository: DeliveryInfoRepository(apiClient: DioClient()))
    );
  }
}