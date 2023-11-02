import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../data/models/exhibition.dart';
import '../../../data/repositories/exhibition_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/log_analytics.dart';

class SellerExhibitionController extends GetxController {
  final ExhibitionRepository repository;
  SellerExhibitionController({required this.repository})
      : assert(repository != null);

  RxList<Exhibition> exhibitions = RxList<Exhibition>([]);
  Rx<ExhibitionArtist?> exhibitionArtist = Rx<ExhibitionArtist?>(null);
  RxList<ExhibitionItem> exhibitionItems = RxList<ExhibitionItem>([]);

  // 기획전 소개
  Rx<ExhibitionStatus> exhibitionStatus =
      Rx<ExhibitionStatus>(ExhibitionStatus.created);
  RxList<File> exhibitionImage = RxList<File>([]);
  Rx<bool> isExhibitionImageLoading = Rx<bool>(false);
  TextEditingController exhibitionTitleController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController templateTitleController = TextEditingController();
  TextEditingController templateDescriptionController = TextEditingController();
  TextEditingController itemTitleController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  Rx<String> exhibitionTitle = Rx<String>('');
  Rx<String> sellerName = Rx<String>('');

  // 작가 소개
  RxList<File> sellerImage = RxList<File>([]);
  Rx<bool> isSellerImageLoading = Rx<bool>(false);
  TextEditingController sellerIntroductionController = TextEditingController();
  Rx<String> sellerIntroduction = Rx<String>('');
  Rx<bool> isSellerTemplateUsed = Rx<bool>(false);

  // 작가, 작품 소개 꾸미기
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
    0xff191f28,
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

  Rx<int> selectedItemBackgroundColor = Rx<int>(0);
  Rx<int> selectedItemFont = Rx<int>(0);
  Rx<int> displayedItemFont = Rx<int>(0);

  // 작품 등록
  Rx<bool> isItemTemplateUsed = Rx<bool>(false);
  Rx<int> selectedTemplateIndex = Rx<int>(1);
  Rx<String> templateTitle = Rx<String>('');
  Rx<String> templateDescription = Rx<String>('');

  RxList<File> itemImages = RxList<File>([]);
  RxMap<int, File> templateItemImages = RxMap<int, File>();

  RxList<bool> isItemImagesLoading = RxList<bool>([]);
  RxList<File> itemAudio = RxList<File>([]);
  Rx<bool> isItemSailEnabled = Rx<bool>(false);
  RxList<File> itemVideo = RxList<File>([]);
  Rx<bool> isItemVideoLoading = Rx<bool>(false);
  Rx<bool> isItemAudioLoading = Rx<bool>(false);
  Rx<Uint8List?> thumbnail = Rx<Uint8List?>(null);
  Rx<String> itemTitle = Rx<String>('');
  Rx<String> itemDescription = Rx<String>('');
  Rx<int> price = Rx<int>(0);
  Rx<int> amount = Rx<int>(1);

  // 작품 리스트

  Rx<bool> isEditingItem = Rx<bool>(false);
  Rx<bool> isEditingItemList = Rx<bool>(false);

  int get exhibitionId => Get.arguments['exhibition_id'];

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
    await fetchSellerExhibitions();
    super.onInit();
  }

  Future<void> fetchSellerExhibitions() async {
    exhibitions.value = await repository.fetchSellerExhibitions();
  }

  Future<void> fetchExhibitionById(int exhibitionId) async {
    Exhibition exhibition = await repository.fetchExhibitionById(exhibitionId);
    exhibitionStatus.value = exhibition.status!;
  }

  Future<void> fetchSellerExhibitionById(int exhibitionId) async {
    Exhibition exhibition =
        exhibitions.firstWhere((element) => element.id == exhibitionId);

    exhibitionTitleController.text = exhibition.title;
    sellerNameController.text = exhibition.seller;
    String? imageUrl = exhibition.coverImage;

    if (imageUrl == null) return;

    Dio dio = Dio();
    try {
      // 썸네일 이미지를 불러옴
      var response = await dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));

      // 이미지 데이터를 바이트 배열로 가져옴
      List<int> imageBytes = response.data;

      // 파일 생성
      Directory cacheDir = await getTemporaryDirectory();
      File imageFile = File('${cacheDir.path}/${Uuid().v4()}.jpg');

      // 파일 쓰기
      await imageFile.writeAsBytes(imageBytes);
      exhibitionImage.assignAll([imageFile]);
      // 이미지 리스트가 갱신되었으므로 상태변경됨을 알림
      exhibitionImage.refresh();
    } catch (e) {
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e(e);
    }
  }

  Future<void> fetchExhibitionArtistById(int exhibitionId) async {
    // await repository.fetchExhibitionArtistById(exhibitionId) 가 null이 아니면 exhibitionArtist.value에 저장
    exhibitionArtist.value =
        await repository.fetchExhibitionArtistById(exhibitionId);

    sellerIntroductionController.text = exhibitionArtist.value!.description;
    isSellerTemplateUsed.value = exhibitionArtist.value!.isUsingTemplate;

    String? imageUrl = exhibitionArtist.value!.imageUrl;
    Dio dio = Dio();
    if (imageUrl != null) {
      try {
        // 썸네일 이미지를 불러옴
        var response = await dio.get(imageUrl,
            options: Options(responseType: ResponseType.bytes));

        // 이미지 데이터를 바이트 배열로 가져옴
        List<int> imageBytes = response.data;

        // 파일 생성
        Directory cacheDir = await getTemporaryDirectory();
        File imageFile = File('${cacheDir.path}/${Uuid().v4()}.jpg');

        // 파일 쓰기
        await imageFile.writeAsBytes(imageBytes);
        sellerImage.assignAll([imageFile]);
        // 이미지 리스트가 갱신되었으므로 상태변경됨을 알림
        sellerImage.refresh();
      } catch (e) {
        Logger logger = Logger(printer: PrettyPrinter());
        logger.e(e);
      }
    }
  }

  Future<void> fetchExhibitionItemById(int itemId) async {
    ExhibitionItem exhibitionItem =
        exhibitionItems.firstWhere((element) => element.id == itemId);

    isItemTemplateUsed.value = exhibitionItem.isUsingTemplate;
    selectedTemplateIndex.value = exhibitionItem.template ?? 1;
    isItemSailEnabled.value = exhibitionItem.isSale;

    if (isItemTemplateUsed.value == true) {
      List<String> imageList = exhibitionItem.imageUrls;
      itemImages.clear();
      Dio dio = Dio();
      // imageList에 있는 이미지들을 불러옴
      for (int i = 0; i < imageList.length; i++) {
        final response = await dio.get(imageList[i],
            options: Options(responseType: ResponseType.bytes));

        // 이미지 데이터를 바이트 배열로 가져옴
        List<int> imageBytes = response.data;

        // 파일 생성
        Directory cacheDir = await getTemporaryDirectory();
        File imageFile = File('${cacheDir.path}/${Uuid().v4()}.jpg');
        // 파일 쓰기
        await imageFile.writeAsBytes(imageBytes);
        templateItemImages[i] = imageFile;
      }
      // 이미지 맵이 갱신되었으므로 상태변경됨을 알림
      templateItemImages.refresh();
      templateTitleController.text = exhibitionItem.title;
      templateDescriptionController.text = exhibitionItem.description;
      selectedItemBackgroundColor.value =
          int.parse(exhibitionItem.backgroundColor);
      selectedItemFont.value = int.parse(exhibitionItem.fontFamily);
      displayedItemFont.value = int.parse(exhibitionItem.fontFamily);
      selectedItemBackgroundColor.refresh();
      selectedItemFont.refresh();
      displayedItemFont.refresh();
    } else {
      List<String> imageList = exhibitionItem.imageUrls;
      isItemImagesLoading.assignAll(List.filled(imageList.length + 1, true));
      itemImages.clear();
      Dio dio = Dio();
      // imageList에 있는 이미지들을 불러옴
      for (int i = 0; i < imageList.length; i++) {
        final response = await dio.get(imageList[i],
            options: Options(responseType: ResponseType.bytes));

        // 이미지 데이터를 바이트 배열로 가져옴
        List<int> imageBytes = response.data;

        // 파일 생성
        Directory cacheDir = await getTemporaryDirectory();
        File imageFile = File('${cacheDir.path}/${Uuid().v4()}.jpg');

        // 파일 쓰기
        await imageFile.writeAsBytes(imageBytes);
        itemImages.add(imageFile);
        isItemImagesLoading[i] = false;
      }
      // 이미지 리스트가 갱신되었으므로 상태변경됨을 알림
      itemImages.refresh();
    }

    if (isItemSailEnabled.value == true) {
      itemPriceController.text =
          exhibitionItem.price.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              );
      itemTitleController.text = exhibitionItem.title;
      itemDescriptionController.text = exhibitionItem.description;
      amount.value = exhibitionItem.currentAmount!;

      isItemVideoLoading.value = true;
      // 비디오 불러오기
      Dio dio = Dio();
      final response = await dio.get(exhibitionItem.shorts!,
          options: Options(responseType: ResponseType.bytes));

      // 동영상 데이터를 바이트 배열로 가져옴
      List<int> videoBytes = response.data;

      // 파일 생성
      final cacheDir = await getTemporaryDirectory();
      File videoFile = File('${cacheDir.path}/temp_video.mp4');

      // 파일 쓰기
      await videoFile.writeAsBytes(videoBytes);
      itemVideo.assignAll([videoFile]);

      final thumbnailData =
          await VideoThumbnail.thumbnailData(video: videoFile.path);
      // thumbnail 변수에 썸네일 추가
      if (thumbnailData != null) {
        thumbnail.value = thumbnailData;
      }
      isItemVideoLoading.value = false;
    }
  }

  Future<void> fetchExhibitionItemsById(int exhibitionId) async {
    exhibitionItems.value =
        await repository.fetchExhibitionItemById(exhibitionId);
  }

  Future<dynamic> saveExhibitionIntroductionById(int exhibitionId) async {
    String title = exhibitionTitleController.text;
    String artistName = sellerNameController.text;
    final formData = FormData.fromMap({
      'title': title,
      'artist_name': artistName,
      'cover_image': await MultipartFile.fromFile(
        exhibitionImage.first.path,
        filename: exhibitionImage.first.path.split('/').last,
      ),
    });
    final response =
        await repository.saveExhibitionIntroductionById(exhibitionId, formData);

    if (response.statusCode != 200) {
      Get.snackbar(
        '기획전 소개 저장 실패',
        '기획전 소개 저장에 실패하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await fetchExhibitionById(exhibitionId);
      await fetchSellerExhibitions();
      Get.toNamed(
        Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE,
        arguments: {"exhibition_id": Get.arguments["exhibition_id"]},
      );
    }
  }

  Future<dynamic> saveExhibitionArtistById(int exhibitionId) async {
    bool isTemplate = isSellerTemplateUsed.value;
    String biography = sellerIntroductionController.text;
    String fontFamily = displayedSellerIntroductionFont.value.toString();
    String backgroundColor = selectedSellerIntroductionColor.value.toString();
    final formData = FormData.fromMap({
      'is_template': isTemplate,
      'biography': biography,
      'font_family': fontFamily,
      'background_color': backgroundColor,
      'artist_image': await MultipartFile.fromFile(
        sellerImage.first.path,
        filename: sellerImage.first.path.split('/').last,
      ),
    });
    final response =
        await repository.saveExhibitionArtistById(exhibitionId, formData);
    if (response.statusCode != 200) {
      Get.snackbar(
        '기획전 작가정보 저장 실패',
        '기획전 작가정보 저장에 실패하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await fetchExhibitionById(exhibitionId);
      Get.toNamed(
        Routes.SELLER_EXHIBITION_CREATE_SELLER_COMPLETE,
        arguments: {'exhibition_id': Get.arguments['exhibition_id']},
      );
    }
  }

  Future<dynamic> createExhibitionItemById(int exhibitionId) async {
    bool isCustom = !isItemTemplateUsed.value;
    int template = selectedTemplateIndex.value;
    bool isSale = isItemSailEnabled.value;
    String title =
        isCustom ? (isSale ? itemTitle.value : '') : templateTitle.value;
    String description = isCustom
        ? (isSale ? itemDescription.value : '')
        : templateDescription.value;
    String backgroundColor = selectedItemBackgroundColor.value.toString();
    String fontFamily = displayedItemFont.value.toString();
    int price = int.tryParse(itemPriceController.text.replaceAll(',', '')) ?? 0;
    String? shortsUrl;
    String? soundUrl;

    if (itemVideo.isNotEmpty && isSale) {
      var response = await repository
          .getPreSignedShortsUrl(itemVideo.first.path.split('.').last);

      if (response.statusCode != 200) {
        Get.snackbar(
          '작품 등록 실패',
          '작품 등록에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      String presignedUrl = response.data['url'];
      Map<String, dynamic> payload = response.data['fields'];
      shortsUrl = payload['key'];
      payload.addAll({
        'file': await MultipartFile.fromFile(
          itemVideo.first.path,
          filename: itemVideo.first.path.split('/').last,
        ),
      });

      var uploadResponse = await Dio().post(
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
    }

    if (itemAudio.isNotEmpty) {
      var response = await repository
          .getPreSignedSoundUrl(itemAudio.first.path.split('.').last);

      if (response.statusCode != 200) {
        Get.snackbar(
          '작품 등록 실패',
          '작품 등록에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      String presignedUrl = response.data['url'];
      Map<String, dynamic> payload = response.data['fields'];
      soundUrl = payload['key'];
      payload.addAll({
        'file': await MultipartFile.fromFile(
          itemAudio.first.path,
          filename: itemAudio.first.path.split('/').last,
        ),
      });

      var uploadResponse = await Dio().post(
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
    }

    final formData = FormData.fromMap({
      'is_custom': isCustom,
      'template': isCustom ? null : template,
      'title': title,
      'description': description,
      'background_color': backgroundColor,
      'font_family': fontFamily,
      'is_sale': isSale,
      'position': exhibitionItems.length + 1,
      'price': price,
      'amount': amount.value,
      'shorts_url': shortsUrl,
      'sound': soundUrl,
    });

    List<MapEntry<String, MultipartFile>> imageList = [];
    if (isCustom == false) {
      for (int i = 0; i < templateItemImages.length; i++) {
        imageList.add(MapEntry(
          'images',
          await MultipartFile.fromFile(
            templateItemImages[i]!.path,
            filename: templateItemImages[i]!.path.split('/').last,
          ),
        ));
      }
    } else {
      for (int i = 0; i < itemImages.length; i++) {
        imageList.add(MapEntry(
          'images',
          await MultipartFile.fromFile(
            itemImages[i].path,
            filename: itemImages[i].path.split('/').last,
          ),
        ));
      }
    }
    formData.files.addAll(imageList);
    try {
      final response =
          await repository.createExhibitionItemById(exhibitionId, formData);
      if (response.statusCode == 201) {
        Get.snackbar(
          '작품 등록',
          '작품이 성공적으로 등록되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
        );
        initItemInfo();
        await fetchExhibitionItemsById(Get.arguments['exhibition_id']);
        await fetchExhibitionById(exhibitionId);
        Get.until((route) =>
            Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE);
      } else {
        Get.snackbar(
          '작품 등록 실패',
          '작품 등록에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        '작품 등록 실패',
        '작품 등록 중 오류가 발생하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<dynamic> editExhibitionItemById(int exhibitionId, int itemId) async {
    bool isCustom = !isItemTemplateUsed.value;
    int template = selectedTemplateIndex.value;
    bool isSale = isItemSailEnabled.value;
    String title =
        isCustom ? (isSale ? itemTitle.value : '') : templateTitle.value;
    String description = isCustom
        ? (isSale ? itemDescription.value : '')
        : templateDescription.value;
    String backgroundColor = selectedItemBackgroundColor.value.toString();
    String fontFamily = displayedItemFont.value.toString();
    int price = int.tryParse(itemPriceController.text.replaceAll(',', '')) ?? 0;
    String? shortsUrl;
    String? soundUrl;

    if (itemVideo.isNotEmpty && isSale) {
      var response = await repository
          .getPreSignedShortsUrl(itemVideo.first.path.split('.').last);

      if (response.statusCode != 200) {
        Get.snackbar(
          '작품 수정 실패',
          '작품 수정에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      String presignedUrl = response.data['url'];
      Map<String, dynamic> payload = response.data['fields'];
      shortsUrl = payload['key'];
      payload.addAll({
        'file': await MultipartFile.fromFile(
          itemVideo.first.path,
          filename: itemVideo.first.path.split('/').last,
        ),
      });

      var uploadResponse = await Dio().post(
        presignedUrl,
        data: FormData.fromMap(payload),
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (uploadResponse.statusCode != 204) {
        Get.snackbar(
          '작품 수정 실패',
          '작품 수정에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    if (itemAudio.isNotEmpty) {
      var response = await repository
          .getPreSignedSoundUrl(itemAudio.first.path.split('.').last);

      if (response.statusCode != 200) {
        Get.snackbar(
          '작품 수정 실패',
          '작품 수정에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      String presignedUrl = response.data['url'];
      Map<String, dynamic> payload = response.data['fields'];
      soundUrl = payload['key'];
      payload.addAll({
        'file': await MultipartFile.fromFile(
          itemAudio.first.path,
          filename: itemAudio.first.path.split('/').last,
        ),
      });

      var uploadResponse = await Dio().post(
        presignedUrl,
        data: FormData.fromMap(payload),
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (uploadResponse.statusCode != 204) {
        Get.snackbar(
          '작품 수정 실패',
          '작품 수정에 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    final formData = FormData.fromMap({
      'is_custom': isCustom,
      'template': isCustom ? null : template,
      'title': title,
      'description': description,
      'background_color': backgroundColor,
      'font_family': fontFamily,
      'is_sale': isSale,
      'position': exhibitionItems
          .where((element) => element.id == itemId)
          .first
          .position,
      'price': price,
      'amount': amount.value,
      'shorts_url': shortsUrl,
      'sound': soundUrl,
    });

    List<MapEntry<String, MultipartFile>> imageList = [];
    if (isCustom == false) {
      for (int i = 0; i < templateItemImages.length; i++) {
        imageList.add(MapEntry(
          'images',
          await MultipartFile.fromFile(
            templateItemImages[i]!.path,
            filename: templateItemImages[i]!.path.split('/').last,
          ),
        ));
      }
    } else {
      for (int i = 0; i < itemImages.length; i++) {
        imageList.add(MapEntry(
          'images',
          await MultipartFile.fromFile(
            itemImages[i].path,
            filename: itemImages[i].path.split('/').last,
          ),
        ));
      }
    }

    formData.files.addAll(imageList);
    final response =
        await repository.editExhibitionItemById(exhibitionId, itemId, formData);

    if (response.statusCode == 200) {
      Get.snackbar(
        '작품 수정',
        '작품이 성공적으로 수정되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
      initItemInfo();
      await fetchExhibitionItemsById(Get.arguments['exhibition_id']);
      await fetchExhibitionById(exhibitionId);
      Get.until((route) =>
          Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE);
    } else {
      Get.snackbar(
        '작품 수정 실패',
        '작품 수정에 실패하였습니다. 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> selectImages(ImageType imageType, {int? index}) async {
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
      case ImageType.itemWithTemplate:
        pickedFiles = await ImagePicker().pickMultiImage();
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
        isItemImagesLoading
            .assignAll(List.generate(pickedFiles.length, (_) => true));
        break;
      case ImageType.itemWithoutTemplate:
        pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile == null) return;
        isItemImagesLoading.assignAll(List.generate(1, (_) => true));
        break;
      case ImageType.templateItem:
        if (selectedTemplateIndex.value == 1 ||
            selectedTemplateIndex.value == 2 ||
            selectedTemplateIndex.value == 3) {
          pickedFiles = await ImagePicker().pickMultiImage();
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
        } else {
          pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile == null) return;
        }
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
        if (isFileLargerThanMB(totalImageSize, 4)) return;
        break;
      case ImageType.seller:
        final compressedImage = await compressImage(pickedFile!);
        if (compressedImage != null) {
          final compressedFile = File('${pickedFile.path}.compressed.jpg')
            ..writeAsBytesSync(compressedImage);
          totalImageSize = compressedFile.lengthSync();
          if (isFileLargerThanMB(totalImageSize, 4)) return;
          sellerImage.assignAll([compressedFile]);
          isSellerImageLoading.value = false;
        }
        break;
      case ImageType.itemWithTemplate:
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

            index++;
          }
        }
        if (isFileLargerThanMB(totalImageSize, 4)) return;
        itemImages.assignAll(compressedImages);
        break;
      case ImageType.itemWithoutTemplate:
        final compressedImage = await compressImage(pickedFile!);
        if (compressedImage != null) {
          final compressedFile = File('${pickedFile.path}.compressed.jpg')
            ..writeAsBytesSync(compressedImage);
          totalImageSize = compressedFile.lengthSync();
          if (isFileLargerThanMB(totalImageSize, 4)) return;
          itemImages.assignAll([compressedFile]);
          isItemImagesLoading[0] = false;
        }
        break;
      case ImageType.templateItem:
        if (selectedTemplateIndex.value == 1 ||
            selectedTemplateIndex.value == 2 ||
            selectedTemplateIndex.value == 3) {
          Map<int, File> compressedImages = {};
          // 이미지를 하나씩 압축하고 압축한 이미지를 compressedImages에 추가
          // 이미지 크기를 계산하기위해 변수생성
          int templateItemIndex = 0;
          for (final imageFile in pickedFiles) {
            final compressedImage = await compressImage(imageFile);
            if (compressedImage != null) {
              final compressedFile = File('${imageFile.path}.compressed.jpg')
                ..writeAsBytesSync(compressedImage);

              compressedImages[templateItemIndex!] = compressedFile;

              // 이미지 크기를 계산
              totalImageSize += compressedFile.lengthSync();
            }
            templateItemIndex++;
          }
          if (isFileLargerThanMB(totalImageSize, 4)) return;
          templateItemImages.value = compressedImages;
          templateItemImages.refresh();
        } else {
          final compressedImage = await compressImage(pickedFile!);
          if (compressedImage != null) {
            final compressedFile = File('${pickedFile.path}.compressed.jpg')
              ..writeAsBytesSync(compressedImage);
            for (File templateItemImage in templateItemImages.values) {
              totalImageSize += templateItemImage.lengthSync();
            }
            totalImageSize += compressedFile.lengthSync();

            if (isFileLargerThanMB(totalImageSize, 4)) return;

            templateItemImages[index!] = compressedFile;
            templateItemImages.refresh();
          }
        }

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
      case ImageType.itemWithTemplate:
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

  void resetSellerInfo() {
    sellerIntroductionController.clear();
    sellerImage.value = [];
    selectedSellerIntroductionColor.value = 0;
    selectedSellerIntroductionFont.value = 0;
    displayedSellerIntroductionFont.value = 0;
  }

  void resetItemInfo() {
    itemTitleController.clear();
    itemDescriptionController.clear();
    templateTitleController.clear();
    templateDescriptionController.clear();
    itemPriceController.clear();
    thumbnail.value = null;
    itemImages.clear();
    templateItemImages.clear();
    itemVideo.clear();
    itemAudio.clear();
    itemTitle.value = '';
    itemDescription.value = '';
    price.value = 0;
    amount.value = 1;
    isItemSailEnabled.value = false;
    templateTitle.value = '';
    templateDescription.value = '';
    selectedItemBackgroundColor.value = 0;
    selectedItemFont.value = 0;
    displayedItemFont.value = 0;
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

  bool isValidSellerFontReset() {
    return selectedSellerIntroductionFont.value != 0;
  }

  bool isValidItemFontReset() {
    return selectedItemFont.value != 0;
  }

  bool isValidSellerApply() {
    return selectedSellerIntroductionFont.value !=
        displayedSellerIntroductionFont.value;
  }

  bool isValidItemApply() {
    return selectedItemFont.value != displayedItemFont.value;
  }

  void applySellerFont() {
    displayedSellerIntroductionFont.value =
        selectedSellerIntroductionFont.value;
  }

  void applyItemFont() {
    displayedItemFont.value = selectedItemFont.value;
  }

  bool isValidItemNext() {
    if (isItemTemplateUsed.value == true) {
      if (templateTitle.value.isEmpty || templateDescription.isEmpty) {
        return false;
      }
      if (selectedTemplateIndex.value == 1 ||
          selectedTemplateIndex.value == 2 ||
          selectedTemplateIndex.value == 3) {
        if (templateItemImages.isEmpty) {
          return false;
        }
      } else if (selectedTemplateIndex.value == 4 ||
          selectedTemplateIndex.value == 5) {
        if (templateItemImages.length < 4) {
          return false;
        }
      } else if (selectedTemplateIndex.value == 6 ||
          selectedTemplateIndex.value == 7) {
        if (templateItemImages.length < 2) {
          return false;
        } else if (selectedTemplateIndex.value == 8) {
          if (templateItemImages.isEmpty) {
            return false;
          }
        }
      }
      return (isItemSailEnabled.value &&
              itemVideo.isNotEmpty &&
              price.value >= 1000 &&
              price.value <= 1000000 &&
              amount.value > 0) ||
          !isItemSailEnabled.value;
    } else {
      if (itemImages.isEmpty || itemImages.length > 10) {
        return false;
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

  void initItemInfo() {
    resetItemInfo();
    isItemTemplateUsed.value = false;
  }

  bool isValidItemSave() {
    return exhibitionItems.where((element) => element.isSale == true).length >=
        (exhibitionItems.length / 2).ceil();
  }

  Future<void> removeExhibitionItem(int exhibitionId, int itemId) async {
    await repository.removeExhibitionItem(exhibitionId, itemId);
    await fetchExhibitionItemsById(exhibitionId);
  }
}

enum ImageType {
  exhibition,
  seller,
  itemWithTemplate,
  itemWithoutTemplate,
  templateItem
}

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
