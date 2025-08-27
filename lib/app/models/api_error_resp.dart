class ErrorResponse {
  ErrorResponse({
    this.statusCode,
    this.message,
  });
  // Factory method to create an instance from JSON
  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        statusCode:
            json['statusCode'] != null ? json['statusCode'] as int : null,
        message: json['message'] != null
            ? json['message'] as String
            : 'unknown error',
      );
  final int? statusCode;
  final String? message;
}
