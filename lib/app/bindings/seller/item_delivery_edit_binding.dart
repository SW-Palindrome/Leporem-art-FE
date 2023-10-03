import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/item_delivery_edit/item_delivery_edit_controller.dart';


class SellerItemDeliverEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SellerItemDeliveryEditController());
  }
}
