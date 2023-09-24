import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/order.dart';
import '../../../data/repositories/order_list_repository.dart';

class ItemManagementController extends GetxController {
  final OrderListRepository repository;
  ItemManagementController({required this.repository})
      : assert(repository != null);

  RxList<SellerOrder> orders = <SellerOrder>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      isLoading.value = true;
      List<SellerOrder> fetchedOrders = await repository.fetchSellerOrders();
      orders.assignAll(fetchedOrders);
      isLoading.value = false;
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching buyer order list in controller: $e');
    }
  }

  Future<void> deliveryStart(int orderId) async {
    try {
      await repository.deliveryStartOrder(orderId);
      await fetch();
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching order delivery start in controller: $e');
    }
  }

  Future<void> deliveryComplete(int orderId) async {
    try {
      await repository.deliveryCompleteOrder(orderId);
      await fetch();
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetchin gorder delivery complete in controller: $e');
    }
  }

  Future<void> cancel(int orderId) async {
    try {
      await repository.cancelOrder(orderId);
      await fetch();
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching seller order cancel in controller: $e');
    }
  }
}
