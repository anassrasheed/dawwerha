import 'dart:convert';

import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/utils/config_manager/config_manager.dart';

class ContactInfoResponse {
  final bool success;
  final int code;
  final String message;
  final ContactInfoModel result;

  ContactInfoResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ContactInfoResponse.fromRawJson(String str) =>
      ContactInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) =>
      ContactInfoResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: ContactInfoModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": result.toJson(),
      };
}

class ContactInfoModel {
  final String websiteUrl;
  final String phoneNumber;
  final String email;
  final String instagram;
  final String facebook;
  final String twitter;
  final String tiktok;
  final String youtube;
  final String whatsapp;

  ContactInfoModel({
    required this.websiteUrl,
    required this.phoneNumber,
    required this.email,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.tiktok,
    required this.youtube,
    required this.whatsapp,
  });

  factory ContactInfoModel.fromRawJson(String str) =>
      ContactInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) =>
      ContactInfoModel(
        websiteUrl: json["websiteUrl"] ??
            SysConfigManager().getValueFromKey(CacheKeys.defaultWebsite),
        phoneNumber: json["phoneNumber"] ??
            SysConfigManager().getValueFromKey(CacheKeys.defaultMobileNumber),
        email: json["email"] ??
            SysConfigManager().getValueFromKey(CacheKeys.defaultEmail),
        instagram: json["instagram"] ?? '',
        facebook: json["facebook"] ?? '',
        twitter: json["twitter"] ?? '',
        tiktok: json["tiktok"] ?? '',
        youtube: json["youtube"] ?? '',
        whatsapp: json["whatsapp"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "websiteUrl": websiteUrl,
        "phoneNumber": phoneNumber,
        "email": email,
        "instagram": instagram,
        "facebook": facebook,
        "twitter": twitter,
        "tiktok": tiktok,
        "youtube": youtube,
        "whatsapp": whatsapp,
      };
}
