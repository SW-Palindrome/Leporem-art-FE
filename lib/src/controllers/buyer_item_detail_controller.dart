import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item_detail.dart';
import 'package:leporemart/src/repositories/item_detail_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:leporemart/src/utils/log_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class BuyerItemDetailController extends GetxController {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.network('')..initialize();
  Rx<bool> isLoading = true.obs;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;

  final ItemDetailRepository _itemDetailRepository = ItemDetailRepository();
  Rx<BuyerItemDetail> itemDetail = BuyerItemDetail(
    id: 0,
    title: '',
    description: '',
    price: 0,
    images: [],
    shorts: '',
    nickname: '',
    width: null,
    height: null,
    depth: null,
    category: [],
    currentAmount: 0,
    isLiked: false,
    profileImage: '',
    temperature: 0,
    thumbnailImage: '',
  ).obs;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }

  void changeIndex(int newIndex) {
    logAnalytics(
        name: "buyer_item_detail_change_index",
        parameters: {"item_id": itemDetail.value.id, "index": newIndex});
    index.value = newIndex;
    if (index.value == itemDetail.value.images.length + 1) {
      videoPlayerController.play();
      isPlaying.value = true;
    } else {
      videoPlayerController.pause();
      isPlaying.value = false;
    }
  }

  void toggleVolume() {
    isMuted.value = !isMuted.value;
    videoPlayerController.setVolume(isMuted.value ? 0 : 1);
  }

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
    toggleIconVisible();
    if (isPlaying.value) {
      videoPlayerController.play();
    } else {
      videoPlayerController.pause();
    }
  }

  //0.2초간 아이콘이 보이고 사라지는 효과를 주는 함수
  void toggleIconVisible() {
    isIconVisible.value = true;
    Future.delayed(Duration(milliseconds: 1000), () {
      isIconVisible.value = false;
    });
  }

  Future<void> fetch() async {
    try {
      isLoading.value = true;
      itemDetail.value = await _itemDetailRepository
          .fetchBuyerItemDetail(Get.arguments['item_id']);
      videoPlayerController =
          VideoPlayerController.network(itemDetail.value.shorts)
            ..initialize().then((_) {
              videoPlayerController.setLooping(true);
            });
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      print('Error fetching item detail: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> like() async {
    try {
      itemDetail.value = itemDetail.value.like();
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.post(
        '/items/like',
        data: {'item_id': Get.arguments['item_id']},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
    } catch (e) {
      // 에러 처리
      print('Error fetching like ${Get.arguments['item_id']}: $e');
    }
  }

  Future<void> unlike() async {
    try {
      itemDetail.value = itemDetail.value.unlike();
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.delete(
        '/items/like',
        data: {'item_id': Get.arguments['item_id']},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
    } catch (e) {
      // 에러 처리
      print('Error fetching like ${Get.arguments['item_id']}: $e');
    }
  }
}
