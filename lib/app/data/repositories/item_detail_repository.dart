import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/item_detail.dart';
import '../provider/api.dart';
import '../provider/dio.dart';

class ItemDetailRepository {
  final ApiClient apiClient;
  ItemDetailRepository({required this.apiClient}) : assert(apiClient != null);

  Future<BuyerItemDetail?> fetchBuyerItemDetail(int itemID) async {
    return await apiClient.fetchBuyerItemDetail(itemID);
  }

  Future<SellerItemDetail?> fetchSellerItemDetail(int itemID) async {
    return await apiClient.fetchSellerItemDetail(itemID);
  }

  Future<dynamic> increaseAmount(int itemId) async {
    return await apiClient.increaseAmount(itemId);
  }

  Future<dynamic> decreaseAmount(int itemId) async {
    return await apiClient.decreaseAmount(itemId);
  }
}
