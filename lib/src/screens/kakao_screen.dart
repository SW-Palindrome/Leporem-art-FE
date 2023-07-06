import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'dart:developer' as developer;

class KakaoScreen extends StatelessWidget {
  const KakaoScreen({Key? key}) : super(key: key);

  Future<dynamic> fn_loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      developer.log("token : " + token.toString());
      return token;
    } catch (e) {
      developer.log("로그인 실패 " + e.toString());

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
      child: const Text('kakao 로그인'),
      onPressed: () async {
        try {
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

          print('이미 액세스 토큰이 존재하므로 로그인을 시도하지 않습니다.');
          User user = await UserApi.instance.me();
          print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\n연령대: ${user.kakaoAccount?.ageRange}'
              '\n성별: ${user.kakaoAccount?.gender}');
        } catch (error) {
          print('액세스 토큰이 존재하지 않습니다. 로그인을 시도합니다.');
          OAuthToken token = await fn_loginWithKakaoAccount();

          User user = await UserApi.instance.me();
          if (token != null) {
            print('사용자 정보 요청 성공'
                '\n회원번호: ${user.id}'
                '\n연령대: ${user.kakaoAccount?.ageRange}'
                '\n성별: ${user.kakaoAccount?.gender}');
          }
        }
      },
    ));
  }
}
