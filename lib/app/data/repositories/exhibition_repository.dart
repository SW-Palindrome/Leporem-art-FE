import '../models/exhibition.dart';
import '../provider/api.dart';

class ExhibitionRepository {
  final ApiClient apiClient;
  ExhibitionRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<Exhibition>> fetchSellerExhibitions() async {
    return apiClient.fetchSellerExhibitions();
  }

  Future<ExhibitionArtist?> fetchExhibitionArtistById(int exhibitionId) async {
    return apiClient.fetchExhibitionArtistById(exhibitionId);
  }

  Future<List<ExhibitionItem>> fetchExhibitionItemById(int exhibitionId) async {
    return apiClient.fetchExhibitionItemById(exhibitionId);
  }
}
