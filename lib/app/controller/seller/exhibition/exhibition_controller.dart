import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../data/models/exhibition.dart';
import '../../../data/repositories/exhibition_repository.dart';
import '../../../utils/log_analytics.dart';

class ExhibitionController extends GetxController {
  final ExhibitionRepository repository;
  ExhibitionController({required this.repository}) : assert(repository != null);

  RxList<Exhibition> exhibitions = RxList<Exhibition>([]);
  Rx<ExhibitionArtist?> exhibitionArtist = Rx<ExhibitionArtist?>(null);
  RxList<ExhibitionItem> exhibitionItems = RxList<ExhibitionItem>([
    ExhibitionItem(
        title: '폭발하는 화산',
        description:
            '폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.',
        imageUrls: [
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png'
        ],
        position: 0,
        isUsingTemplate: false,
        isSoled: false,
        backgroundColor: '0xffFFFFFF',
        fontFamily: 'Pretendard',
        id: 1),
    ExhibitionItem(
        title: '폭발하는 화산',
        description:
            '폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.',
        imageUrls: [
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png'
        ],
        position: 0,
        isUsingTemplate: false,
        isSoled: false,
        backgroundColor: '0xffFFFFFF',
        fontFamily: 'Pretendard',
        id: 2),
    ExhibitionItem(
        title: '폭발하는 화산',
        description:
            '폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.폭발하는 화산은 화산이 폭발하는 것을보고.',
        imageUrls: [
          'https://leporem-art-media-prod.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png'
        ],
        position: 0,
        isUsingTemplate: false,
        isSoled: false,
        backgroundColor: '0xffFFFFFF',
        fontFamily: 'Pretendard',
        id: 3),
  ]);

  // 기획전 소개
  RxList<File> exhibitionImage = RxList<File>([]);
  Rx<bool> isExhibitionImageLoading = Rx<bool>(false);
  TextEditingController exhibitionTitleController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController templateTitleController = TextEditingController();
  TextEditingController templateDescriptionController = TextEditingController();
  TextEditingController itemTitleController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemWidthController = TextEditingController();
  TextEditingController itemDepthController = TextEditingController();
  TextEditingController itemHeightController = TextEditingController();

  Rx<String> exhibitionTitle = Rx<String>('');
  Rx<String> sellerName = Rx<String>('');

  // 작가 소개
  RxList<File> sellerImage = RxList<File>([]);
  Rx<bool> isSellerImageLoading = Rx<bool>(false);
  TextEditingController sellerIntroductionController = TextEditingController();
  Rx<String> sellerIntroduction = Rx<String>('');
  Rx<bool> isSellerTemplateUsed = Rx<bool>(false);

  // 작가 소개 꾸미기
  List<int> colorList = [
    0xffFFFFFF,
    0xffF5E1E1,
    0xffF8E8E0,
    0xffE8F2DB,
    0xffDBF1F5,
    0xffE9E8F4,
    0xffB7A5A5,
    0xffA5B7AF,
    0xff9097B1,
    0xff000000
  ];
  List<String> fontList = [
    'Pretendard',
    'GmarketSans',
    'KBoDiaGothic',
    'ChosunCentennial'
  ];
  Rx<int> selectedSellerIntroductionColor = Rx<int>(0);
  Rx<int> selectedSellerIntroductionFont = Rx<int>(0);
  Rx<int> displayedSellerIntroductionFont = Rx<int>(0);

  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  // 작품 등록
  Rx<bool> isItemTemplateUsed = Rx<bool>(false);
  Rx<int> selectedTemplateIndex = Rx<int>(0);
  Rx<String> templateTitle = Rx<String>('');
  Rx<String> templateDescription = Rx<String>('');
  RxList<File> itemImages = RxList<File>([]);
  RxList<bool> isItemImagesLoading = RxList<bool>([]);
  RxList<File> itemAudio = RxList<File>([]);
  Rx<bool> isItemSailEnabled = Rx<bool>(true);
  RxList<File> itemVideo = RxList<File>([]);
  Rx<bool> isItemVideoLoading = Rx<bool>(false);
  Rx<bool> isItemAudioLoading = Rx<bool>(false);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);
  List<String> categoryTypes = ['그릇', '접시', '컵', '화분', '기타'];
  RxList<bool> selectedCategoryType = List.generate(5, (index) => false).obs;
  Rx<String> itemTitle = Rx<String>('');
  Rx<String> itemDescription = Rx<String>('');
  Rx<String> width = Rx<String>('');
  Rx<String> depth = Rx<String>('');
  Rx<String> height = Rx<String>('');
  Rx<int> price = Rx<int>(0);
  Rx<int> amount = Rx<int>(0);

  @override
  void onInit() async {
    exhibitionTitleController.addListener(() {
      exhibitionTitle.value = exhibitionTitleController.text;
    });
    sellerNameController.addListener(() {
      sellerName.value = sellerNameController.text;
    });
    sellerIntroductionController.addListener(() {
      sellerIntroduction.value = sellerIntroductionController.text;
    });
    templateTitleController.addListener(() {
      templateTitle.value = templateTitleController.text;
    });
    templateDescriptionController.addListener(() {
      templateDescription.value = templateDescriptionController.text;
    });
    itemTitleController.addListener(() {
      itemTitle.value = itemTitleController.text;
    });
    itemDescriptionController.addListener(() {
      itemDescription.value = itemDescriptionController.text;
    });
    itemPriceController.addListener(() {
      if (itemPriceController.text == '') return;
      price.value = int.parse(itemPriceController.text.replaceAll(',', ''));
    });
    itemWidthController.addListener(() {
      width.value = itemWidthController.text;
    });
    itemDepthController.addListener(() {
      depth.value = itemDepthController.text;
    });
    itemHeightController.addListener(() {
      height.value = itemHeightController.text;
    });
    await fetchSellerExhibitions();
    super.onInit();
  }

  Future<void> fetchSellerExhibitions() async {
    exhibitions.value = await repository.fetchSellerExhibitions();
  }

  Future<void> fetchExhibitionArtistById(int exhibitionId) async {
    exhibitionArtist.value =
        await repository.fetchExhibitionArtistById(exhibitionId);
  }

  Future<void> fetchExhibitionItemById(int exhibitionId) async {
    exhibitionItems.value =
        await repository.fetchExhibitionItemById(exhibitionId);
  }

  Future<void> selectImages(ImageType imageType) async {
    XFile? pickedFile;
    List<XFile> pickedFiles = [];
    switch (imageType) {
      case ImageType.exhibition:
        pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile == null) return;
        isExhibitionImageLoading.value = true;
        break;
      case ImageType.seller:
        pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile == null) return;
        isSellerImageLoading.value = true;
        break;
      case ImageType.item:
        pickedFiles = await ImagePicker().pickMultiImage();
        // 이미지 개수가 10개를 초과하면 에러 메시지를 표시하고 리턴
        if (pickedFiles.length > 10) {
          Get.snackbar(
            '이미지 선택',
            '이미지는 최대 10장까지 선택 가능합니다.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        isItemImagesLoading
            .assignAll(List.generate(pickedFiles.length, (_) => true));
        break;
    }
    // 압축한 이미지를 저장할 공간
    // 이미지를 압축하고 압축한 이미지를 compressedImage에 추가
    // 이미지 크기를 계산하기위해 변수생성
    int totalImageSize = 0;
    switch (imageType) {
      case ImageType.exhibition:
        final compressedImage = await compressImage(pickedFile!);
        if (compressedImage != null) {
          final compressedFile = File('${pickedFile.path}.compressed.jpg')
            ..writeAsBytesSync(compressedImage);
          exhibitionImage.assignAll([compressedFile]);
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
        break;
      case ImageType.seller:
        final compressedImage = await compressImage(pickedFile!);
        if (compressedImage != null) {
          final compressedFile = File('${pickedFile.path}.compressed.jpg')
            ..writeAsBytesSync(compressedImage);
          sellerImage.assignAll([compressedFile]);
          isSellerImageLoading.value = false;
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
        break;
      case ImageType.item:
        // 압축한 이미지를 저장할 공간
        List<File> compressedImages = [];
        int index = 0;
        // 이미지를 하나씩 압축하고 압축한 이미지를 compressedImages에 추가
        // 이미지 크기를 계산하기위해 변수생성
        for (final imageFile in pickedFiles) {
          isItemImagesLoading[index] = false;
          final compressedImage = await compressImage(imageFile);
          if (compressedImage != null) {
            final compressedFile = File('${imageFile.path}.compressed.jpg')
              ..writeAsBytesSync(compressedImage);
            compressedImages.add(compressedFile);

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
        if (isFileLargerThanMB(totalImageSize, 4)) return;
        itemImages.assignAll(compressedImages);
        break;
    }
  }

  bool isFileLargerThanMB(int totalSize, int size) {
    if (totalSize > size * 1024 * 1024) {
      logAnalytics(name: 'size_too_big');
      Get.snackbar(
        '경고',
        '파일 크기가 너무 큽니다. 다시 선택해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    }
    return false;
  }

  Future<Uint8List?> compressImage(XFile imageFile) async {
    final File file = File(imageFile.path);
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 30, // 이미지 품질 설정 (0 ~ 100, 기본값은 80)
    );
    return result;
  }

  void removeImage(ImageType imageType, {int? index}) {
    switch (imageType) {
      case ImageType.exhibition:
        exhibitionImage.value = [];
        break;
      case ImageType.seller:
        sellerImage.value = [];
        break;
      case ImageType.item:
        if (index! >= 0 && index! < itemImages.length) {
          itemImages.removeAt(index);
        }
      default:
        break;
    }
    exhibitionImage.value = [];
  }

  Future<void> selectAudio() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'aac', 'wav'],
    );

    if (pickedFile == null) {
      return;
    }
    //pickedFile 크기가 4MB 이상이면 경고창 띄우기
    if (isFileLargerThanMB(pickedFile.files.single.size, 4)) return;
    // 오디오 파일을 audioFile에 저장
    itemAudio.assignAll([File(pickedFile.files.single.path!)]);
  }

  void removeAudio() {
    itemAudio.value = [];
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
    // 썸네일 생성을 위해 isItemVideoLoading을 true로 변경
    isItemVideoLoading.value = true;
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
      itemVideo.clear();

      if (isFileLargerThanMB(compressedFile.lengthSync(), 30)) return;
      itemVideo.add(originalFile);
      isItemVideoLoading.value = false;
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e(e);
    }
  }

  void removeVideo() {
    itemVideo.clear();
    thumbnail.value = null;
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

  void exhibitionInfoReset() {
    exhibitionTitleController.clear();
    sellerNameController.clear();
    exhibitionImage.value = [];
  }

  void sellerInfoReset() {
    sellerIntroductionController.clear();
    sellerImage.value = [];
    selectedSellerIntroductionColor.value = 0;
    selectedSellerIntroductionFont.value = 0;
    displayedSellerIntroductionFont.value = 0;
  }

  bool isValidExhibitionSave() {
    return exhibitionImage.isNotEmpty &&
        exhibitionTitle.value != '' &&
        sellerName.value != '';
  }

  bool isValidSellerSave() {
    return isSellerTemplateUsed.value == true
        ? sellerImage.isNotEmpty && sellerIntroduction.value != ''
        : sellerImage.isNotEmpty;
  }

  bool isFontResetValid() {
    return selectedSellerIntroductionFont.value != 0;
  }

  bool isApplyValid() {
    return selectedSellerIntroductionFont.value !=
        displayedSellerIntroductionFont.value;
  }

  void applyFont() {
    displayedSellerIntroductionFont.value =
        selectedSellerIntroductionFont.value;
  }

  bool isValidItemNext() {]
    if (isItemTemplateUsed.value == true) {
      if (templateTitle.value.isEmpty || templateDescription.isEmpty) {
        return false;
      }
    } else {
      if (itemImages.isEmpty || itemImages.length > 10) {
        return false;
      }
    }
    return (isItemSailEnabled.value &&
            itemVideo.isNotEmpty &&
            itemTitle.value.isNotEmpty &&
            itemDescription.value.isNotEmpty &&
            price.value >= 1000 &&
            price.value <= 1000000 &&
            amount.value > 0) ||
        !isItemSailEnabled.value;
  }
}

enum ImageType { exhibition, seller, item }

enum SellerIntroductionColor {
  white,
  red,
  orange,
  green,
  blue,
  purple,
  brown,
  olive,
  indigo,
  black
}

enum SellerIntroductionFont { pretenderd, gmarketSans, kBoDiaGothic, chosun }
