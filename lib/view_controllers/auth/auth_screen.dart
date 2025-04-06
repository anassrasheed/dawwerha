import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/view_controllers/auth/auth_controller.dart';

import 'common/auth_common_views.dart';
import 'login/view/login_view.dart';
import 'register/view/register_view.dart';

class AuthScreen extends StatelessWidget with AuthCommonViews {
  AuthScreen({super.key});

  final AuthController controller =
      Get.put<AuthController>(AuthController(), permanent: true);

  // init
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomContainer(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => controller.isLogin
                        ? LoginView(
                            authTypeView: getAuthTypeView((value) {
                            controller.changeIndex(value);
                          }, controller.selectedIndex.value))
                        : RegisterView(
                            authTypeView: getAuthTypeView((value) {
                            controller.changeIndex(value);
                          }, controller.selectedIndex.value)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
