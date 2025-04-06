import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/secure_storage_helper.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/change_password/repository/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  FocusNode confirmNewPasswordNode = FocusNode();
  FocusNode currentPasswordNode = FocusNode();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  FocusNode newPasswordNode = FocusNode();
  TextEditingController newPasswordController = TextEditingController();

  RxString oldPasswordError = ''.obs;
  RxString newPasswordError = ''.obs;
  RxString confirmNewPasswordError = ''.obs;

  void _clearMessages() {
    oldPasswordError.value = '';
    newPasswordError.value = '';
    confirmNewPasswordError.value = '';
  }

  void changePassword() async {
    _clearMessages();
    if (currentPasswordController.text.isEmpty) {
      oldPasswordError.value = S.of(Get.context!).pleaseFillYourPassword;
      return;
    }
    if (newPasswordController.text.toString().length < 6) {
      newPasswordError.value =
          S.of(Get.context!).passwordMustBeAtLeast6Character;
      return;
    }
    if (confirmNewPasswordController.text.toString().length < 6) {
      confirmNewPasswordError.value =
          S.of(Get.context!).passwordMustBeAtLeast6Character;
      return;
    }

    if (confirmNewPasswordController.text.toString() !=
        newPasswordController.text.toString()) {
      confirmNewPasswordError.value = S
          .of(Get.context!)
          .pleaseEnsureThatThePasswordAndConfirmPasswordFieldsMatch;
      return;
    }
    if (currentPasswordController.text.toString() ==
        newPasswordController.text.toString()) {
      confirmNewPasswordError.value =
          S.of(Get.context!).newPasswordMustBeDifferentFromTheCurrentPassword;
      return;
    }
    _clearMessages();
    ChangePasswordRepository repository = ApiChangePasswordRepository();
    var result = await repository.changePassword(
        currentPasswordController.text, newPasswordController.text);
    if (result.isLeft) {
      _showErrorDialog(result.left);
    } else if (result.right.success) {
      SecureStorageHelper()
          .save(key: CacheKeys.password, value: newPasswordController.text);
      Get.back();
      DialogUtils.showToastView(
          Get.context!, S.of(Get.context!).yourPasswordChangedSuccessfully,
          type: DialogType.success);
    }
  }

  void _showErrorDialog(Failure failure) {
    DialogUtils.showErrorDialog(
      title: S.of(Get.context!).warning,
      message: failure.message,
      context: Get.context!,
    );
  }
}
