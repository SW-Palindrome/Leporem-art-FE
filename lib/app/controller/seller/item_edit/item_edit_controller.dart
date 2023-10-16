import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:leporemart/app/data/repositories/item_create_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../data/models/item_detail.dart';
import '../home/seller_home_controller.dart';
import '../item_create_detail/item_create_detail_controller.dart';
import '../item_detail/seller_item_detail_controller.dart';

class ItemEditController extends ItemCreateDetailController {
  ItemEditController({required super.repository});

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

  SellerItemDetail itemDetail =
      Get.find<SellerItemDetailController>().itemDetail.value;

  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  void checkCategoryChanged() {
    List<String> categoryList = itemDetail.category;
    List<String> selectCategoryList = [];
    for (int i = 0; i < categoryList.length; i++) {
      for (int j = 0; j < selectedCategoryType.length; j++) {
        if (selectedCategoryType[j]) {
          selectCategoryList.add(categoryTypes[j]);
        }
      }
    }
    categoryList.sort();
    selectCategoryList.sort();
    if (categoryList.length != selectCategoryList.length) {
      isCategoryChanged.value = true;
      return;
    }
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i] != selectCategoryList[i]) {
        isCategoryChanged.value = true;
        return;
      }
    }
    isCategoryChanged.value = false;
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

  @override
  bool isValidCreate() {
    return images.isNotEmpty &&
        images.length <= 10 &&
        videos.isNotEmpty &&
        title.value.isNotEmpty &&
        description.value.isNotEmpty &&
        price.value >= 1000 &&
        price.value <= 1000000 &&
        amount.value >= 0;
  }

  @override
  void increaseAmount() {
    super.increaseAmount();
    checkAmountChanged();
  }

  @override
  void decreaseAmount() {
    super.decreaseAmount();
    checkAmountChanged();
  }

  @override
  void changeSelectedCategoryType(int index) {
    super.changeSelectedCategoryType(index);
    checkCategoryChanged();
  }

  @override
  Future<void> selectImages() async {
    super.selectImages();
    isImageChanged.value = true;
  }

  @override
  Future<void> selectVideo() async {
    super.selectVideo();
    isVideoChanged.value = true;
  }

  @override
  void removeImage(int index) {
    super.removeImage(index);
    isImageChanged.value = true;
  }

  @override
  void removeVideo(int index) {
    super.removeVideo(index);
    isVideoChanged.value = true;
  }

  bool isEditable() {
    return isImageChanged.value ||
        isVideoChanged.value ||
        isCategoryChanged.value ||
        isTitleChanged.value ||
        isDescriptionChanged.value ||
        isWidthChanged.value ||
        isDepthChanged.value ||
        isHeightChanged.value ||
        isPriceChanged.value ||
        isAmountChanged.value;
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
    List<String> imageList = itemDetail.images;

    isImagesLoading.assignAll(List.filled(imageList.length + 1, true));
    isVideoLoading.value = true;
    Dio dio = Dio();
    try {
      // 썸네일 이미지를 불러옴
      var response = await dio.get(itemDetail.thumbnailImage,
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

      // imageList에 있는 이미지들을 불러옴
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
      // 이미지 리스트가 갱신되었으므로 상태변경됨을 알림
      images.refresh();

      // 비디오 불러오기
      response = await dio.get(itemDetail.shorts,
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

  Future<void> editItem() async {
    // 쇼츠 등록 PRESIGNED URL을 얻기 위한 API 호출
    final response =
        await repository.getPreSignedUrl(videos.first.path.split('.').last);

    if (response.statusCode != 200) {
      Get.snackbar(
        '작품 수정 실패',
        '작품 수정에 실패하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final String presignedUrl = response.data['url'];
    Map<String, dynamic> payload = response.data['fields'];
    final shortsUrl = payload['key'];
    payload.addAll({
      'file': await MultipartFile.fromFile(
        videos.first.path,
        filename: videos.first.path.split('/').last,
      ),
    });

    final uploadResponse = await Dio().post(
      presignedUrl,
      data: FormData.fromMap(payload),
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    print(uploadResponse.statusCode);

    if (uploadResponse.statusCode != 204) {
      Get.snackbar(
        '작품 수정 실패',
        '작품 수정에 실패하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 데이터 모델에서 필요한 정보 가져오기
    String title = titleController.text;
    String description = descriptionController.text;
    String width = widthController.text;
    String depth = depthController.text;
    String height = heightController.text;
    int price = int.tryParse(priceController.text.replaceAll(',', '')) ?? 0;
    int amount = this.amount.value;
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'width': width,
      'depth': depth,
      'height': height,
      'price': price,
      'amount': amount,
      'thumbnail_image': await MultipartFile.fromFile(
        images.first.path,
        filename: images.first.path.split('/').last,
      ),
      'shorts_url': shortsUrl,
    });
    //images에서 1번인덱스부터 끝까지의 이미지를 리스트에 넣고 formData에 추가

    List<MapEntry<String, MultipartFile>> imageList = [];
    for (int i = 1; i < images.length; i++) {
      imageList.add(MapEntry(
        'images',
        await MultipartFile.fromFile(
          images[i].path,
          filename: images[i].path.split('/').last,
        ),
      ));
    }
    formData.files.addAll(imageList);

    List<MapEntry<String, String>> categoryList = [];
    // 선택된 카테고리 타입을 formData에 추가
    for (int i = 0; i < selectedCategoryType.length; i++) {
      if (selectedCategoryType[i]) {
        categoryList.add(MapEntry('categories', (i + 1).toString()));
      }
    }
    formData.fields.addAll(categoryList);

    try {
      final response = await repository.editItem(itemDetail.id, formData);

      if (response.statusCode == 200) {
        await Get.find<SellerItemDetailController>().fetch();
        await Get.find<SellerHomeController>().pageReset();
        Get.back();
        Get.snackbar(
          '작품 수정',
          '작품이 성공적으로 수정되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          '작품 수정 실패',
          '작품 수정에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      print(error);
      Get.snackbar(
        '작품 수정 실패',
        '작품 수정 중 오류가 발생하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
