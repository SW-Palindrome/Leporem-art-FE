import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/profile_repository.dart';
import 'package:logger/logger.dart';

import '../../../data/models/profile.dart';

class BuyerProfileController extends GetxController {
  final ProfileRepository repository;
  BuyerProfileController({required this.repository})
      : assert(repository != null);

  Rx<BuyerProfile> buyerProfile = BuyerProfile(
    nickname: '-',
    profileImage:
        'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
    isSeller: false,
  ).obs;

  Rx<bool> isLoading = true.obs;
  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      final fetchBuyerProfile = await repository.fetchBuyerProfile();
      if (fetchBuyerProfile == null) {
        Get.snackbar('요청 오류', '프로필을 불러올 수 없습니다.');
        return;
      }
      buyerProfile.value = fetchBuyerProfile;
      isLoading.value = false;
    } catch (e) {
      // 에러 처리
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching buyer profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
