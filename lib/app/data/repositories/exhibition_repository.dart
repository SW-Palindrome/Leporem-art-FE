import 'package:dio/dio.dart';

import '../models/exhibition.dart';
import '../provider/api.dart';

class ExhibitionRepository {
  final ApiClient apiClient;
  ExhibitionRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<Exhibition>> fetchSellerExhibitions() async {
    return apiClient.fetchSellerExhibitions();
  }

  Future<List<Exhibition>> fetchBuyerExhibitions() async {
    return apiClient.fetchBuyerExhibitions();
  }

  Future<ExhibitionArtist?> fetchExhibitionArtistById(int exhibitionId) async {
    return apiClient.fetchExhibitionArtistById(exhibitionId);
  }

  Future<List<ExhibitionItem>> fetchExhibitionItemById(int exhibitionId) async {
    return apiClient.fetchExhibitionItemById(exhibitionId);
  }

  Future<void> removeExhibitionItem(int exhibitionId, int itemId) async {
    return apiClient.removeExhibitionItem(exhibitionId, itemId);
  }

  Future<dynamic> saveExhibitionIntroductionById(
      int exhibitionId, FormData formData) {
    return apiClient.saveExhibitionIntroductionById(exhibitionId, formData);
  }

  Future<dynamic> saveExhibitionArtistById(
      int exhibitionId, FormData formData) {
    return apiClient.saveExhibitionArtistById(exhibitionId, formData);
  }

  Future<dynamic> createExhibitionItemById(
      int exhibitionId, FormData formData) {
    return apiClient.createExhibitionItemById(exhibitionId, formData);
  }

  Future<dynamic> editExhibitionItemById(
      int exhibitionId, int itemId, FormData formData) {
    return apiClient.editExhibitionItemById(exhibitionId, itemId, formData);
  }

  Future<dynamic> getPreSignedShortsUrl(String extension) async {
    return await apiClient.getPreSignedShortsUrl(extension);
  }

  Future<dynamic> getPreSignedSoundUrl(String extension) async {
    return await apiClient.getPreSignedSoundUrl(extension);
  }
}
