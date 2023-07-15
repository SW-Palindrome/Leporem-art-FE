import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ItemDetailController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rx<int> index = 0.obs;
  Rx<bool> isMuted = false.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<bool> isIconVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    videoPlayerController = VideoPlayerController.network(
        'https://leporem-art-fe-test.s3.ap-northeast-2.amazonaws.com/test.mp4')
      ..initialize().then((_) {
        videoPlayerController.setLooping(true);
      });
  }

  void changeIndex(int newIndex) {
    index.value = newIndex;
    if (index.value == 3) {
      videoPlayerController.play();
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
}
