import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/repositories/seller_item_delivery_edit_repository.dart';

class SellerItemDeliveryEditController extends GetxController {
  final SellerItemDeliveryEditRepository repository;
  TextEditingController invoiceNumber = TextEditingController();
  Rx<String> deliveryCompany = Rx<String>('');

  SellerItemDeliveryEditController({required this.repository}) : assert(repository != null);

  final List<String> deliveryCompanyList = [
        'CJ대한통운',
        '한진택배',
        '롯데택배',
        '우체국택배',
        '로젠택배',
        '일양로지스',
        'EMS',
        'DHL',
        '한덱스',
        'FedEx',
        'UPS',
        'USPS',
        '대신택배',
        '경동택배',
        '합동택배',
        'CU 편의점택배',
        'GS Postbox 택배',
        'TNT Express',
        '한의사랑택배',
        '천일택배',
        '건영택배',
  ];

  @override
  void onInit() {
      deliveryCompany.value = deliveryCompanyList.first;
      super.onInit();
  }

  Future<void> updateDeliveryInfo() async {
    repository.updateDeliveryInfo(orderId, deliveryCompany.string, invoiceNumber.text);
  }

  int get orderId => Get.arguments['order_id'];
}