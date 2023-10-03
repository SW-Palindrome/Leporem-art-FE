import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import '../provider/api.dart';
import '../provider/dio.dart';

class OrderListRepository {
  final ApiClient apiClient;
  OrderListRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<BuyerOrder>> fetchBuyerOrders() async {
    return apiClient.fetchBuyerOrders();
  }

  Future<List<SellerOrder>> fetchSellerOrders() async {
    return apiClient.fetchSellerOrders();
  }

  Future<void> deliveryStartOrder(int orderId) async {
    return apiClient.deliveryStartOrder(orderId);
  }

  Future<void> deliveryCompleteOrder(int orderId) async {
    return apiClient.deliveryCompleteOrder(orderId);
  }

  Future<void> cancelOrder(int orderId) async {
    return apiClient.cancelOrder(orderId);
  }

  Future<OrderInfo> fetchOrder(int orderId) async {
    return apiClient.fetchOrder(orderId);
  }
}
