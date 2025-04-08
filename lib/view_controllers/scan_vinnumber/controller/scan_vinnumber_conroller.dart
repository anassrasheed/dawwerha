import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/vehicle_response/vehicle_model.dart';

class ScanVinNumberController extends GetxController {
  TextEditingController scanController = TextEditingController();
  FocusNode scanNode = FocusNode();
  RxList<Category> categories = <Category>[].obs;
  String vinPattern =
      r'[A-HJ-NPR-Z0-9]{17}'; // Pattern to match 17 characters VIN



  String _getVehicleModelYear(Category category) {
    String result = '';
    if (category.values
        .any((element) => element.key.toLowerCase() == 'model year')) {
      result = category.values
              .firstWhere(
                  (element) => element.key.toLowerCase() == 'model year')
              .value ??
          '';
    }
    return result;
  }

  String _getVehicleMake(Category category) {
    String result = '';
    if (category.values.any((element) => element.key.toLowerCase() == 'make')) {
      result = category.values
              .firstWhere((element) => element.key.toLowerCase() == 'make')
              .value ??
          '';
    }
    return result;
  }

  String _getVehicleModel(Category category) {
    String result = '';
    if (category.values
        .any((element) => element.key.toLowerCase() == 'model')) {
      result = category.values
              .firstWhere((element) => element.key.toLowerCase() == 'model')
              .value ??
          '';
    }
    return result;
  }}
