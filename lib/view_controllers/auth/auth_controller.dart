import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    super.onInit();
  }

  RxInt selectedIndex = 0.obs;

  void changeIndex(int value) {
    selectedIndex.value = value;
  }

  get isLogin => selectedIndex.value == 0;

  get isRegister => selectedIndex.value == 1;

  void showToast({String? message}) {
    DialogUtils.showToastView(Get.context!,
        message ?? S.of(Get.context!).youCreatedAnAccountSuccessfully,
        isShort: false, gravity: ToastPosition.top, type: DialogType.success);
  }
}
