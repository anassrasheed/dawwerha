import 'dart:convert';

class IntroResponse {
  final bool? success;
  final int? code;
  final String? message;
  final List<IntroModel>? result;

  IntroResponse({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory IntroResponse.fromRawJson(String str) =>
      IntroResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IntroResponse.fromJson(Map<String, dynamic> json) => IntroResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<IntroModel>.from(
                json["result"]!.map((x) => IntroModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class IntroModel {
  final String? key;
  final String? imageUrl;
  final String? title;
  final String? description;

  IntroModel({
    this.key,
    this.imageUrl,
    this.title,
    this.description,
  });

  factory IntroModel.fromRawJson(String str) =>
      IntroModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        key: json["key"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
      };
}
