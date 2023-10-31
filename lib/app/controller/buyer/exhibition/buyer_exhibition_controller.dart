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
