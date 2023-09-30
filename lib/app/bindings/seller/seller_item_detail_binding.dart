import 'package:get/get.dart';

import '../../controller/seller/item_detail/seller_item_detail_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/item_detail_repository.dart';

class SellerItemDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SellerItemDetailController(
        repository: ItemDetailRepository(apiClient: DioClient())));
  }
}
