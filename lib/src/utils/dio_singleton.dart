import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/screens/account/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Exception('401: Unauthorized $response');
            } else if (response.statusCode == 403) {
              if (response.data['code'] == 'JWT_403_EXPIRED_ACCESSTOKEN') {
                final prefs = await SharedPreferences.getInstance();
                final refreshResponse = await dio.post('/users/refresh',
                    data: {'refresh_token': prefs.getString('refresh_token')});
                prefs.setString(
                    'access_token', refreshResponse.data['data']['access_token']);
                prefs.setString(
                    'refresh_token', refreshResponse.data['data']['refresh_token']);
                response.requestOptions.headers['Authorization'] =
                    'Bearer ${prefs.getString('access_token')}';

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
