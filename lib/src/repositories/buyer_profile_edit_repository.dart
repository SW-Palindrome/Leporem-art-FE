import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/buyer_profile_edit.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class BuyerProfileEditRepository {
  Future<BuyerProfileEdit> fetchBuyerProfileEdit() async {
    try {
      final response = await DioSingleton.dio.get(
        '/buyers/myedit',
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      final data = response.data;
      final BuyerProfileEdit buyerProfileEdit = BuyerProfileEdit.fromJson(data);
      return buyerProfileEdit;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile edit in repository: $e');
      // 목업 데이터 반환
      return mockBuyerProfileEdit;
    }
  }
}

final mockBuyerProfileEdit = BuyerProfileEdit(
  nickname: '불건전한 소환사명',
  profileImageUrl:
      'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
  description: '설명\n설명\n설명\n설명\n설명\n',
);
