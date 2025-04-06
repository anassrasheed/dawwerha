import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/force_update/force_update_model.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/secure_storage_helper.dart';
import 'package:raff/utils/helpers/url_helper.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/auth/auth_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:raff/view_controllers/home/model/vehicle_model.dart';
import 'package:raff/view_controllers/home/repository/force_update_repository.dart';
import 'package:raff/view_controllers/home/repository/vehicle_repository.dart';

class HomeTabController extends GetxController {
  RxList<VehicleHistoryModel> carList = <VehicleHistoryModel>[].obs;
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  RxBool showOverlay = false.obs;
  RxBool isLoading = true.obs;
  RxList<VehicleHistoryModel> carListOriginal = <VehicleHistoryModel>[].obs;

  void changeOverLay() {
    showOverlay.value = !showOverlay.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> checkForForceUpdate() async {
    try {
      ForceUpdateRepository forceUpdateRepository = ApiForceUpdateRepository();
      var result = await forceUpdateRepository.getForceUpdate();
      if (result.isRight) {
        ForceUpdateModel model = result.right;
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final String currentVersion = packageInfo.version;

        if (_isUpdateRequired(currentVersion,
            Platform.isAndroid ? model.androidVersion : model.iosVersion)) {
          DialogUtils.showDialogWithButtons(
              title: model.updateMessageTitle,
              message: model.updateMessageDescription,
              positiveButtonTitle: S.of(Get.context!).update,
              onTap: () {
                UrlHelper.shared.openUrl(
                    url: Platform.isAndroid ? model.androidUrl : model.iosUrl);
              },
              context: Get.context!);
        }
      }
    } catch (e) {}
  }

  bool _isUpdateRequired(String currentVersion, String newVersion) {
    return _compareVersions(currentVersion, newVersion) < 0;
  }
  int _compareVersions(String current, String newVersion) {
    List<String> currentParts = current.split('.');
    List<String> newParts = newVersion.split('.');
    for (int i = 0; i < newParts.length; i++) {
      int currentPart = int.tryParse(currentParts[i] ?? '0') ?? 0;
      int newPart = int.tryParse(newParts[i]) ?? 0;
      if (currentPart < newPart) return -1;
      if (currentPart > newPart) return 1;
    }
    return 0;
  }

  void resetHistory() {
    carList.value = [];
    isLoading.value = true;
  }

  void deleteAccount() async {
    try {
      VehicleRepository repository = ApiVehicleRepository();
      var result = await repository.deleteAccount();
      if (result.isRight) {
        try {
          CurrentSession().userModel = null;
          await SecureStorageHelper().delete(key: CacheKeys.password);
          resetHistory();
        } catch (e) {
          print(e);
        }
        Get.offAll(() => AuthScreen());
      } else {
        DialogUtils.showToastView(Get.context!, result.left.message,
            type: DialogType.error);
      }
    } catch (_) {
      DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
          type: DialogType.error);
    }
  }

  void getHistoryByQuery(String value) {
    if (carListOriginal.isEmpty || value.trim().isEmpty) {
      if (value.trim().isEmpty) {
        carList.value = List.of(carListOriginal);
      }
      return;
    }
    carList.value = carListOriginal
        .where((element) =>
            element.vehicleNumber.toLowerCase().contains(value.toLowerCase()) ||
            element.vehicleMake.toLowerCase().contains(value.toLowerCase()) ||
            element.vehicleModelYear
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            (element.vehicleMake.toLowerCase() +
                    ' ' +
                    element.vehicleModel.toLowerCase() +
                    ' - ' +
                    element.vehicleModelYear.toLowerCase())
                .contains(value.toLowerCase()) ||
            element.vehicleModel.toLowerCase().contains(value.toLowerCase()))
        .toList();
    // if (carList.isEmpty) carList.value = List.of(carListOriginal);
  }

  void getHistoryVehicle() async {
    try {
      VehicleRepository repository = ApiVehicleRepository();
      var result = await repository.getVehicleHistory();
      isLoading.value = false;
      if (result.isRight) {
        carList.value = result.right;
        carListOriginal.value = List.of(carList);
      }
    } catch (_) {
      isLoading.value = false;
    }
  }
}
