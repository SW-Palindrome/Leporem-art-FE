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
      List<Order> fetchedOrders = await _orderListRepository.fetchOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      throw ('Error fetching buyer order list in controller: $e');
    }
  }
}
