import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/app/data/provider/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/account/agreement/agreement_controller.dart';
import '../controller/common/user_global_info/user_global_info_controller.dart';
import '../ui/app/account/agreement/agreement_screen.dart';
import '../ui/app/common/home/home.dart';

enum LoginPlatform {
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

Future<bool> getLoginProceed() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  bool isLoginProceed = accessToken != null;
  if (isLoginProceed) {
    Dio dio = Dio();
    dio.options.baseUrl = dotenv.get("BASE_URL");
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            Exception('401: Unauthorized $response');
          } else if (response.statusCode == 403) {
            if (response.data['code'] == 'JWT_403_EXPIRED_ACCESSTOKEN') {
              final prefs = await SharedPreferences.getInstance();
              final refreshResponse = await dio.post('/users/refresh',
                  data: {'refresh_token': prefs.getString('refresh_token')});
              prefs.setString(
                  'access_token', refreshResponse.data['data']['access_token']);
              prefs.setString('refresh_token',
                  refreshResponse.data['data']['refresh_token']);
              response.requestOptions.headers['Authorization'] =
                  'Bearer ${prefs.getString('access_token')}';

              // 원래의 요청을 다시 실행
              try {
                return handler.next(await dio.request(
                  response.requestOptions.path,
                  options: Options(
                    method: response.requestOptions.method,
                    headers: response.requestOptions.headers,
                    receiveTimeout: response.requestOptions.receiveTimeout,
                    sendTimeout: response.requestOptions.sendTimeout,
                    responseType: response.requestOptions.responseType,
                    extra: response.requestOptions.extra,
                    validateStatus: response.requestOptions.validateStatus,
                  ),
                ));
              } catch (e) {
                throw Exception('재발급 후 원래의 요청을 다시 실행하는데 실패했습니다. $e');
              }
            }
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          print('에러경로: ${error.response!.realUri}');
          return handler.next(error);
        },
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await dio.get(
      '/users/info/my',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 403 &&
        response.data['code'] == 'JWT_403_INVALID_ACCESSTOKEN') {
      return false;
    }
    UserGlobalInfoController userGlobalInfoController =
        Get.find<UserGlobalInfoController>();
    userGlobalInfoController.userId = response.data['user_id'];
    userGlobalInfoController.userType = UserType.member;
    userGlobalInfoController.nickname = response.data['nickname'];
    userGlobalInfoController.isSeller = response.data['is_seller'];

    return true;
  } else {
    return false;
  }
}

Future<bool> isSignup(LoginPlatform loginPlatform, String code) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = dotenv.get("BASE_URL");
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    late Response response;
    switch (loginPlatform) {
      case LoginPlatform.kakao:
        response = await dio.post(
          "/users/login/kakao",
          data: {
            "id_token": code,
          },
        );
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        response = await dio.get(
          "/users/login/apple",
          queryParameters: {
            "code": code,
          },
        );
        break;
      case LoginPlatform.none:
        break;
    }
    if (response.statusCode == 403) {
      if (response.data['message'] == 'Expired token') {
        print('토큰 만료로 인해 재발급 후 요청');
        // await refreshOAuthToken();
        // response = await dio.post(
        //   "/users/login/kakao",
        //   data: {
        //     "id_token": await getOAuthToken().then((value) => value!.idToken),
        //   },
        // );
      }
    }
    if (response.statusCode == 200) {
      switch (loginPlatform) {
        case LoginPlatform.kakao:
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('access_token', response.data['access_token']);
          prefs.setString('refresh_token', response.data['refresh_token']);
          UserGlobalInfoController userGlobalInfoController =
              Get.find<UserGlobalInfoController>();
          userGlobalInfoController.userId = response.data['user_id'];
          userGlobalInfoController.userType = UserType.member;
          userGlobalInfoController.nickname = response.data['nickname'];
          userGlobalInfoController.isSeller = response.data['is_seller'];
          break;
        case LoginPlatform.naver:
          break;
        case LoginPlatform.apple:
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(
              'access_token', response.data['data']['access_token']);
          prefs.setString(
              'refresh_token', response.data['data']['refresh_token']);
          UserGlobalInfoController userGlobalInfoController =
              Get.find<UserGlobalInfoController>();
          userGlobalInfoController.userId = response.data['data']['user_id'];
          userGlobalInfoController.userType = UserType.member;
          userGlobalInfoController.nickname = response.data['data']['nickname'];
          userGlobalInfoController.isSeller =
              response.data['data']['is_seller'];
          break;
        case LoginPlatform.none:
          break;
      }
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

Future<void> kakaoLogin() async {
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      if (await isSignup(LoginPlatform.kakao,
          await getOAuthToken().then((value) => value!.idToken!))) {
        Get.offAll(HomeScreen(isLoginProceed: true));
      } else {
        Get.to(AgreementScreen());
        Get.put(AgreementController());
      }
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
        if (await isSignup(LoginPlatform.kakao,
            await getOAuthToken().then((value) => value!.idToken!))) {
          Get.offAll(HomeScreen(isLoginProceed: true));
        } else {
          Get.to(AgreementScreen());
          Get.put(AgreementController());
        }
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
      if (await isSignup(LoginPlatform.kakao,
          await getOAuthToken().then((value) => value!.idToken!))) {
        Get.offAll(HomeScreen(isLoginProceed: true));
      } else {
        Get.to(AgreementScreen());
        Get.put(AgreementController());
      }
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
