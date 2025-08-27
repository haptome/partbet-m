import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final EncryptedSharedPreferences prefs =
        EncryptedSharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    if (token != null) {
      options.headers['Authorization'] =
          'Bearer $token'; // Add the token to the headers
    }

    super.onRequest(options, handler);
  }
}
