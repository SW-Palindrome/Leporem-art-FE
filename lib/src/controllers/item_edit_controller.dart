import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/controllers/seller_item_detail_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ItemEditController extends ItemCreateDetailController {
  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  Future<void> load() async {
    titleController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.title;
    descriptionController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.description;
    priceController.text = Get.find<SellerItemDetailController>()
        .itemDetail
        .value
        .price
        .toString()
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    ;
    widthController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.width ??
            ''.toString();
    depthController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.depth ??
            ''.toString();
    heightController.text =
        Get.find<SellerItemDetailController>().itemDetail.value.height ??
            ''.toString();
    amount.value =
        Get.find<SellerItemDetailController>().itemDetail.value.currentAmount;
    List<String> categoryList =
        Get.find<SellerItemDetailController>().itemDetail.value.category;
    for (int i = 0; i < categoryList.length; i++) {
      for (int j = 0; j < categoryTypes.length; j++) {
        if (categoryList[i] == categoryTypes[j]) {
          selectedCategoryType[j] = true;
          continue;
        }
      }
    }
    List<String> imageList =
        Get.find<SellerItemDetailController>().itemDetail.value.imagesUrl;

    isImagesLoading.assignAll(List.filled(imageList.length + 1, true));
    isVideoLoading.value = true;
    Dio dio = Dio();
    try {
      var response = await dio.get(
          Get.find<SellerItemDetailController>().itemDetail.value.thumbnailUrl,
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

      response = await dio.get(
          Get.find<SellerItemDetailController>().itemDetail.value.videoUrl,
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
