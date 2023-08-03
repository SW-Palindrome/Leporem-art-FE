import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class OrderListRepository {
  Future<List<BuyerOrder>> fetchBuyerOrders() async {
    try {
      final response = await DioSingleton.dio.get(
        '/buyers/orders/my',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      // 데이터를 변환하여 리스트로 생성

      // List<dynamic>형태인 response.data를 각각 인덱스로 접근해 Order.fromJson으로 변환
      final List<BuyerOrder> orders = List<BuyerOrder>.from(
          response.data.map((json) => BuyerOrder.fromJson(json)));
      return orders;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer order list in repository: $e');
    }
  }

  Future<List<SellerOrder>> fetchSellerOrders() async {
    try {
      final response = await DioSingleton.dio.get(
        '/sellers/orders/my',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      // 데이터를 변환하여 리스트로 생성

      // List<dynamic>형태인 response.data를 각각 인덱스로 접근해 Order.fromJson으로 변환
      final List<SellerOrder> orders = List<SellerOrder>.from(
          response.data.map((json) => SellerOrder.fromJson(json)));
      return orders;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer order list in repository: $e');
    }
  }

  Future<void> completeOrder(int orderId) async {
    try {
      print('orderId: $orderId');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/order-complete',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      throw ('Error fetching order complete list in repository: $e');
    }
  }

  Future<void> deliveryStartOrder(int orderId) async {
    try {
      print('orderId: $orderId');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/delivery-start',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      throw ('Error fetching delivery start list in repository: $e');
    }
  }

  Future<void> deliveryCompleteOrder(int orderId) async {
    try {
      print('orderId: $orderId');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/delivery-complete',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      throw ('Error fetching delivery complete in repository: $e');
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      print('orderId: $orderId');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/cancel',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      throw ('Error fetching cancel order list in repository: $e');
    }
  }
}