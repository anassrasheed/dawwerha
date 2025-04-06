import 'dart:convert';

class ForceUpdateResponse {
  final bool success;
  final int code;
  final String message;
  final ForceUpdateModel result;

  ForceUpdateResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ForceUpdateResponse.fromRawJson(String str) => ForceUpdateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForceUpdateResponse.fromJson(Map<String, dynamic> json) => ForceUpdateResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    result: ForceUpdateModel.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class ForceUpdateModel {
  final String updateMessageTitle;
  final String updateMessageDescription;
  final String androidVersion;
  final String androidUrl;
  final String iosVersion;
  final String iosUrl;

  ForceUpdateModel({
    required this.updateMessageTitle,
    required this.updateMessageDescription,
    required this.androidVersion,
    required this.androidUrl,
    required this.iosVersion,
    required this.iosUrl,
  });

  factory ForceUpdateModel.fromRawJson(String str) => ForceUpdateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForceUpdateModel.fromJson(Map<String, dynamic> json) => ForceUpdateModel(
    updateMessageTitle: json["updateMessageTitle"],
    updateMessageDescription: json["updateMessageDescription"],
    androidVersion: json["androidVersion"],
    androidUrl: json["androidUrl"],
    iosVersion: json["iosVersion"],
    iosUrl: json["iosUrl"],
  );

  Map<String, dynamic> toJson() => {
    "updateMessageTitle": updateMessageTitle,
    "updateMessageDescription": updateMessageDescription,
    "androidVersion": androidVersion,
    "androidUrl": androidUrl,
    "iosVersion": iosVersion,
    "iosUrl": iosUrl,
  };
}
