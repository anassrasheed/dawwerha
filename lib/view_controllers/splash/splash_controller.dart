import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/about_us/about_us_response.dart';
import 'package:raff/business_managers/api_model/contact_info/contact_info_response.dart';
import 'package:raff/business_managers/api_model/intro/intro_response.dart';
import 'package:raff/business_managers/api_model/system_config/sys_config_model.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/configuration/extension.dart';
import 'package:raff/utils/config_manager/config_manager.dart';
import 'package:raff/utils/helpers/secure_storage_helper.dart';
import 'package:raff/utils/helpers/shared_preferences_helper.dart';
import 'package:raff/view_controllers/auth/auth_screen.dart';
import 'package:raff/view_controllers/auth/login/repository/login_repository.dart';
import 'package:raff/view_controllers/home/view/bottom_nav_bar_screen.dart';
import 'package:raff/view_controllers/intro/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NavigateType { home, login, intro, none }

class SplashController extends GetxController {
  String _email = '';
  String _password = '';
  var type = NavigateType.none.obs;
  static const String _firstOpenKey = 'isFirstOpen';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void onInit() async {
    _email = await SecureStorageHelper().read(key: CacheKeys.email);
    _password = await SecureStorageHelper().read(key: CacheKeys.password);

    super.onInit();
    getSysConfig();
    _getContactusInfo();
    _getAboutUsInfo();
    _checkAndRemoveSecureStorage();
  }

  Future<void> _checkAndRemoveSecureStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstOpen = prefs.getBool(_firstOpenKey) ?? true;

      if (isFirstOpen) {
        await _secureStorage.deleteAll();
        await prefs.setBool(_firstOpenKey, false);
      }
    } catch (_) {}
  }

  String getCurrentYear() {
    return DateTime.now().year.toString();
  }

  void onVideoFinished() {
    checkIfReadyToNavigate();
  }

  void _silentLogin({required VoidCallback onFailedLogin}) async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      LoginRepository repository = ApiLoginRepository();
      var result =
          await repository.login(_email, _password, showLoading: false);
      if (result.isLeft) {
        onFailedLogin.call();
      } else {
        CurrentSession().userModel = result.right;
        type.value = NavigateType.home;
        checkIfReadyToNavigate();
      }
    } else {
      onFailedLogin.call();
    }
  }

  void getSysConfig() async {
    await Future.delayed(Duration(seconds: 2));
    var response = await HttpWrapper(
      context: Get.context,
      showLoading: false,
      url: Apis.sysConfig,
    ).get();
    if (response != null && response.body != null) {
      debugPrint(utf8.decode(response.body!));

      if (response.statusCode == 200) {
        SystemConfigResponse model =
            SystemConfigResponse.fromJson(utf8.decode(response.body!));
        SysConfigManager().configs = model.result!;
        bool isIgnoreIntro =
            (await SharedPreferencesHelper.read(key: CacheKeys.isIgnoreIntro))
                .toBool();

        if (!isIgnoreIntro) {
          getIntro();
          // SharedPreferencesHelper.save(
          //   key: CacheKeys.isIgnoreIntro,
          //   value: 'true',
          // );
        } else {
          _silentLogin(onFailedLogin: () {
            type.value = NavigateType.login;
            checkIfReadyToNavigate();
          });
        }
      }
    }
    checkIfReadyToNavigate(); // Check if we are ready to navigate after API finishes
  }

  void getIntro() async {
    var response = await HttpWrapper(
      context: Get.context,
      showLoading: false,
      url: Apis.intro, // Assuming you have an API for intro
    ).get();
    if (response != null && response.body != null) {
      debugPrint(utf8.decode(response.body!));

      if (response.statusCode == 200) {
        IntroResponse model =
            IntroResponse.fromRawJson(utf8.decode(response.body!));
        CurrentSession().intro = model.result!;
        type.value = NavigateType.intro;
        checkIfReadyToNavigate(); // Navigate to Login screen
      } else {
        type.value = NavigateType.login;
        checkIfReadyToNavigate(); // Navigate to Login screen
      }
    } else {
      type.value = NavigateType.login;
      checkIfReadyToNavigate(); // Navigate to Login screen
    }
  }

  void checkIfReadyToNavigate() async {
    if (type.value != NavigateType.none) {
      if (type.value == NavigateType.home) {
        Get.offAll(() => BottomNavigationScreen());
        return;
      } else if (type.value == NavigateType.intro) {
        Get.offAll(() => IntroScreen());
      } else {
        Get.offAll(() => AuthScreen());
      }
      type.value = NavigateType.none;
    }
  }

  void _getContactusInfo() async {
    var response = await HttpWrapper(
      context: Get.context,
      showLoading: false,
      url: Apis.contact_info,
    ).get();
    if (response != null && response.body != null) {
      debugPrint(utf8.decode(response.body!));

      if (response.statusCode == 200) {
        ContactInfoResponse model =
            ContactInfoResponse.fromRawJson(utf8.decode(response.body!));
        CurrentSession().contactInfo = model.result;
      }
    }
  }

  void _getAboutUsInfo() async {
    var response = await HttpWrapper(
      context: Get.context,
      showLoading: false,
      url: Apis.about_info,
    ).get();
    if (response != null && response.body != null) {
      debugPrint(utf8.decode(response.body!));

      if (response.statusCode == 200) {
        AboutUsResponse model =
            AboutUsResponse.fromRawJson(utf8.decode(response.body!));
        CurrentSession().aboutUsText = model.result;
      }
    }
  }
}
