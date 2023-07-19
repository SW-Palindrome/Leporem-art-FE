import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/src/screens/account/agreement_screen.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

enum LoginPlatform {
  facebook,
  google,
  kakao,
  naver,
  apple,
  none, // logout
}

Future<String?> getIDToken() async {
  OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
  print('origin: ${await KakaoSdk.origin}');
  return token?.idToken;
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
    final response = await DioSingleton.dio.get("/users/login/kakao", data: {
      "id_token": await getIDToken(),
    });
    print(response);
    if (response.statusCode == 200) {
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
