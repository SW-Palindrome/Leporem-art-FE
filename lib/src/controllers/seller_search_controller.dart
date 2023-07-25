import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerSearchController extends GetxController {
  RxList<String> recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }

  void addRecentSearch(String query) {
    if (recentSearches.length >= 20) {
      recentSearches.removeLast();
    }
    recentSearches.remove(query);
    recentSearches.insert(0, query);
    saveRecentSearches();
  }

  void clearRecentSearches() {
    recentSearches.clear();
    saveRecentSearches();
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
    saveRecentSearches();
  }

  void saveRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recent_seller_searches', recentSearches);
    } catch (e) {
      print('Failed to save recent seller searches: $e');
    }
  }

  void loadRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList('recent_seller_searches');
      if (searches != null) {
        recentSearches.assignAll(searches);
      }
    } catch (e) {
      print('Failed to load recent seller searches: $e');
    }
  }
}
