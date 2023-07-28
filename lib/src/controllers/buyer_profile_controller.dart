import 'package:get/get.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';

class BuyerProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  Rx<BuyerProfile> buyerProfile = BuyerProfile(
    nickname: '-',
    profileImageUrl:
        'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
    isSeller: false,
  ).obs;

  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      final fetchBuyerProfile = await _profileRepository.fetchBuyerProfile();
      buyerProfile.value = fetchBuyerProfile;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
