// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromJson(jsonString);

import 'dart:convert';

GenericResponse genericResponseFromJson(String str) => GenericResponse.fromJson(json.decode(str));

String genericResponseToJson(GenericResponse data) => json.encode(data.toJson());

class GenericResponse {
    bool success;
    int code;
    String message;

    GenericResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    factory GenericResponse.fromJson(Map<String, dynamic> json) => GenericResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
    };
}
