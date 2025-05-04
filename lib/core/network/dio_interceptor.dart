import 'dart:developer';

import 'package:aspectumai/core/resources/constants.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Error: ${err.message}');
    final responseData = err.response?.data;

    if (responseData != null) {
      log('Error with response: $responseData');
      final errors = responseData?['errors'];

      String errorMessage = 'Unknown error occurred';

      if (errors != null && errors is List && errors.isNotEmpty) {
        errorMessage = errors[0]['message'] ?? errorMessage;
      } else if (responseData['meta']?['message'] != null) {
        errorMessage = responseData['meta']['message'];
      }

      // Create a new DioException with correct message
      final customError = err.copyWith(error: errorMessage);

      handler.next(customError);
      return;
    }

    handler.next(err); // just forward the original error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // const aiKey = String.fromEnvironment('AI_KEY');
    options.baseUrl = ApiConstants.baseUrl;
    // options.headers['Authorization'] = 'Bearer $aiKey';

    log('Request: ${options.method} ${options.path}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response: ${response.statusCode} ${response.statusMessage}');
    log('Data: ${response.data}');

    handler.next(response);
  }
}
