import 'package:get/get.dart';

import '../../controller/buyer/item_detail/buyer_item_detail_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/item_detail_repository.dart';

class BuyerItemDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerItemDetailController>(() {
      return BuyerItemDetailController(
          homeRepository: HomeRepository(apiClient: DioClient()),
          itemDetailRepository: ItemDetailRepository(apiClient: DioClient()));
    });
  }
}
