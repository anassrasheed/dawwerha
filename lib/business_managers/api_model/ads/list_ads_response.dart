import 'dart:convert';

class ListAdsResponse {
  final int? id;
  final String? title;
  final String? description;
  final String? address;
  final User? user;
  final String? imageUrl;
  final bool? active;

  ListAdsResponse({
    this.id,
    this.title,
    this.description,
    this.address,
    this.user,
    this.imageUrl,
    this.active,
  });

  factory ListAdsResponse.fromRawJson(String str) =>
      ListAdsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListAdsResponse.fromJson(Map<String, dynamic> json) =>
      ListAdsResponse(
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
