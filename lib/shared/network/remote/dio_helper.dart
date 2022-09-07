import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static initDio() => _dio = Dio(
        BaseOptions(
          baseUrl: 'https://fakestoreapi.com/',
          receiveDataWhenStatusError: true,
        ),
      );

  Future<Response> get({
    required String path,
  }) async =>
      _dio.get(path);
}
