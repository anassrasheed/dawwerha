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
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final FocusNode zipCodeNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString nameError = ''.obs;
  RxString zipCodeError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _requestPermission();
  }

  void _clearErrorMessages() {
    emailError.value = '';
    passwordError.value = '';
    nameError.value = '';
    zipCodeError.value = '';
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
    if (passwordController.text.toString().length < 6) {
      passwordError.value = S.of(Get.context!).passwordMustBeAtLeast6Character;
      return;
    }
    if (zipCodeController.text.isEmpty) {
      zipCodeError.value = S.of(Get.context!).pleaseFillYourCountryZipcode;
      return;
    }
    if (zipCodeController.text.length < 3 ||
        zipCodeController.text.length > 10) {
      zipCodeError.value = S.of(Get.context!).pleaseFillCorrectZipcode;
      return;
    }
    _clearErrorMessages();
    OtpRepository repository = ApiOtpRepository();
    var result = await repository.requestOtp(
        emailController.text, OTPType.EMAIL_VERIFICATION);
    if (result.isLeft) {
      _showErrorDialog(result);
    } else if (result.right.success) {
      Get.to(() => OtpScreen(
            title: S.of(Get.context!).enterTheOtpCodeSentToYourEmailAddress,
            type: OTPType.EMAIL_VERIFICATION,
            email: emailController.text,
            onSuccess: (token) async {
              await _callRegisterApi(token);
            },
          ));
    }

    return;
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
    var result = await repository.register(
        emailController.text,
        passwordController.text,
        zipCodeController.text,
        nameController.text,
        token);
    return result;
  }

  void requestOtpApi() {}

  void _clearAllControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    zipCodeController.clear();
  }

  void _requestPermission() async {
    try {
      if (await Permission.location.status == PermissionStatus.granted) {
        await _fillData();
      } else if (await Permission.location.status == PermissionStatus.denied) {
        await Permission.location.request();
        _requestPermission();
      } else if (await Permission.location.status ==
          PermissionStatus.permanentlyDenied) {
        DialogUtils.showDialogWithButtons(
            title: S.of(Get.context!).warning,
            message: S
                .of(Get.context!)
                .pleaseGrantLocationPermissionFromTheAppSettingsToRetrieve,
            context: Get.context!,
            positiveButtonTitle: S.of(Get.context!).openSettings,
            onTap: () async {
              await openAppSettings();
              if (await Permission.location.status == PermissionStatus.granted)
                await _fillData();
            });
      }
    } catch (_) {
      zipCodeController.text = '';
    }
  }

  Future<void> _fillData() async {
    if (await _checkIFGPSIsEnable()) {
      await _fillZipCode();
    } else {
      Geolocator.openLocationSettings();
    }
  }

  Future<void> _fillZipCode() async {
    var position = await Geolocator.getCurrentPosition();
    Placemark place =
        (await placemarkFromCoordinates(position.latitude, position.longitude))
            .first;
    zipCodeController.text = place.postalCode ?? '';
  }

  Future<bool> _checkIFGPSIsEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
