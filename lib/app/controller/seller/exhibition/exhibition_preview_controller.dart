import 'package:get/get.dart';
import 'package:leporemart/app/controller/seller/exhibition/seller_exhibition_controller.dart';

import '../../../data/models/exhibition.dart';
import '../../../data/repositories/exhibition_repository.dart';

class ExhibitionPreviewController extends GetxController {
  final ExhibitionRepository repository;
  ExhibitionPreviewController({required this.repository})
      : assert(repository != null);

  Rx<bool> isLoading = Rx<bool>(false);
  Rx<ExhibitionArtist?> exhibitionArtist = Rx<ExhibitionArtist?>(null);
  RxList<ExhibitionItem> exhibitionItems = RxList<ExhibitionItem>([]);

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

  Exhibition get exhibition => Get.find<SellerExhibitionController>()
      .exhibitions
      .firstWhere((element) => element.id == Get.arguments['exhibition_id']);

  @override
  void onInit() async {
    await fetchExhibitionPreviewInfo(Get.arguments['exhibition_id']);
    super.onInit();
  }

  Future<void> fetchExhibitionPreviewInfo(int exhibitionId) async {
    isLoading.value = true;
    exhibitionArtist.value =
        await repository.fetchExhibitionArtistById(exhibitionId);
    exhibitionItems.value =
        await repository.fetchExhibitionItemById(exhibitionId);
    isLoading.value = false;
  }
}
