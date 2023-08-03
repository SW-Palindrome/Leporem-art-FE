import 'package:get/get.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/repositories/order_list_repository.dart';

class BuyerOrderListController extends GetxController {
  final OrderListRepository _orderListRepository = OrderListRepository();

  RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      List<Order> fetchedOrders = await _orderListRepository.fetchBuyerOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      print('Error fetching buyer order list in controller: $e');
    }
  }

  Future<void> cancel(int orderId) async {
    try {
      await _orderListRepository.cancelOrder(orderId);
    } catch (e) {
      print('Error fetching buyer order cancel in controller: $e');
    }
  }
}