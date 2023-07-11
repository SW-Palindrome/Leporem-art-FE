import 'package:dio/dio.dart';

class DioSingleton {
  static Dio? _dioInstance;

  static Dio get dio {
    if (_dioInstance == null) {
      _dioInstance = Dio();
      _dioInstance!.options.baseUrl = "https://dev.leporem.art/";
    }
    return _dioInstance!;
  }
}
