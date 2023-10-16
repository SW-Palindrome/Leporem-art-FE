import 'package:get/get.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/repositories/order_list_repository.dart';

class ItemManagementController extends GetxController {
  final OrderListRepository _orderListRepository = OrderListRepository();

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
      List<SellerOrder> fetchedOrders =
          await _orderListRepository.fetchSellerOrders();
      orders.assignAll(fetchedOrders);
      isLoading.value = false;
    } catch (e) {
      print('Error fetching buyer order list in controller: $e');
    }
  }

  Future<void> deliveryStart(int orderId) async {
    try {
      await _orderListRepository.deliveryStartOrder(orderId);
      await fetch();
    } catch (e) {
      print('Error fetching order delivery start in controller: $e');
    }
  }

  Future<void> deliveryComplete(int orderId) async {
    try {
      await _orderListRepository.deliveryCompleteOrder(orderId);
      await fetch();
    } catch (e) {
      print('Error fetchin gorder delivery complete in controller: $e');
    }
  }

  Future<void> cancel(int orderId) async {
    try {
      await _orderListRepository.cancelOrder(orderId);
      await fetch();
    } catch (e) {
      print('Error fetching seller order cancel in controller: $e');
    }
  }
}
