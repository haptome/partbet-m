class EmailVerificationResponse {
  EmailVerificationResponse({required this.verified});

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) =>
      EmailVerificationResponse(
        verified: json['verified'] == true, // Safely extract boolean
      );
  final bool verified;
}

class PasswordUpdateRequest {
  PasswordUpdateRequest({
    required this.oldPassword,
    required this.newPassword,
  });
  final String oldPassword;
  final String newPassword;

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
}

class SignUpWithEmailModel {
  SignUpWithEmailModel({
    required this.email,
    required this.password,
    required this.name,
    required this.deviceId,
    required this.fcmToken,
  });
  final String email;
  final String password;
  final String name;
  final String deviceId;
  final String fcmToken;

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'deviceId': deviceId,
        'fcmToken': fcmToken,
      };
}

class SignUpWithToken {
  SignUpWithToken({
    required this.token,
    required this.deviceId,
    required this.fcmToken,
  });
  final String token;
  final String deviceId;
  final String fcmToken;

  // Convert the object to JSON
  Map<String, dynamic> toJson() =>
      {'token': token, 'deviceId': deviceId, 'fcmToken': fcmToken};
}

class SignInWithEmailAndPasswordModel {
  SignInWithEmailAndPasswordModel({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class ResendOtplModel {
  ResendOtplModel({
    required this.email,
  });
  final String email;
  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class ForgetPasswordModel {
  ForgetPasswordModel({
    required this.email,
  });
  final String email;
  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class ChangePasswordModel {
  ChangePasswordModel({
    required this.email,
    required this.password,
    required this.otp,
  });
  final String email;
  final String password;
  final String otp;
  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': password,
        'OTP': otp,
      };
}

class OtpCheckHandlerModel {
  OtpCheckHandlerModel({
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

class OtpCheckForResetHandlerModel {
  OtpCheckForResetHandlerModel({
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        'email': email,
        'OTP': otp,
      };
}
