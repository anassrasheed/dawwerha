import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_check_box.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/auth/common/auth_common_views.dart';
import 'package:raff/view_controllers/auth/login/controller/login_controller.dart';
import 'package:raff/view_controllers/forgot_password/forgot_password_screen.dart';
import 'package:raff/view_controllers/splash/splash_controller.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget with AuthCommonViews {
  LoginView({super.key, required this.authTypeView});

  final Widget authTypeView;

  final LoginController controller = Get.put(LoginController());
  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      tapOutsideBehavior: TapOutsideBehavior.none,
      disableScroll: true,
      config: KeyboardActionsConfig(
          keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
          keyboardBarColor: Colors.grey[200],
          nextFocus: true,
          defaultDoneWidget: Text(
            S.of(context).done,
            style: TextStyle(
                color: AppColors().blackTextColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            KeyboardActionsItem(
              focusNode: controller.mobileNode,
            ),
            KeyboardActionsItem(
              focusNode: controller.passwordNode,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CustomText(
              text: S.of(context).login,
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CustomText(
              text: S.of(context).pleaseEnterYourCredentialsBelow,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  authTypeView,
                  SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => AppTextField.shared.createTextField(
                        context: context,
                        focusNode: controller.mobileNode,
                        labelText: S.of(context).mobileNumber,
                        controller: controller.mobileController,
                        errorText: controller.mobileError.value,
                        hintText: '079XXXXXXX',
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.phone,
                        inputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          controller.passwordNode.requestFocus();
                        },
                        prefixIcon: Icon(Icons.phone_outlined,color: Colors.grey.shade400,)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => AppTextField.shared.createTextField(
                        context: context,
                        focusNode: controller.passwordNode,
                        labelText: S.of(context).password,
                        inputFormatters: [],
                        textDirection: TextDirection.ltr,
                        errorText: controller.passwordError.value,
                        controller: controller.passwordController,
                        inputAction: TextInputAction.done,
                        showPasswordEye: true,
                        onSubmitted: (v) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        prefixIcon:
                            SvgPicture.asset('assets/password_icon.svg'),
                        obscureText: true),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => CustomCheckBox(
                              onTap: (v) {
                                controller.changeRememberMeChecked(v ?? false);
                              },
                              isChecked: controller.isRememberMeChecked.value,
                              size: 20,
                              isRound: false,
                              radius: 4,
                              checkedColor: AppColors().checkBoxColor,
                              borderColor: AppColors().checkBoxColor,
                              checkedWidget: Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: S.of(context).rememberMe,
                            color: AppColors().lightGreTextColor,
                            fontSize: 16,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ForgotPasswordScreen(),
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceIn);
                        },
                        child: CustomText(
                          text: S.of(context).forgotPassword,
                          color: AppColors().highlightColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  CustomButton(
                      context: context,
                      width: 100.w,
                      title: S.of(context).login,
                      size: 20,
                      onPressed: () {
                        controller.onLoginPressed();
                      },
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white),
                  SizedBox(
                    height: 34,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                        text: S
                            .of(context)
                            .copyRight(splashController.getCurrentYear()),
                        fontSize: 12,
                        color: AppColors().greyTextColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
