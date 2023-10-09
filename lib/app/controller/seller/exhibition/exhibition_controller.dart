import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/exhibition.dart';
import '../../../data/repositories/exhibition_repository.dart';
import '../../../utils/log_analytics.dart';

class ExhibitionController extends GetxController {
  final ExhibitionRepository repository;
  ExhibitionController({required this.repository}) : assert(repository != null);

  RxList<Exhibition> exhibitions = <Exhibition>[].obs;

  // 기획전 소개
  RxList<File> exhibitionImage = RxList<File>([]);
  Rx<bool> isExhibitionImageLoading = Rx<bool>(false);
  TextEditingController titleController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  Rx<String> title = Rx<String>('');
  Rx<String> sellerName = Rx<String>('');

  // 작가 소개
  RxList<File> sellerImage = RxList<File>([]);
  Rx<bool> isSellerImageLoading = Rx<bool>(false);
  TextEditingController sellerIntroductionController = TextEditingController();
  Rx<String> sellerIntroduction = Rx<String>('');
  Rx<bool> isSellerTemplateUsed = Rx<bool>(false);

  @override
  void onInit() async {
    titleController.addListener(() {
      title.value = titleController.text;
    });
    sellerNameController.addListener(() {
      sellerName.value = sellerNameController.text;
    });
    sellerIntroductionController.addListener(() {
      sellerIntroduction.value = sellerIntroductionController.text;
    });
    await fetchSellerExhibitions();
    super.onInit();
  }

  Future<void> fetchSellerExhibitions() async {
    exhibitions.value = await repository.fetchSellerExhibitions();
  }

  Future<void> selectImages(ImageType imageType) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // 이미지 개수만큼 isImagesLoading을 true로 변경
    //pickedFile을 image에 저장
    if (pickedFile == null) return;
    isExhibitionImageLoading.value = true;
    // 압축한 이미지를 저장할 공간
    // 이미지를 압축하고 압축한 이미지를 compressedImage에 추가
    // 이미지 크기를 계산하기위해 변수생성
    int totalImageSize = 0;
    final compressedImage = await compressImage(pickedFile);
    if (compressedImage != null) {
      final compressedFile = File('${pickedFile.path}.compressed.jpg')
        ..writeAsBytesSync(compressedImage);
      switch (imageType) {
        case ImageType.exhibition:
          exhibitionImage.assignAll([compressedFile]);
          break;
        case ImageType.seller:
          sellerImage.assignAll([compressedFile]);
          break;
        default:
          break;
      }
      isExhibitionImageLoading.value = false;
      totalImageSize = compressedFile.lengthSync();
    }
    if (totalImageSize > 5 * 1024 * 1024) {
      logAnalytics(name: 'image_size_too_big');
      Get.snackbar(
        '경고',
        '이미지 크기가 너무 큽니다. 다시 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<Uint8List?> compressImage(XFile imageFile) async {
    final File file = File(imageFile.path);
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 30, // 이미지 품질 설정 (0 ~ 100, 기본값은 80)
    );
    return result;
  }

  void removeImage() {
    exhibitionImage.value = [];
  }

  void exhibitionInfoReset() {
    titleController.clear();
    sellerNameController.clear();
    exhibitionImage.value = [];
  }

  bool isValidExhibitionSave() {
    return exhibitionImage.isNotEmpty &&
        title.value != '' &&
        sellerName.value != '';
  }

  bool isValidSellerSave() {
    return sellerImage.isNotEmpty && sellerIntroduction.value != '';
  }
}

enum ImageType { exhibition, seller, item }
