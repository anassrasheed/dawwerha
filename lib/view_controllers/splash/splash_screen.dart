import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/splash/splash_controller.dart';
import 'package:video_player/video_player.dart';

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
      body: Center(child: ProgressHud.shared.createLoadingView()),
    );
  }
}
