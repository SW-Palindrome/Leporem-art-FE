import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/item_delivery_edit/item_delivery_edit_controller.dart';
import 'package:leporemart/app/data/provider/dio.dart';

import '../../data/repositories/seller_item_delivery_edit_repository.dart';


class SellerItemDeliverEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SellerItemDeliveryEditController(repository: SellerItemDeliveryEditRepository(apiClient: DioClient())));
  }
}
