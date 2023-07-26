import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ItemCreateDetailController extends GetxController {
  RxList<File> images = RxList<File>([]);
  RxList<bool> isImagesLoading = RxList<bool>([]);
  RxList<File> videos = RxList<File>([]);
  Rx<bool> isVideoLoading = Rx<bool>(false);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);
  List<String> categoryTypes = ['그릇', '컵', '접시', '그릇', '기타'];
  RxList<bool> selectedCategoryType = List.generate(5, (index) => false).obs;
  Rx<String> title = Rx<String>('');
  Rx<String> description = Rx<String>('');
  Rx<String> width = Rx<String>('');
  Rx<String> depth = Rx<String>('');
  Rx<String> height = Rx<String>('');
  Rx<int> price = Rx<int>(0);
  Rx<int> amount = Rx<int>(0);

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
    }
    // 이미지 개수만큼 isImagesLoading을 true로 변경
    isImagesLoading.assignAll(List.generate(pickedFiles.length, (_) => true));
    List<File> compressedImages = [];
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
        print('original image length: ${File(imageFile.path).lengthSync()}');
        print('original image path: ${imageFile.path}');
        print('compressed image length: ${compressedFile.lengthSync()}');
        print('compressed image path: ${compressedFile.path}');

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

  Future<void> selectVideo() async {
    // ImagePicker로 비디오를 선택 받음
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 15),
    );
    if (pickedFile == null) {
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
    return images.isNotEmpty &&
        images.length <= 10 &&
        title.value.isNotEmpty &&
        description.value.isNotEmpty &&
        price.value > 0 &&
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
        categoryList.add(MapEntry('categories', i.toString()));
      }
    }
    formData.fields.addAll(categoryList);

    print(formData.files);
    print(formData.fields);
    try {
      final response = await DioSingleton.dio.post(
        '/sellers/items',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
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
