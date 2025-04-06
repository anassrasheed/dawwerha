import 'dart:convert';

class LoginResponse {
  final bool? success;
  final int? code;
  final String? message;
  final UserModel? user;

  LoginResponse({
    this.success,
    this.code,
    this.message,
    this.user,
  });

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        user:
            json["result"] == null ? null : UserModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": user?.toJson(),
      };
}

class UserModel {
  final String? accessToken;
  final String? tokenType;
  final User? user;

  UserModel({
    this.accessToken,
    this.tokenType,
    this.user,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "tokenType": tokenType,
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final int? zipCode;
  final bool? mustChangePassword;

  User({
    this.id,
    this.fullName,
    this.email,
    this.zipCode,
    this.mustChangePassword,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        zipCode: json["zipCode"],
        mustChangePassword: json["mustChangePassword"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "zipCode": zipCode,
        "mustChangePassword": mustChangePassword,
      };
}
