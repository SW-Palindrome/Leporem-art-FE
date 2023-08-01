import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReviewController extends GetxController {
  RxList<File> images = RxList<File>([]);
  RxList<bool> isImagesLoading = RxList<bool>([]);
  Rx<String> description = Rx<String>('');
  Rx<int> star = 0.obs;

  TextEditingController descriptionController = TextEditingController();

  Future<Uint8List?> compressImage(XFile imageFile) async {
    final File file = File(imageFile.path);
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 30, // 이미지 품질 설정 (0 ~ 100, 기본값은 80)
    );
    return result;
  }

  Future<void> selectImages() async {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
    // 이미지 개수가 10개를 초과하면 에러 메시지를 표시하고 리턴
    if (pickedFiles.length > 10) {
      Get.snackbar(
        '이미지 선택',
        '이미지는 최대 10장까지 선택 가능합니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // 이미지 개수만큼 isImagesLoading을 true로 변경
    isImagesLoading.assignAll(List.generate(pickedFiles.length, (_) => true));
    // 압축한 이미지를 저장할 공간
    List<File> compressedImages = [];
    // 이미지를 추가하기전 기존의 이미지리스트를 초기화
    images.clear();
    int index = 0;
    // 이미지를 하나씩 압축하고 압축한 이미지를 compressedImages에 추가
    for (final imageFile in pickedFiles) {
      images.add(File(imageFile.path));
      isImagesLoading[index] = false;
      final compressedImage = await compressImage(imageFile);
      if (compressedImage != null) {
        final compressedFile = File('${imageFile.path}.compressed.jpg')
          ..writeAsBytesSync(compressedImage);
        compressedImages.add(compressedFile);
        // print('original image length: ${File(imageFile.path).lengthSync()}');
        // print('original image path: ${imageFile.path}');
        // print('compressed image length: ${compressedFile.lengthSync()}');
        // print('compressed image path: ${compressedFile.path}');

        // // 압축한 이미지를 폰에 저장시키기
        // final result = await ImageGallerySaver.saveFile(
        //   compressedFile.path,
        //   name: 'compressed_image_$index',
        // );
        index++;
      }
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
    }
  }
}
