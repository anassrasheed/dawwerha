// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/common/generic_response.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/auth/auth_controller.dart';
import 'package:raff/view_controllers/auth/register/repository/register_repository.dart';
import 'package:raff/view_controllers/otp/controller/otp_controller.dart';
import 'package:raff/view_controllers/otp/otp_screen.dart';
import 'package:raff/view_controllers/otp/repository/otp_repository.dart';

class RegisterController extends GetxController {
  final FocusNode mobileNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  RxString mobileError = ''.obs;
  RxString passwordError = ''.obs;
  RxString nameError = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void _clearErrorMessages() {
    mobileError.value = '';
    passwordError.value = '';
    nameError.value = '';
  }

  void onRegisterPressed() async {
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
    if (passwordController.text.toString().length < 6) {
      passwordError.value = S.of(Get.context!).passwordMustBeAtLeast6Character;
      return;
    }

    if (!isEnglishLettersDigitsAndSymbols(passwordController.text)) {
      passwordError.value =
          S.of(Get.context!).passwordShouldBeOnlyEnglishLetters;
      return;
    }

    _clearErrorMessages();
    OtpRepository repository = ApiOtpRepository();
    var result = await repository.requestOtp(
        mobileController.text, OTPType.EMAIL_VERIFICATION);
    if (result.isLeft) {
      _showErrorDialog(result);
    } else if (result.right.success) {
      Get.to(() => OtpScreen(
            title: S.of(Get.context!).enterTheOtpCodeSentToYourEmailAddress,
            type: OTPType.EMAIL_VERIFICATION,
            email: mobileController.text,
            onSuccess: (token) async {
              await _callRegisterApi(token);
            },
          ));
    }

    return;
  }

  bool isValidMobileNumber(String input) {
    if (!GetUtils.isNumericOnly(input)) return false;

    if (input.length == 10 && input[0] == '0') return true;

    if (input.length == 9 && input[0] == '7') return true;

    return false;
  }

  bool isEnglishLettersDigitsAndSymbols(String input) {
    const allowedSymbols = r"!$%^&*()-_=+";

    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final code = char.codeUnitAt(0);

      final isUppercase = code >= 65 && code <= 90; // A-Z
      final isLowercase = code >= 97 && code <= 122; // a-z
      final isDigit = code >= 48 && code <= 57; // 0-9
      final isAllowedSymbol = allowedSymbols.contains(char);

      if (!(isUppercase || isLowercase || isDigit || isAllowedSymbol)) {
        return false;
      }
    }
    return true;
  }

  Future<void> _callRegisterApi(String token) async {
    RegisterRepository repository = ApiRegisterRepository();
    Either<Failure, GenericResponse> result =
        await _hitRegisterApi(repository, token);

    if (result.isLeft) {
      _showErrorDialog(result);
    } else if (result.right.success) {
      _registerSuccessfully();
    }
  }

  void _registerSuccessfully() {
    _clearAllControllers();
    AuthController controller = Get.find();
    Get.back();
    controller.changeIndex(0);
    controller.showToast();
  }

  void _showErrorDialog(Either<Failure, GenericResponse> result) {
    DialogUtils.showErrorDialog(
        title: S.of(Get.context!).warning,
        message: result.left.message,
        context: Get.context!,
        callBack: () {
          if (result.left.errorCode == 11) {
            var otpController = Get.find<OtpController>();
            otpController.clearOtpField();
          }
        });
  }

  Future<Either<Failure, GenericResponse>> _hitRegisterApi(
      RegisterRepository repository, String token) async {
    var result = await repository.register(mobileController.text,
        passwordController.text, nameController.text, token);
    return result;
  }

  void requestOtpApi() {}

  void _clearAllControllers() {
    nameController.clear();
    mobileController.clear();
    passwordController.clear();
  }
}
