import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class OrderListRepository {
  Future<List<Order>> fetchOrders() async {
    try {
      print('fetching buyer order list');
      final response = await DioSingleton.dio.get(
        '/buyers/orders/my',
        options: Options(
          headers: {"Authorization": "Palindrome Leporemart33!"},
        ),
      );
      // 데이터를 변환하여 리스트로 생성

      // List<dynamic>형태인 response.data를 각각 인덱스로 접근해 Order.fromJson으로 변환
      print('response.data: ${response.data.length}');
      final List<Order> orders =
          List<Order>.from(response.data.map((json) => Order.fromJson(json)));
      print('order.length: ${orders.length}');
      return orders;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer order list in repository: $e');
    }
  }
}
