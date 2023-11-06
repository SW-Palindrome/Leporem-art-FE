import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/order.dart';
import '../../../data/repositories/order_list_repository.dart';

class OrderListController extends GetxController {
  final OrderListRepository repository;
  OrderListController({required this.repository}) : assert(repository != null);

  RxList<Order> orders = <Order>[].obs;
  Rx<bool> isLoading = false.obs;

  Order get currentOrder => orders.firstWhere((order) => order.id == Get.arguments['order_id']);

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      isLoading.value = true;
      List<Order> fetchedOrders = await repository.fetchBuyerOrders();
      orders.assignAll(fetchedOrders);
      isLoading.value = false;
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching buyer order list in controller: $e');
    }
  }

  Future<void> cancel(int orderId) async {
    try {
      await repository.cancelOrder(orderId);
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching buyer order cancel in controller: $e');
    }
  }
}
