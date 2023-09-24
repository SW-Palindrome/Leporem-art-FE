import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/profile.dart';
import '../../../data/repositories/profile_repository.dart';

class SellerProfileController extends GetxController {
  final ProfileRepository repository;
  SellerProfileController({required this.repository})
      : assert(repository != null);
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
      final fetchSellerProfile = await repository.fetchSellerProfile();
      if (fetchSellerProfile == null) {
        Get.snackbar('요청 오류', '프로필을 불러오는 중 오류가 발생했습니다.');
        return;
      }
      sellerProfile.value = fetchSellerProfile;
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching seller profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
