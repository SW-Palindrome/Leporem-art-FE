import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
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

Future<dynamic> fnLoginWithKakaoAccount() async {
  try {
    OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
    print("token : " + token.toString());
    return token;
  } catch (e) {
    print("로그인 실패 " + e.toString());

    return null;
  }
}

Future<void> kakaoLogin() async {
  //true는 액세스 토큰이 이미 존재(최초 회원가입을 진행했을때)
  try {
    AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

    print('이미 액세스 토큰이 존재하므로 로그인을 시도하지 않습니다.');
    getKakaoUserInfo();
  } catch (error) {
    print('액세스 토큰이 존재하지 않습니다. 로그인을 시도합니다.');
    OAuthToken? token = await fnLoginWithKakaoAccount();
    if (token != null) {
      getKakaoUserInfo();
    }
  }
}
