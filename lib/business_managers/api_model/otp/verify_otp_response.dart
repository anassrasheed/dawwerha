import 'dart:convert';

class VerifyOtpResponse {
  final bool? success;
  final int? code;
  final String? message;
  final VerifyOtpToken? result;

  VerifyOtpResponse({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory VerifyOtpResponse.fromRawJson(String str) =>
      VerifyOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? null
            : VerifyOtpToken.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": result?.toJson(),
      };
}

class VerifyOtpToken {
  final String? token;

  VerifyOtpToken({
    this.token,
  });

  factory VerifyOtpToken.fromRawJson(String str) =>
      VerifyOtpToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyOtpToken.fromJson(Map<String, dynamic> json) => VerifyOtpToken(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
