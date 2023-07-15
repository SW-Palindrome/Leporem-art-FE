import 'package:get/get.dart';
import 'package:leporemart/src/models/item_detail.dart';
import 'package:leporemart/src/repositories/item_detail_repository.dart';
import 'package:video_player/video_player.dart';

class ItemDetailController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;

  final ItemDetailRepository _itemDetailRepository = ItemDetailRepository();
  late ItemDetail itemDetail;

  @override
  void onInit() async {
    super.onInit();
    await fetch();
    videoPlayerController = VideoPlayerController.network(itemDetail.videoUrl)
      ..initialize().then((_) {
        videoPlayerController.setLooping(true);
      });
  }

  void changeIndex(int newIndex) {
    index.value = newIndex;
    if (index.value == itemDetail.imagesUrl.length) {
      videoPlayerController.play();
      isPlaying.value = true;
    } else {
      videoPlayerController.pause();
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
      itemDetail = await _itemDetailRepository.fetchItemDetail();
    } catch (e) {
      // 에러 처리
      print('Error fetching item detail: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
