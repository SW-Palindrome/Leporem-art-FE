import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';

class ItemDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemDetailController());
  }
}
