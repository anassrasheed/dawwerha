import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/secure_storage_helper.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/auth/login/repository/login_repository.dart';
import 'package:raff/view_controllers/home/view/bottom_nav_bar_screen.dart';

class LoginController extends GetxController {
  final FocusNode mobileNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isRememberMeChecked = false.obs;

  RxString mobileError = ''.obs;
  RxString passwordError = ''.obs;

  @override
  void onInit() async {
    var email = await SecureStorageHelper().read(key: CacheKeys.email);
    if (email.isNotEmpty) {
      mobileController.text = email;
    }
    super.onInit();
  }

  @override
  void onReady() async {
    var email = await SecureStorageHelper().read(key: CacheKeys.email);
    if (email.isNotEmpty) {
      mobileController.text = email;
    }
    super.onReady();
  }

  void clearEmail() {
    mobileController.text = '';
  }

  void changeRememberMeChecked(bool nValue) {
    isRememberMeChecked.value = nValue;
  }

  void _clearErrorMessages() {
    mobileError.value = '';
    passwordError.value = '';
  }

  bool isValidMobileNumber(String input) {
    if (!GetUtils.isNumericOnly(input)) return false;

    if (input.length == 10 && input[0] == '0') return true;

    if (input.length == 9 && input[0] == '7') return true;

    return false;
  }

  void onLoginPressed() async {
    _clearErrorMessages();
    if (mobileController.text.isEmpty) {
      mobileError.value = S.of(Get.context!).pleaseFillYourMobileNumber;
      return;
    }
    if (!isValidMobileNumber(mobileController.text)) {
      mobileError.value = S.of(Get.context!).pleaseEnterValidMobileNumber;
      return;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = S.of(Get.context!).pleaseFillYourPassword;
      return;
    }

    _clearErrorMessages();
    LoginRepository repository = ApiLoginRepository();
    var result =
        await repository.login(mobileController.text, passwordController.text);
    if (result.isLeft) {
      DialogUtils.showErrorDialog(
          title: S.of(Get.context!).warning,
          message: result.left.message,
          context: Get.context!);
    } else {
      if (isRememberMeChecked.value) {
        _saveCredentials();
      }
      CurrentSession().userModel = result.right;
      Get.offAll(() => BottomNavigationScreen());
    }
  }

  _saveCredentials() {
    SecureStorageHelper()
        .save(key: CacheKeys.email, value: mobileController.text);
    SecureStorageHelper()
        .save(key: CacheKeys.password, value: passwordController.text);
  }

// void refreshData() async {
//   LoginRepository repository = ApiLoginRepository();
//   var result = await repository.login(
//       CurrentSession().getUser()!.user!.email!, passwordController.text,
//       showLoading: false);
//   if (result.isRight) {
//     CurrentSession().userModel = result.right;
//   }
// }
}
