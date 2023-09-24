import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';
import '../provider/api.dart';
import '../provider/dio.dart';

class RecentItemRepository {
  final ApiClient apiClient;
  RecentItemRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<RecentItem>> fetchRecentItems() async {
    return await apiClient.fetchRecentItems();
  }

  Future<bool> deleteRecentItem(int itemId) async {
    return await apiClient.deleteRecentItem(itemId);
  }
}
