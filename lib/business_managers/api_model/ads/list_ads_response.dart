import 'dart:convert';

class ListAdsResponse {
  final bool? success;
  final int? code;
  final String? message;
  final List<AdItem>? result;
  final AdItem? item;
  ListAdsResponse({
    this.success,
    this.code,
    this.message,
    this.item,
    this.result,
  });

  factory ListAdsResponse.fromRawJson(String str) =>
      ListAdsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListAdsResponse.fromJson(Map<String, dynamic> json) =>
      ListAdsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<AdItem>.from(json["result"]!.map((x) => AdItem.fromJson(x))),
      );
  factory ListAdsResponse.fromItemJson(Map<String, dynamic> json) =>
      ListAdsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        item: json["result"] == null
            ? null
            : AdItem.fromJson(json["result"]),
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

class AdItem {
  final int? id;
  final String? title;
  final String? description;
  final String? address;
  final User? user;
  final String? imageUrl;
   bool? active;

  AdItem({
    this.id,
    this.title,
    this.description,
    this.address,
    this.user,
    this.imageUrl,
    this.active,
  });

  factory AdItem.fromRawJson(String str) => AdItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdItem.fromJson(Map<String, dynamic> json) => AdItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        imageUrl: json["imageUrl"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "address": address,
        "user": user?.toJson(),
        "imageUrl": imageUrl,
        "active": active,
      };
}

class User {
  final String? fullName;
  final String? phoneNumber;

  User({
    this.fullName,
    this.phoneNumber,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
}
