import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leporemart/src/configs/login_config.dart';

class DioSingleton {
  static Dio? _dioInstance;

  static Dio get dio {
    if (_dioInstance == null) {
      _dioInstance = Dio();
      _dioInstance!.options.baseUrl = dotenv.get("BASE_URL");
      _dioInstance!.options.validateStatus = (status) {
        return status! < 500;
      };
      _dioInstance!.interceptors.add(
        InterceptorsWrapper(
          onResponse: (response, handler) async {
            if (response.statusCode == 401) {
              Exception('401: Unauthorized');
            } else if (response.statusCode == 403) {
              if (response.data['message'] == 'Expired token') {
                await refreshOAuthToken();
                // 재발급된 토큰을 헤더에 추가
                final idToken =
                    await getOAuthToken().then((value) => value!.idToken);
                response.requestOptions.headers['Authorization'] =
                    'Palindrome $idToken';

                // 원래의 요청을 다시 실행
                try {
                  print(
                      '재발급 후 원래의 요청을 다시 실행합니다. ${response.realUri}에서 오류 $response');
                  return handler.next(await _dioInstance!.request(
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
    }

    return _dioInstance!;
  }
}
