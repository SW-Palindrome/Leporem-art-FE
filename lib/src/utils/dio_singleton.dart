import 'package:dio/dio.dart';

class DioSingleton {
  static Dio? _dioInstance;

  static Dio get dio {
    if (_dioInstance == null) {
      _dioInstance = Dio();
      _dioInstance!.options.baseUrl = "http://leporem.art/";
      _dioInstance!.options.connectTimeout = Duration(seconds: 5);
      _dioInstance!.options.receiveTimeout = Duration(seconds: 3);
    }
    return _dioInstance!;
  }
}
