import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/controllers/seller_item_detail_controller.dart';

class ItemEditController extends ItemCreateDetailController {
  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    titleController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.title;
    print(
        'titlecontroller: ${Get.find<SellerItemDetailController>().itemDetail.value.title}');
  }
}
