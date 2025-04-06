import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/vehicle_response/vehicle_model.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/config_manager/config_manager.dart';
import 'package:raff/utils/text_recognetion/vin_reader_manager.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/home/controller/home_tab_controller.dart';
import 'package:raff/view_controllers/result/result_screen.dart';
import 'package:raff/view_controllers/scan_vinnumber/repository/scan_vinnumber_repository.dart';

class ScanVinNumberController extends GetxController {
  TextEditingController scanController = TextEditingController();
  FocusNode scanNode = FocusNode();
  RxList<Category> categories = <Category>[].obs;
  String vinPattern =
      r'[A-HJ-NPR-Z0-9]{17}'; // Pattern to match 17 characters VIN

  void getVinNumber({String? nVin}) async {
    //makeValidationOnManualScreen
    bool isValidate = SysConfigManager()
            .getValueFromKey(CacheKeys.makeValidationOnManualScreen)
            .toLowerCase() ==
        'true';
    RegExp regExp = RegExp(vinPattern);
    String vin =
        nVin ?? scanController.text.replaceAll(' - ', '').toUpperCase();
    if (vin.isEmpty) {
      DialogUtils.showWarningDialog(
          title: S.of(Get.context!).warning,
          message: S.of(Get.context!).pleaseFillVinNumber,
          context: Get.context!);
      return;
    } else if (!regExp.hasMatch(vin)) {
      DialogUtils.showWarningDialog(
          title: S.of(Get.context!).warning,
          message: S.of(Get.context!).pleaseFillCorrectVinNumber,
          context: Get.context!);
      return;
    } else if (isValidate && !VinReaderManager().isValidVIN(vin)) {
      DialogUtils.showWarningDialog(
          title: S.of(Get.context!).warning,
          message: S.of(Get.context!).pleaseFillCorrectVinNumber,
          context: Get.context!);
      return;
    }
    ScanVinNumberRepository repository = ApiScanVinNumberRepository();
    var result = await repository.scanVin(vin);
    if (result.isRight) {
      categories.value = result.right;

      print(categories);
      String vehicleName = _getVehicleName(categories);
      String? vehicleType = _getVehicleType(categories);
      await Get.to(ResultScreen(
        categories: categories,
        vin: scanController.text,
        vehicleName: vehicleName,
        vehicleType: vehicleType,
      ));
      if (nVin != null) {
        try {
          HomeTabController homeTabController = Get.find();
          homeTabController.getHistoryVehicle();
        } catch (e) {}
      }
    } else {
      DialogUtils.showErrorDialog(
          title: S.of(Get.context!).warning,
          message: result.left.message,
          context: Get.context!);
    }
  }

  String _getVehicleName(List<Category> categories) {
    try {
      Category category = categories
          .firstWhere((element) => element.category.toLowerCase() == 'general');
      String modelYear = _getVehicleModelYear(
        category,
      );
      String make = _getVehicleMake(category);
      String model = _getVehicleModel(category);
      return modelYear + ' ' + make + ' ' + model;
    } catch (_) {
      return 'Unknown';
    }
  }

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
  }

  String? _getVehicleType(List<Category> categories) {
    try {
      Category category = categories
          .firstWhere((element) => element.category.toLowerCase() == 'general');

      if (category.values
          .any((element) => element.key.toLowerCase() == 'vehicle type')) {
        return category.values
                .firstWhere(
                    (element) => element.key.toLowerCase() == 'vehicle type')
                .value ??
            '';
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
