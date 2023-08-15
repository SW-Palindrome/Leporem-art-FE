import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/buyer_home_controller.dart';
import 'package:leporemart/src/controllers/buyer_item_creator_controller.dart';
import 'package:leporemart/src/controllers/seller_home_controller.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get('/items/filter',
          queryParameters: {
            'page': page,
            'search': keyword,
            'ordering': ordering,
            'category': category,
            'price': price,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ));
      //rseponse의 message가 EmptyPage라면 데이터가 없는 것이므로 빈 리스트를 반환, 또한 pagination용 요청이면 currentPage를 1 감소시킴
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<BuyerHomeController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer home items in repository: $e');
    }
  }

  Future<List<BuyerHomeItem>> fetchGuestHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    try {
      final response = await DioSingleton.dio.get(
        '/items/guest',
        queryParameters: {
          'page': page,
          'search': keyword,
          'ordering': ordering,
          'category': category,
          'price': price,
        },
      );
      //rseponse의 message가 EmptyPage라면 데이터가 없는 것이므로 빈 리스트를 반환, 또한 pagination용 요청이면 currentPage를 1 감소시킴
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<BuyerHomeController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer home items in repository: $e');
    }
  }

  Future<List<BuyerHomeItem>> fetchBuyerCreatorItems(
    int page, {
    String? nickname,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/items/filter',
        queryParameters: {
          'page': page,
          'nickname': nickname,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<BuyerItemCreatorController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching item creators in repository: $e');
    }
  }

  Future<List<SellerHomeItem>> fetchSellerHomeItems(
    int page, {
    String? nickname,
    String? ordering,
    String? keyword,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/items/filter',
        queryParameters: {
          'page': page,
          'nickname': nickname,
          'ordering': ordering,
          'search': keyword,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];
      Get.find<SellerHomeController>().totalCount.value =
          data['list']['total_count'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<SellerHomeItem> items =
          itemsData.map((json) => SellerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching seller home items in repository: $e');
    }
  }
}
