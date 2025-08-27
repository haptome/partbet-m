import 'dart:io';

import 'package:dio/dio.dart';
import 'package:partbet/app/core/network/http_formatter.dart';
import 'package:partbet/app/core/network/auth_interceptor.dart';
import 'package:partbet/app/core/network/error_interceptor.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import '../../models/api_resp.dart';

var dio = Dio();

class HttpUtil {
  HttpUtil._();

  static void init() {
    // add interceptors
    dio
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      )
      ..interceptors.add(HttpFormatter())
      ..interceptors.add(ErrorInterceptor())
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(
        InterceptorsWrapper(
          // Do something before request is sent
          //If you want to complete the request and return some custom data, you can resolve a Response object `handler.resolve(response)`.
          //In this way, the request will be terminated, the upper layer then will be called, and the data returned in then will be your custom response.
          //
          //If you want to terminate the request and trigger an error, you can return a `DioError` object, such as `handler.reject(error)`,
          //This request will be aborted and an exception will be triggered, and the upper catchError will be called.
          onRequest: (options, handler) => handler.next(options), //contiune
          // Do something with response data
          // In this way, the request will be aborted and an exception will be triggered, and the upper catch error will be called.
          onResponse: (response, handler) => handler.next(response), //contiune
          // Do something with response error
          //If you want to complete the request and return some custom data, you can resolve a `Response`, such as `handler.resolve(response)`.
          //In this way, the request will be terminated, the upper layer then will be called, and the data returned in then will be your custom response.
          onError: (DioException e, handler) => handler.next(e), //contiune
        ),
      );

    // dio.options.baseUrl = Config.jekyllApiUrl();

    dio.options.connectTimeout = const Duration(milliseconds: 300000); //30s
    dio.options.receiveTimeout = const Duration(milliseconds: 300000);
  }

  ///
  static Future<dynamic> post(
    String path, {
    Object? data,
    bool showErrorToast = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final result = await dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      final resp = ApiResp.fromJson(result.data!);
      if (resp.errCode == 0) {
        return resp.data;
      } else {
        if (showErrorToast) {}

        return Future.error(resp.errMsg);
      }
    } catch (error) {
      return Future.error(error);
    }
  }



  static Future<dynamic> download(
    String url, {
    required String cachePath,
    CancelToken? cancelToken,
    dynamic Function(int count, int total)? onProgress,
  }) =>
      dio.download(
        url,
        cachePath,
        cancelToken: cancelToken,
        onReceiveProgress: onProgress,
      );
}
