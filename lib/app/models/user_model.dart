class UserModel {
  UserModel({
    required this.accessToken,
    required this.user,
    this.passwordSet,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json['accessToken'] as String,
        user: CurrentUser.fromJson(json['user'] as Map<String, dynamic>),
        passwordSet:
            json['passwordSet'] != null ? json['passwordSet'] as bool : null,
      );
  final String accessToken;
  final CurrentUser user;
  final bool? passwordSet;
  // Method to convert the object to JSON
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'user': user.toJson(),
        'passwordSet': passwordSet,
      };
}

class CurrentUser {
  CurrentUser({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.phoneNumber,
    this.deletedAt,
    this.verificationId,
  });

  // Factory method to create an instance from JSON
  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        id: json['id'] as String,
        firstName:
            json['firstName'] != null ? json['firstName'] as String : null,
        lastName: json['lastName'] != null ? json['lastName'] as String : null,
        username: json['username'] != null ? json['username'] as String : null,
        email: json['email'] != null ? json['email'] as String : null,
        phone: json['phone'] != null ? json['phone'] as String : null,
        phoneNumber:
            json['phoneNumber'] != null ? json['phoneNumber'] as String : null,
        status: json['status'] as String,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        deletedAt:
            json['deletedAt'] != null ? json['deletedAt'] as String : null,
        verificationId: json['verificationId'] != null
            ? json['verificationId'] as String
            : null,
      );
  final String id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? phone;
  final String? phoneNumber;
  final String? email;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? verificationId;

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'phone': phone,
        'phoneNumber': phoneNumber,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'verificationId': verificationId,
      };
}
