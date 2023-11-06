import 'package:get/get.dart';

import '../../controller/buyer/order_list/order_list_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/order_list_repository.dart';

class OrderListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderListController(
        repository: OrderListRepository(apiClient: DioClient())));
  }
}
