import 'package:get/get.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/repositories/order_list_repository.dart';

class ItemManagementController extends GetxController {
  final OrderListRepository _orderListRepository = OrderListRepository();

  RxList<SellerOrder> orders = <SellerOrder>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      List<SellerOrder> fetchedOrders =
          await _orderListRepository.fetchSellerOrders();
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
