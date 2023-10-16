import 'dart:io';

import '../models/profile.dart';
import '../provider/api.dart';

class ProfileRepository {
  final ApiClient apiClient;
  ProfileRepository({required this.apiClient}) : assert(apiClient != null);

  Future<BuyerProfile?> fetchBuyerProfile() async {
    return apiClient.fetchBuyerProfile();
  }

  Future<SellerProfile?> fetchSellerProfile() async {
    return apiClient.fetchSellerProfile();
  }

  Future<SellerProfile?> fetchCreatorProfile(String nickname) async {
    return apiClient.fetchCreatorProfile(nickname);
  }

  Future<void> editBuyerProfile(bool isNicknameChanged,
      bool isProfileImageChanged, String nickname, File profileImage) async {
    await apiClient.editBuyerProfile(
        isNicknameChanged, isProfileImageChanged, nickname, profileImage);
  }

  Future<void> editSellerProfile(
      bool isNicknameChanged,
      bool isProfileImageChanged,
      bool isDescriptionChanged,
      String nickname,
      File profileImage,
      String description) async {
    await apiClient.editSellerProfile(isNicknameChanged, isProfileImageChanged,
        isDescriptionChanged, nickname, profileImage, description);
  }

  Future<void> inactive() async {
    await apiClient.inactive();
  }
}
