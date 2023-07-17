import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ItemCreateDetailController extends GetxController {
  RxList<File> images = RxList<File>([]);
  RxList<File> videos = RxList<File>([]);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);
  Rx<int> amount = Rx<int>(0);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void> selectImages() async {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
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
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );
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

  void decreaseQuantity() {
    if (amount.value > 0) {
      amount.value--;
    }
  }

  void increaseQuantity() {
    if (amount.value < 99) {
      amount.value++;
    }
  }

  bool isValidCreate() {
    return images.length >= 3 &&
        images.length <= 10 &&
        videos.length == 1 &&
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        amount.value > 0;
  }

  Future<void> createItem() async {
    if (!isValidCreate()) {
      // 필수 입력 사항이 충족되지 않으면 처리
      Get.snackbar(
        '작품 등록',
        '작품 등록에 필요한 정보를 모두 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 데이터 모델에서 필요한 정보 가져오기
    String title = titleController.text;
    String description = descriptionController.text;
    double width = double.tryParse(widthController.text) ?? 0.0;
    double depth = double.tryParse(depthController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    int price = int.tryParse(priceController.text.replaceAll(',', '')) ?? 0;
    int amount = this.amount.value;
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'width': width,
      'depth': depth,
      'height': height,
      'price': price,
      'max_amount': amount,
      'thumbnail_image': await MultipartFile.fromFile(
        images.first.path,
        filename: images.first.path.split('/').last,
      ),
      'shorts': await MultipartFile.fromFile(
        videos.first.path,
        filename: videos.first.path.split('/').last,
      ),
    });
    try {
      final response = await DioSingleton.dio.post(
        '/sellers/items',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200) {
        clearForm();
        Get.snackbar(
          '작품 등록',
          '작품이 성공적으로 등록되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          '작품 등록 실패',
          '작품 등록에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      print(error);
      Get.snackbar(
        '작품 등록 실패',
        '작품 등록 중 오류가 발생하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearForm() {
    images.clear();
    videos.clear();
    thumbnail.value = null;
    titleController.clear();
    descriptionController.clear();
    widthController.clear();
    depthController.clear();
    heightController.clear();
    priceController.clear();
    amount.value = 0;
  }
}
