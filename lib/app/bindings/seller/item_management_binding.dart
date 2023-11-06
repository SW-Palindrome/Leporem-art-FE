import 'package:get/get.dart';

import '../../controller/seller/item_management/item_management_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/order_list_repository.dart';

class ItemManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemManagementController(
        repository: OrderListRepository(apiClient: DioClient())));
  }
}
