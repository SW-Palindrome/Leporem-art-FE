import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/src/controllers/account_type_controller.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';
import 'package:leporemart/src/controllers/email_controller.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/screens/account/agreement_screen.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

import '../controllers/user_global_info_controller.dart';

enum LoginPlatform {
  facebook,
  google,
  kakao,
  naver,
  apple,
  none, // logout
}

// 로그인 시 받은 accessToken으로 ID 토큰을 얻어옵니다.
Future<OAuthToken?> getOAuthToken() async {
  try {
    OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
    return token;
  } catch (e) {
    return null;
  }
}

// 만료된 ID 토큰을 갱신하는 함수
Future<OAuthToken> refreshOAuthToken() async {
  try {
    OAuthToken? token = await getOAuthToken();

    if (token != null) {
      return await AuthApi.instance.refreshToken(oldToken: token);
    } else {
      throw ("refreshToken is null");
    }
  } catch (e) {
    rethrow;
  }
}

void getKakaoUserInfo() async {
  try {
    User user = await UserApi.instance.me();
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n연령대: ${user.kakaoAccount?.ageRange}'
        '\n성별: ${user.kakaoAccount?.gender}');
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
  }
}

Future<bool> isSignup() async {
  try {
    final response = await DioSingleton.dio.post(
      "/users/login/kakao",
      data: {
        "id_token": await getOAuthToken().then((value) => value!.idToken),
      },
    );
    if (response.statusCode == 200) {
      UserGlobalInfoController userGlobalInfoController =
          Get.find<UserGlobalInfoController>();
      userGlobalInfoController.userId = response.data['user_id'];
      userGlobalInfoController.userType = UserType.member;
      Get.lazyPut(() => MyBottomNavigationbarController());
      Get.lazyPut(() => AgreementController());
      Get.lazyPut(() => AccountTypeController());
      Get.lazyPut(() => EmailController());
      Get.lazyPut(() => NicknameController());
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

Future<void> kakaoLogin() async {
  print('testtestdsf${await isKakaoTalkInstalled()}');
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      await isSignup() ? Get.offAllNamed('/buyer') : Get.to(AgreementScreen());
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        await isSignup()
            ? Get.offAllNamed('/buyer')
            : Get.to(AgreementScreen());
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
      await isSignup() ? Get.offAllNamed('/buyer') : Get.to(AgreementScreen());
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
