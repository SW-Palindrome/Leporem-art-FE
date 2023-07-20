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
            await refreshIDToken();
            final idToken =
                await getOAuthToken().then((value) => value!.idToken);
            response.requestOptions.headers['Authorization'] =
                'Palindrome $idToken';
            return handler.next(response);
          } else {
            return handler.next(response);
          }
        },
        onError: (error, handler) async {},
      ));
    }
    return _dioInstance!;
  }
}
