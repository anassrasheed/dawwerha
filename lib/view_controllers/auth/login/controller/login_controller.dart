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
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isRememberMeChecked = false.obs;

  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  @override
  void onInit() async {
    var email = await SecureStorageHelper().read(key: CacheKeys.email);
    if (email.isNotEmpty) {
      emailController.text = email;
    }
    super.onInit();
  }

  @override
  void onReady() async {
    var email = await SecureStorageHelper().read(key: CacheKeys.email);
    if (email.isNotEmpty) {
      emailController.text = email;
    }
    super.onReady();
  }

  void clearEmail() {
    emailController.text = '';
  }

  void changeRememberMeChecked(bool nValue) {
    isRememberMeChecked.value = nValue;
  }

  void _clearErrorMessages() {
    emailError.value = '';
    passwordError.value = '';
  }

  void onLoginPressed() async {
    _clearErrorMessages();
    if (emailController.text.isEmpty) {
      emailError.value = S.of(Get.context!).pleaseFillYourEmail;
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = S.of(Get.context!).pleaseEnterValidEmail;
      return;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = S.of(Get.context!).pleaseFillYourPassword;
      return;
    }
    _clearErrorMessages();
    LoginRepository repository = ApiLoginRepository();
    var result =
        await repository.login(emailController.text, passwordController.text);
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
        .save(key: CacheKeys.email, value: emailController.text);
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
