import 'package:get/get.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';

class SellerProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  Rx<SellerProfile> sellerProfile = SellerProfile(
    nickname: '-',
    profileImageUrl:
        'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
    itemCount: 0,
    totalTransaction: 0,
    temperature: 100,
    retentionRate: 0.0,
    description: '',
  ).obs;

  Rx<bool> isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      final fetchSellerProfile = await _profileRepository.fetchSellerProfile();
      sellerProfile.value = fetchSellerProfile;
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      print('Error fetching seller profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
