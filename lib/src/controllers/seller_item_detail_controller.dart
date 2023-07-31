import 'package:get/get.dart';
import 'package:leporemart/src/models/item_detail.dart';
import 'package:leporemart/src/repositories/item_detail_repository.dart';
import 'package:video_player/video_player.dart';

class SellerItemDetailController extends GetxController {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.network('')..initialize();
  Rx<bool> isLoading = true.obs;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;

  final ItemDetailRepository _itemDetailRepository = ItemDetailRepository();
  Rx<ItemDetail> itemDetail = ItemDetail(
    id: 0,
    title: '',
    description: '',
    price: 0,
    imagesUrl: [],
    videoUrl: '',
    nickname: '',
    width: null,
    height: null,
    depth: null,
    category: [],
    currentAmount: 0,
    isLiked: false,
    profileImageUrl: '',
    temperature: 0,
    thumbnailUrl: '',
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
    index.value = newIndex;
    if (index.value == itemDetail.value.imagesUrl.length + 1) {
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
      print('컨트롤러에서: ${Get.arguments['item_id']}');
      isLoading.value = true;
      itemDetail.value =
          await _itemDetailRepository.fetchItemDetail(Get.arguments['item_id']);
      videoPlayerController =
          VideoPlayerController.network(itemDetail.value.videoUrl)
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
}
