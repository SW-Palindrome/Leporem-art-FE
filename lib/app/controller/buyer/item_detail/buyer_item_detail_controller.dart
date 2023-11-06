import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/item_detail.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/repositories/item_detail_repository.dart';
import '../../../utils/log_analytics.dart';

class BuyerItemDetailController extends GetxController {
  final ItemDetailRepository itemDetailRepository;
  final HomeRepository homeRepository;
  BuyerItemDetailController(
      {required this.itemDetailRepository, required this.homeRepository})
      : assert(itemDetailRepository != null && homeRepository != null);

  VideoPlayerController videoPlayerController =
      VideoPlayerController.network('')..initialize();
  Rx<bool> isLoading = true.obs;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;

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
      BuyerItemDetail? data = await itemDetailRepository
          .fetchBuyerItemDetail(Get.arguments['item_id']);
      if (data == null) {
        Get.snackbar('요청 오류', '상품 정보를 불러오는데 실패했습니다.');
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
      print('Error fetching item detail: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> like() async {
    itemDetail.value = itemDetail.value.like();
    await homeRepository.like(Get.arguments['item_id']);
  }

  Future<void> unlike() async {
    itemDetail.value = itemDetail.value.unlike();
    await homeRepository.unlike(Get.arguments['item_id']);
  }
}
