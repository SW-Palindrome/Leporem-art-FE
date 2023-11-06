import 'package:get/get.dart';

import '../../../data/models/exhibition.dart';
import '../../../data/repositories/exhibition_repository.dart';

class BuyerExhibitionController extends GetxController {
  final ExhibitionRepository repository;
  BuyerExhibitionController({required this.repository})
      : assert(repository != null);

  RxList<Exhibition> exhibitions = RxList<Exhibition>([]);
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

  Exhibition get exhibition => exhibitions.firstWhere(
      (element) => element.id == Get.arguments['buyer_exhibition_id']);

  Future<void> fetchBuyerExhibitions() async {
    exhibitions.value = await repository.fetchBuyerExhibitions();
  }

  Future<void> fetchExhibitionArtistById(int exhibitionId) async {
    exhibitionArtist.value =
        await repository.fetchExhibitionArtistById(exhibitionId);
  }

  Future<void> fetchExhibitionItemsById(int exhibitionId) async {
    exhibitionItems.value =
        await repository.fetchExhibitionItemById(exhibitionId);
  }
}
