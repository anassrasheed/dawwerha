import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/otp/repository/otp_repository.dart';

class OtpController extends GetxController {
  static const int initialTime = 120; // 2 minutes in seconds
  var remainingTime = initialTime.obs;
  Timer? _timer;
  var otpController = OtpFieldController().obs;
  RxString otpValue = ''.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void verifyOtp(
      ValueChanged<String> onSuccess, String email, OTPType type) async {
    if (otpValue.isEmpty || otpValue.value.length < 5) {
      DialogUtils.showErrorDialog(
        title: S.of(Get.context!).warning,
        message: S.of(Get.context!).oneTimePinIsRequired,
        context: Get.context!,
      );
      return;
    }
    OtpRepository repository = ApiOtpRepository();
    var result = await repository.verifyOtp(email, type, otpValue.value);
    if (result.isLeft) {
      DialogUtils.showErrorDialog(
          title: result.left.message,
          message: S.of(Get.context!).plsReEnterOtp,
          context: Get.context!,
          callBack: () {
            if (result.left.errorCode == 10) {
              clearOtpField();
            }
          });
    } else {
      onSuccess.call(result.right.result?.token ?? '');
    }
  }

  void clearOtpField() {
    otpController.value.clear();
  }

  void changeOtpValue(String nValue) {
    otpValue.value = nValue;
  }

  void resendOtp(String email, OTPType otpType) async {
    OtpRepository repository = ApiOtpRepository();
    var result = await repository.requestOtp(email, otpType);
    if (result.isLeft) {
      DialogUtils.showErrorDialog(
          title: result.left.message,
          message: S.of(Get.context!).plsReEnterOtp,
          context: Get.context!);
    } else {
      startTimer();
    }
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    remainingTime.value = initialTime; // Reset the timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    remainingTime.value = initialTime;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
