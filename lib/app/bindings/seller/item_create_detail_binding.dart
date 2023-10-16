import 'package:get/get.dart';

import '../../controller/seller/item_create_detail/item_create_detail_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/item_create_repository.dart';

class ItemCreateDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemCreateDetailController(
        repository: ItemCreateRepository(apiClient: DioClient())));
  }
}
