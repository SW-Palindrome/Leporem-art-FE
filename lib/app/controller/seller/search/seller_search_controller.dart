import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerSearchController extends GetxController {
  RxList<String> recentSearches = <String>[].obs;
  TextEditingController searchController = TextEditingController();
  Rx<bool> isSearching = false.obs;

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
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Failed to save recent seller searches: $e');
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
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Failed to load recent seller searches: $e');
    }
  }
}
