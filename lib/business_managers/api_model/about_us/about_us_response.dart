import 'dart:convert';

class AboutUsResponse {
  final bool success;
  final int code;
  final String message;
  final String result;

  AboutUsResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory AboutUsResponse.fromRawJson(String str) =>
      AboutUsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": result,
      };
}
