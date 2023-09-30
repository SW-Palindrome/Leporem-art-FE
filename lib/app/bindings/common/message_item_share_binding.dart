import 'package:get/get.dart';

import '../../controller/common/message_item_share/message_item_share_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/message_item_repository.dart';

class MessageItemShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MessageItemShareController(
        repository: MessageItemRepository(apiClient: DioClient())));
  }
}
