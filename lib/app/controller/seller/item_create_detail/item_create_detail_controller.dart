import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../data/repositories/item_create_repository.dart';
import '../../../utils/log_analytics.dart';
import '../home/seller_home_controller.dart';

class ItemCreateDetailController extends GetxController {
  final ItemCreateRepository repository;
  ItemCreateDetailController({required this.repository})
      : assert(repository != null);

  RxList<File> images = RxList<File>([]);
  RxList<bool> isImagesLoading = RxList<bool>([]);
  RxList<File> videos = RxList<File>([]);
  Rx<bool> isVideoLoading = Rx<bool>(false);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);
  List<String> categoryTypes = ['그릇', '접시', '컵', '화분', '기타'];
  RxList<bool> selectedCategoryType = List.generate(5, (index) => false).obs;
  Rx<String> title = Rx<String>('');
  Rx<String> description = Rx<String>('');
  Rx<String> width = Rx<String>('');
  Rx<String> depth = Rx<String>('');
  Rx<String> height = Rx<String>('');
  Rx<int> price = Rx<int>(0);
  Rx<int> amount = Rx<int>(0);
  Rx<bool> isCreateClicked = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      title.value = titleController.text;
    });
    descriptionController.addListener(() {
      description.value = descriptionController.text;
    });
    priceController.addListener(() {
      if (priceController.text == '') return;
      price.value = int.parse(priceController.text.replaceAll(',', ''));
    });
  }

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
    } else if (pickedFiles.isEmpty) {
      return;
    }
    // 이미지 개수만큼 isImagesLoading을 true로 변경
    isImagesLoading.assignAll(List.generate(pickedFiles.length, (_) => true));
    // 압축한 이미지를 저장할 공간
    List<File> compressedImages = [];
    int index = 0;
    // 이미지를 하나씩 압축하고 압축한 이미지를 compressedImages에 추가
    // 이미지 크기를 계산하기위해 변수생성
    int totalImageSize = 0;
    for (final imageFile in pickedFiles) {
      isImagesLoading[index] = false;
      final compressedImage = await compressImage(imageFile);
      if (compressedImage != null) {
        final compressedFile = File('${imageFile.path}.compressed.jpg')
          ..writeAsBytesSync(compressedImage);
        compressedImages.add(compressedFile);
        print('original image length: ${File(imageFile.path).lengthSync()}');
        print('original image path: ${imageFile.path}');
        print('compressed image length: ${compressedFile.lengthSync()}');
        print('compressed image path: ${compressedFile.path}');

        // 이미지 크기를 계산
        totalImageSize += compressedFile.lengthSync();

        // // 압축한 이미지를 폰에 저장시키기
        // final result = await ImageGallerySaver.saveFile(
        //   compressedFile.path,
        //   name: 'compressed_image_$index',
        // );
        index++;
      }
    }
    print('total image size: $totalImageSize');
    if (totalImageSize > 5 * 1024 * 1024) {
      logAnalytics(name: 'image_size_too_big');
      Get.snackbar(
        '경고',
        '이미지 크기가 너무 큽니다. 다시 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    images.assignAll(compressedImages);
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
    }
  }

  Future<void> selectVideo() async {
    // ImagePicker로 비디오를 선택 받음
    var pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return;
    }

    VideoPlayerController testLengthController =
        VideoPlayerController.file(File(pickedFile.path));
    await testLengthController.initialize();
    if (testLengthController.value.duration.inSeconds > 30) {
      logAnalytics(name: 'video_size_too_big');
      Get.snackbar(
        '동영상 길이 제한',
        '30초 이하의 동영상을 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // 썸네일 생성을 위해 isVideoLoading을 true로 변경
    isVideoLoading.value = true;
    // 썸네일 생성
    final thumbnailData =
        await VideoThumbnail.thumbnailData(video: pickedFile.path);
    // thumbnail 변수에 썸네일 추가
    if (thumbnailData != null) {
      thumbnail.value = thumbnailData;
    }
    // 비디오 압축
    try {
      File originalFile = File(pickedFile.path);
      final compressedMediaInfo = await VideoCompress.compressVideo(
        originalFile.path,
        quality: VideoQuality.MediumQuality,
        includeAudio: true,
      );
      if (compressedMediaInfo == null) {
        Exception('비디오 압축 실패');
      }
      File compressedFile = File(compressedMediaInfo!.path!);
      // 원본 비디오와 압축한 비디오의 정보를 출력 이미지는 로딩이 되었으므로 isVideoLoaiding을 false로 변경
      videos.clear();

      if (compressedFile.lengthSync() > 30 * 1024 * 1024) {
        Get.snackbar(
          '경고',
          '동영상 크기가 너무 큽니다. 다시 선택해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      videos.add(originalFile);
      isVideoLoading.value = false;
      print('original video length: ${originalFile.lengthSync()}');
      print('original video path: ${originalFile.path}');
      print('compressed video length: ${compressedFile.lengthSync()}');
      print('compressed video path: ${compressedFile.path}');
      // // 압축한 비디오를 폰에 저장시키기
      // final result = await ImageGallerySaver.saveFile(
      //   info.path!,
      //   name: 'compressed_video',
      // );
      // print('result: $result');
    } catch (e) {
      print(e);
    }
  }

  void removeVideo(int index) {
    if (index >= 0 && index < videos.length) {
      videos.clear();
      thumbnail.value = null;
    }
  }

  void changeSelectedCategoryType(int index) {
    selectedCategoryType[index] = !selectedCategoryType[index];
  }

  void resetSelectedCategoryType() {
    selectedCategoryType.value = List.generate(5, (index) => false);
  }

  void decreaseAmount() {
    if (amount.value > 0) {
      amount.value--;
    }
  }

  void increaseAmount() {
    if (amount.value < 99) {
      amount.value++;
    }
  }

  bool isValidCreate() {
    return images.isNotEmpty &&
        images.length <= 10 &&
        videos.isNotEmpty &&
        title.value.isNotEmpty &&
        description.value.isNotEmpty &&
        price.value >= 1000 &&
        price.value <= 1000000 &&
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

    // 쇼츠 등록 PRESIGNED URL을 얻기 위한 API 호출
    final response =
        await repository.getPreSignedUrl(videos.first.path.split('.').last);

    if (response.statusCode != 200) {
      Get.snackbar(
        '작품 등록 실패',
        '작품 등록에 실패하였습니다. 다시 시도해주세요.',
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

    if (uploadResponse.statusCode != 204) {
      Get.snackbar(
        '작품 등록 실패',
        '작품 등록에 실패하였습니다. 다시 시도해주세요.',
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
      final response = await repository.createItem(formData);

      if (response.statusCode == 200) {
        await Get.find<SellerHomeController>().pageReset();
        Get.back();
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
}
