import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/auth/auth_controller.dart';
import 'package:raff/view_controllers/forgot_password/forgot_password_new_screen.dart';
import 'package:raff/view_controllers/forgot_password/repository/forgot_passowrd_repository.dart';
import 'package:raff/view_controllers/otp/controller/otp_controller.dart';
import 'package:raff/view_controllers/otp/otp_screen.dart';
import 'package:raff/view_controllers/otp/repository/otp_repository.dart';

class ForgotPasswordController extends GetxController {
  FocusNode mobileNode = FocusNode();
  TextEditingController mobileController = TextEditingController();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString mobileError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  void _clearErrors() {
    mobileError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
  }

  void requestResetPasswordOtp() {
    _clearErrors();
    if (mobileController.text.isEmpty) {
      mobileError.value = S.of(Get.context!).pleaseFillYourMobileNumber;
      return;
    }
    if (!isValidMobileNumber(mobileController.text)) {
      mobileError.value = S.of(Get.context!).pleaseEnterValidMobileNumber;
      return;
    }
    _clearErrors();
    _requestOtp();
  }
  bool isValidMobileNumber(String input) {
    if (!GetUtils.isNumericOnly(input)) return false;

    if (input.length == 10 && input[0] == '0') return true;

    if (input.length == 9 && input[0] == '7') return true;

    return false;
  }
  void forgetPasswordRequest(String token) async {
    _clearErrors();
    if (passwordController.text.isEmpty) {
      passwordError.value = S.of(Get.context!).pleaseFillYourPassword;
      return;
    }
    if (passwordController.text.toString().length < 6) {
      passwordError.value = S.of(Get.context!).passwordMustBeAtLeast6Character;
      return;
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = S
          .of(Get.context!)
          .pleaseEnsureThatThePasswordAndConfirmPasswordFieldsMatch;
      return;
    }
    _clearErrors();
    ForgotPasswordRepository repository = ApiForgotPasswordRepository();
    var result = await repository.resetPassword(
        mobileController.text.trim(), passwordController.text, token);
    if (result.isLeft) {
      _showErrorDialog(result.left);
    } else if (result.right.success) {
      AuthController controller = Get.find();
      Get.back();
      Get.back();
      Get.back();
      controller.changeIndex(0);
      controller.showToast(
          message: S.of(Get.context!).yourPasswordResetSuccessfully);
    }
  }

  void _requestOtp() async {
    OtpRepository repository = ApiOtpRepository();
    var result = await repository.requestOtp(
        mobileController.text, OTPType.PASSWORD_RESET);
    if (result.isLeft) {
      _showErrorDialog(result.left);
    } else if (result.right.success) {
      Get.to(() => OtpScreen(
            title: S.of(Get.context!).enterTheOtpCodeSentToYourEmailAddress,
            type: OTPType.PASSWORD_RESET,
            email: mobileController.text,
            onSuccess: (token) async {
              _navigateToResetPasswordScreen(token);
            },
          ));
    }
  }

  void _showErrorDialog(Failure failure) {
    DialogUtils.showErrorDialog(
        title: S.of(Get.context!).warning,
        message: failure.message,
        context: Get.context!,
        callBack: () {
          if (failure.errorCode == 11) {
            var otpController = Get.find<OtpController>();
            otpController.clearOtpField();
          }
        });
  }

  void _navigateToResetPasswordScreen(String token) {
    Get.off(() => ForgotPasswordNewScreen(
          token: token,
        ));
  }
}
