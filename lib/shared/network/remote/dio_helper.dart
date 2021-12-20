import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = new Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          //baseUrl: 'http://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'en',
            "Accept": "application/json"
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
      'lang': 'en',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
      'lang': 'en',
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
