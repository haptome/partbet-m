import 'package:dio/dio.dart';
import 'package:partbet/app/core/network/api_interceport.dart';
import 'package:partbet/app/core/network/http_formatter.dart';
import 'package:partbet/app/utils/env_loader.dart';

class ApiClient {
  ApiClient._(); // Prevents instantiation

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AppInterceptors());
    dio.interceptors.add(
      HttpFormatter(
        includeRequest: true,
        includeRequestHeaders: true,
        includeRequestBody: true,
        includeResponse: true,
        includeResponseHeaders: false,
        includeResponseBody: true,
      ),
    );

    return dio;
  }
}
