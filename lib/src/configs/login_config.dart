import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

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
