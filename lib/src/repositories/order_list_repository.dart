import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/order.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListRepository {
  Future<List<BuyerOrder>> fetchBuyerOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/buyers/orders/my',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/sellers/orders/my',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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

  Future<void> deliveryStartOrder(int orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/delivery-start',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/delivery-complete',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.post(
        '/orders/$orderId/cancel',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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

class OrderInfoRepository {
  Future<OrderInfo> fetch(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await DioSingleton.dio.get(
      '/orders/$orderId',
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return OrderInfo.fromJson(response.data);
  }
}
