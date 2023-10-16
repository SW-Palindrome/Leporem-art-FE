import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentItemRepository {
  Future<List<RecentItem>> fetchRecentItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/items/viewed',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      final List<dynamic> itemsData = data['items'];
      final List<RecentItem> items =
          itemsData.map((json) => RecentItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      throw ('Error fetching recent items in repository: $e');
    }
  }
}
