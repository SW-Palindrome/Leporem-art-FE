import 'package:get/get.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  RxList<Item> items = <Item>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final List<Item> fetchedItems = await _homeRepository.fetchItems();
      items.assignAll(fetchedItems);
    } catch (e) {
      // 에러 처리
      print('Error fetching items in controller: $e');
    }
  }
}
