class LoginRequestModel {
  final String usernameOrEmail;
  final String password;
  final bool rememberMe;

  LoginRequestModel({
    required this.usernameOrEmail,
    required this.password,
    this.rememberMe = true,
  });

  Map<String, dynamic> toJson() => {
        'usernameOrEmail': usernameOrEmail,
        'password': password,
        'rememberMe': rememberMe,
      };
}

class RegisterRequestModel {
  final int accountType;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String description;
  final String whatsapp;
  final String city;
  final String governorate;
  final String postalCode;
  final String password;
  final String confirmPassword;

  RegisterRequestModel({
    required this.accountType,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.description,
    required this.whatsapp,
    required this.city,
    required this.governorate,
    required this.postalCode,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'accountType': accountType,
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'description': description,
        'whatsapp': whatsapp,
        'city': city,
        'governorate': governorate,
        'postalCode': postalCode,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}

class AuthResponseModel {
  final bool success;
  final String message;
  final AuthData? data;

  AuthResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
      );
}

class AuthData {
  final String? token;
  final int? role;

  AuthData({
    this.token,
    this.role,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        token: json['token'],
        role: json['role'],
      );
}