import 'dart:convert';

class SystemConfigResponse {
  bool? success;
  int? code;
  String? message;
  List<SysConfigModel>? result;

  SystemConfigResponse({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory SystemConfigResponse.fromJson(String str) =>
      SystemConfigResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SystemConfigResponse.fromMap(Map<String, dynamic> json) =>
      SystemConfigResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<SysConfigModel>.from(
                json["result"]!.map((x) => SysConfigModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "code": code,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class SysConfigModel {
  String? key;
  String? value;

  SysConfigModel({
    this.key,
    this.value,
  });

  factory SysConfigModel.fromJson(String str) =>
      SysConfigModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SysConfigModel.fromMap(Map<String, dynamic> json) => SysConfigModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}
