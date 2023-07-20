import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';

class DioSingleton {
  static Dio? _dioInstance;

  static Dio get dio {
    if (_dioInstance == null) {
      _dioInstance = Dio();
      _dioInstance!.options.baseUrl = "https://dev.leporem.art";
      _dioInstance!.options.validateStatus = (status) {
        return status! < 500;
      };
      _dioInstance!.interceptors.add(InterceptorsWrapper(
        onRequest: (request, handler) async {
          final idToken = await getOAuthToken().then((value) => value!.idToken);
          request.headers['Authorization'] = 'Palindrome $idToken';
          return handler.next(request);
        },
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            Exception("토큰이 만료되었습니다. 토큰을 갱신합니다.");
            await refreshIDToken();
            final idToken =
                await getOAuthToken().then((value) => value!.idToken);
            response.requestOptions.headers['Authorization'] =
                'Palindrome $idToken';
            return handler.next(response);
          }
          if (response.statusCode == 403) {
            Exception("계정의 권한이 없습니다.");
          }
        },
        onError: (error, handler) async {
          if (error.response!.statusCode == 500) {
            Exception("서버에 오류가 발생했습니다.");
          }
        },
      ));
    }
    return _dioInstance!;
  }
}
