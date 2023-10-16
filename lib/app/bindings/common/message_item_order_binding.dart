import 'package:get/get.dart';

import '../../controller/common/message_item_order/message_item_order_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/message_item_repository.dart';

class MessageItemOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MessageItemOrderController(
        repository: MessageItemRepository(apiClient: DioClient())));
  }
}
