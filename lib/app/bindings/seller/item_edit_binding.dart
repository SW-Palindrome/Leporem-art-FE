import 'package:get/get.dart';

import '../../controller/seller/item_edit/item_edit_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/item_create_repository.dart';

class ItemEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemEditController(
        repository: ItemCreateRepository(apiClient: DioClient())));
  }
}
