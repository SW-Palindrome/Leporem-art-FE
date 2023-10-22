import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../controller/common/message_item_order_info/message_item_order_info_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/message_item_repository.dart';

class MessageItemOrderInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MessageItemOrderInfoController(
        repository: MessageItemRepository(apiClient: DioClient())));
  }
}
