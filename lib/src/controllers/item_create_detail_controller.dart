import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ItemCreateDetailController extends GetxController {
  RxList<File> images = RxList<File>([]);
  RxList<File> videos = RxList<File>([]);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);

  Future<void> selectImages() async {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 5,
    );
    if (pickedFiles.length > 10) {
      Get.snackbar(
        '이미지 선택',
        '이미지는 최대 10장까지 선택 가능합니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (pickedFiles.length < 3) {
      Get.snackbar(
        '이미지 선택',
        '이미지는 최소 3장 이상 선택해야 합니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (pickedFiles != null) {
      images.assignAll(pickedFiles.map((file) => File(file.path)).toList());
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
    }
  }

  Future<void> selectVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videos.assignAll([File((pickedFile).path)]);
      thumbnail.value = await VideoThumbnail.thumbnailData(
        video: pickedFile.path,
        imageFormat: ImageFormat.PNG,
        quality: 5,
      );
    }
  }

  void removeVideo(int index) {
    if (index >= 0 && index < videos.length) {
      videos.removeAt(index);
    }
  }
}
