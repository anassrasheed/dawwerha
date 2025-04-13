import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/login/login_response.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/profile/repository/profile_repository.dart';

import '../../../generated/l10n.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode zipCodeNode = FocusNode();
  RxString mobileError = ''.obs;
  RxString nameError = ''.obs;

  void _clearErrorMessages() {
    mobileError.value = '';
    nameError.value = '';
  }

  @override
  void onReady() {
    UserModel model = CurrentSession().getUser()!;

    nameController.text = model.user!.fullName ?? '';
    mobileController.text = model.user!.phoneNumber ?? '';
    super.onReady();
  }

  void onSvePressed() {
    _clearErrorMessages();
    if (nameController.text.isEmpty) {
      nameError.value = S.of(Get.context!).pleaseFillYourName;
      return;
    }
    if (nameController.text.length < 2) {
      nameError.value = S.of(Get.context!).pleaseEnterCorrectName;
      return;
    }
    if (nameController.text.split(' ').length < 2 ||
        nameController.text.split(' ')[1].isEmpty) {
      nameError.value = S.of(Get.context!).pleaseFillYourName;
      return;
    }

    _clearErrorMessages();
    _callUpdateApi();
  }

  Future<void> _callUpdateApi() async {
    ProfileRepository repository = ApiProfileRepository();
    Either<Failure, LoginResponse> result = await repository.updateProfile(
        nameController.text.trim());

    if (result.isLeft) {
      _showErrorDialog(result);
    } else if (result.right.success!) {
      Get.back();
      DialogUtils.showToastView(
          Get.context!, S.of(Get.context!).yourProfileUpdatedSuccessfully,
          type: DialogType.success);
    }
  }

  void _showErrorDialog(Either<Failure, LoginResponse> result) {
    DialogUtils.showErrorDialog(
      title: S.of(Get.context!).warning,
      message: result.left.message,
      context: Get.context!,
    );
  }
}
