import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/item_detail.dart';
import '../../../data/repositories/item_detail_repository.dart';
import '../../../utils/log_analytics.dart';

class SellerItemDetailController extends GetxController {
  final ItemDetailRepository repository;
  SellerItemDetailController({required this.repository})
      : assert(repository != null);

  VideoPlayerController videoPlayerController =
      VideoPlayerController.network('')..initialize();
  Rx<bool> isLoading = true.obs;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;
  Rx<SellerItemDetail> itemDetail = SellerItemDetail(
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
    profileImage: '',
    temperature: 0,
    thumbnailImage: '',
    reviews: [],
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
        name: "seller_item_detail_change_index",
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
      print('판매자 화면 갱신');
      print(Get.arguments['item_id']);
      isLoading.value = true;
      SellerItemDetail? data =
          await repository.fetchSellerItemDetail(Get.arguments['item_id']);
      if (data == null) {
        Get.snackbar('요청 오류', '작품을 불러오는 중 오류가 발생했습니다.');
        return;
      }
      itemDetail.value = data;
      videoPlayerController =
          VideoPlayerController.network(itemDetail.value.shorts)
            ..initialize().then((_) {
              videoPlayerController.setLooping(true);
            });
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching item detail: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> increaseAmount() async {
    try {
      print('잔여증가');
      if (itemDetail.value.currentAmount == 99) {
        throw Exception('Amount is full');
      }
      //API 요청
      final response =
          await repository.increaseAmount(Get.arguments['item_id']);
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
      itemDetail.value = itemDetail.value.increaseAmount();
    } catch (e) {
      // 에러 처리
      print('Error fetching like ${Get.arguments['item_id']}: $e');
    }
  }

  Future<void> decreaseAmount() async {
    try {
      print('잔여감소');
      if (itemDetail.value.currentAmount == 0) {
        throw Exception('Amount is empty');
      }
      //API 요청
      final response =
          await repository.decreaseAmount(Get.arguments['item_id']);
      //200이 아니라면 오류
      if (response.statusCode != 200) {
        throw Exception(
            'Status Code: ${response.statusCode} / Body: ${response.data}');
      }
      itemDetail.value = itemDetail.value.decreaseAmount();
    } catch (e) {
      // 에러 처리
      print('Error fetching like ${Get.arguments['item_id']}: $e');
    }
  }
}
