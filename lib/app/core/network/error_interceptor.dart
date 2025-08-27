import 'package:dio/dio.dart';
import 'package:partbet/app/shared/widgets/show_custom_toast.dart';
import 'package:toastification/toastification.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle different Dio exception types
    dynamic message;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message =
            'Connection timed out. Please check your internet connection and try again.';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'Server response timed out. Please try again later.';
        break;

      case DioExceptionType.cancel:
        message = 'Request to the server was cancelled.';
        break;

      case DioExceptionType.connectionError:
        message =
            'No internet connection. Please check your internet connection and try again.';
        break;

      case DioExceptionType.badResponse:
        if (message is List && message.isNotEmpty) {
          message = ' ${message[0]}';
        } else {
          message =
              '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Unexpected error occurred.'}';
          message = message == 'error.EXISTS' &&
                  err.response?.data['property'] == 'stripe'
              ? message = 'Already subscribed to this plan'
              : message == 'error.EXISTS'
                  ? message =
                      'Email is already registered. Please use a different email or log in with this email.'
                  : message == 'OTP not found'
                      ? message =
                          'The OTP you entered is incorrect. Please try again.'
                      : message;
        }
        break;

      default:
        message = 'Something went wrong. Please try again.';
        break;
    }
    final statusCode = err.response?.statusCode;
    final requestUri = err.requestOptions.uri.toString();

    // Check if the toast should be suppressed
    if (statusCode == 406 && requestUri.contains('/user-auth/login')) {
      // Skip showing the toast and handle the error silently
      handler.next(err);
      return;
    }
    if (requestUri.contains('/subscription/free-trial')) {
      handler.next(err);
      return;
    }
    if (message != 'Active subscription not found' &&
        message != "Unexpected type <class 'NoneType'>") {
      // Display the message using custom toast
      showCustomToast(
        type: ToastificationType.error,
        title: message.toString(),
      );
    }
    handler.next(err); // Continue with the error handling
  }
}
