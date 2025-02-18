import 'package:dio/dio.dart';

class DioInterceptor implements InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error: ${err.message}');

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const key = String.fromEnvironment('AI_KEY');
    options.headers['Authorization'] = 'Bearer $key';

    print('Request: ${options.method} ${options.path}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.statusMessage}');
    print('Data: ${response.data}');

    handler.next(response);
  }
}
