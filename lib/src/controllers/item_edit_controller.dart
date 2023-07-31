import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/controllers/seller_item_detail_controller.dart';
import 'package:leporemart/src/models/item_detail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ItemEditController extends ItemCreateDetailController {
  Rx<bool> isImageChanged = false.obs;
  Rx<bool> isVideoChanged = false.obs;
  Rx<bool> isCategoryChanged = false.obs;
  Rx<bool> isTitleChanged = false.obs;
  Rx<bool> isDescriptionChanged = false.obs;
  Rx<bool> isWidthChanged = false.obs;
  Rx<bool> isDepthChanged = false.obs;
  Rx<bool> isHeightChanged = false.obs;
  Rx<bool> isPriceChanged = false.obs;
  Rx<bool> isAmountChanged = false.obs;

  ItemDetail itemDetail =
      Get.find<SellerItemDetailController>().itemDetail.value;
  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  void checkTitleChanged(String value) {
    if (value != itemDetail.title) {
      isTitleChanged.value = true;
    } else {
      isTitleChanged.value = false;
    }
  }

  void checkDescriptionChanged(String value) {
    if (value != itemDetail.description) {
      isDescriptionChanged.value = true;
    } else {
      isDescriptionChanged.value = false;
    }
  }

  void checkWidthChanged(String value) {
    if (value != itemDetail.width) {
      isWidthChanged.value = true;
    } else {
      isWidthChanged.value = false;
    }
  }

  void checkDepthChanged(String value) {
    if (value != itemDetail.depth) {
      isDepthChanged.value = true;
    } else {
      isDepthChanged.value = false;
    }
  }

  void checkHeightChanged(String value) {
    if (value != itemDetail.height) {
      isHeightChanged.value = true;
    } else {
      isHeightChanged.value = false;
    }
  }

  void checkPriceChanged(String value) {
    if (value !=
        itemDetail.price.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            )) {
      isPriceChanged.value = true;
    } else {
      isPriceChanged.value = false;
    }
  }

  void checkAmountChanged() {
    if (amount.value != itemDetail.currentAmount) {
      isAmountChanged.value = true;
    } else {
      isAmountChanged.value = false;
    }
  }

  Future<void> load() async {
    titleController.text = itemDetail.title;
    descriptionController.text = itemDetail.description;
    priceController.text = itemDetail.price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    ;
    widthController.text = itemDetail.width ?? ''.toString();
    depthController.text = itemDetail.depth ?? ''.toString();
    heightController.text = itemDetail.height ?? ''.toString();
    amount.value = itemDetail.currentAmount;
    List<String> categoryList = itemDetail.category;
    for (int i = 0; i < categoryList.length; i++) {
      for (int j = 0; j < categoryTypes.length; j++) {
        if (categoryList[i] == categoryTypes[j]) {
          selectedCategoryType[j] = true;
          continue;
        }
      }
    }
    List<String> imageList = itemDetail.imagesUrl;

    isImagesLoading.assignAll(List.filled(imageList.length + 1, true));
    isVideoLoading.value = true;
    Dio dio = Dio();
    try {
      var response = await dio.get(itemDetail.thumbnailUrl,
          options: Options(responseType: ResponseType.bytes));

      // 이미지 데이터를 바이트 배열로 가져옴
      List<int> imageBytes = response.data;

      // 파일 생성
      Directory cacheDir = await getTemporaryDirectory();
      File imageFile = File('${cacheDir.path}/temp0.jpg');

      // 파일 쓰기
      await imageFile.writeAsBytes(imageBytes);
      images.value.add(imageFile);
      isImagesLoading[0] = false;

      for (int i = 0; i < imageList.length; i++) {
        final response = await dio.get(imageList[i],
            options: Options(responseType: ResponseType.bytes));

        // 이미지 데이터를 바이트 배열로 가져옴
        List<int> imageBytes = response.data;

        // 파일 생성
        Directory cacheDir = await getTemporaryDirectory();
        File imageFile = File('${cacheDir.path}/temp${i + 1}.jpg');

        // 파일 쓰기
        await imageFile.writeAsBytes(imageBytes);
        images.add(imageFile);
        isImagesLoading[i + 1] = false;
      }

      response = await dio.get(itemDetail.videoUrl,
          options: Options(responseType: ResponseType.bytes));

      // 동영상 데이터를 바이트 배열로 가져옴
      List<int> videoBytes = response.data;

      // 파일 생성
      cacheDir = await getTemporaryDirectory();
      File videoFile = File('${cacheDir.path}/temp_video.mp4');

      // 파일 쓰기
      await videoFile.writeAsBytes(videoBytes);
      videos.add(videoFile);

      final thumbnailData =
          await VideoThumbnail.thumbnailData(video: videoFile.path);
      // thumbnail 변수에 썸네일 추가
      if (thumbnailData != null) {
        thumbnail.value = thumbnailData;
      }
      isVideoLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
