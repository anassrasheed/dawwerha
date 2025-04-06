import 'dart:convert';

class VehicleHistoryResponse {
  final bool success;
  final int code;
  final String message;
  final List<VehicleHistoryModel> result;

  VehicleHistoryResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory VehicleHistoryResponse.fromRawJson(String str) =>
      VehicleHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleHistoryResponse.fromJson(Map<String, dynamic> json) =>
      VehicleHistoryResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: List<VehicleHistoryModel>.from(
            json["result"].map((x) => VehicleHistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class VehicleHistoryModel {
  final String vehicleNumber;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleModelYear;
  final DateTime searchTime;

  VehicleHistoryModel({
    required this.vehicleNumber,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleModelYear,
    required this.searchTime,
  });

  factory VehicleHistoryModel.fromRawJson(String str) =>
      VehicleHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleHistoryModel.fromJson(Map<String, dynamic> json) =>
      VehicleHistoryModel(
        vehicleNumber: json["vehicleNumber"],
        vehicleMake: json["vehicleMake"],
        vehicleModel: json["vehicleModel"],
        vehicleModelYear: json["vehicleModelYear"],
        searchTime: DateTime.parse(json["searchTime"]),
      );

  Map<String, dynamic> toJson() => {
        "vehicleNumber": vehicleNumber,
        "vehicleMake": vehicleMake,
        "vehicleModel": vehicleModel,
        "vehicleModelYear": vehicleModelYear,
        "searchTime": searchTime.toIso8601String(),
      };
}
