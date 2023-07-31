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
    descriptionController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.description;
    priceController.text = Get.find<SellerItemDetailController>()
        .itemDetail
        .value
        .price
        .toString()
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    ;
    widthController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.width ??
            ''.toString();
    depthController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.depth ??
            ''.toString();
    heightController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.height ??
            ''.toString();
    amount.value =
        Get.find<SellerItemDetailController>().itemDetail.value.currentAmount;
    List<String> categoryList =
        Get.find<SellerItemDetailController>().itemDetail.value.category;
    for (int i = 0; i < categoryList.length; i++) {
      for (int j = 0; j < categoryTypes.length; j++) {
        if (categoryList[i] == categoryTypes[j]) {
          print(
              'categoryList[i] : categoryList[$i] / categoryTypes[j] : categoryTypes[$j]');
          selectedCategoryType[j] = true;
          continue;
        }
      }
    }
  }
}
