import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/splash/splash_controller.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _splashController =
      Get.put(SplashController(), permanent: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CustomText(
              text: S.of(context).thisAppIs,
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            width: 90.w,
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/splash_logo.jpeg',
            height: 200,
            width: 90.w,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: S.of(context).learnActivly,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ],
      ))),
    );
  }
}
