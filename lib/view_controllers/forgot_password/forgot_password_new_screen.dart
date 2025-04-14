import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/forgot_password/controller/forgot_password_controller.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';

class ForgotPasswordNewScreen extends StatelessWidget {
  ForgotPasswordNewScreen({super.key, required this.token});

  final String token;
  final ForgotPasswordController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomContainer(
        child: Align(
          alignment: Alignment.topCenter,
          child: KeyboardActions(
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
                    focusNode: _controller.passwordNode,
                  ),
                  KeyboardActionsItem(
                    focusNode: _controller.confirmPasswordNode,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SvgPicture.asset('assets/ic-close.svg'),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomText(
                    text: S.of(context).forgotPassword,
                    fontSize: 22,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomText(
                    text: S
                        .of(context)
                        .pleaseFillInYourInformationBelowToResetYourPassword,
                    fontSize: 16,
                    textAlign: TextAlign.start,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Obx(
                              () => AppTextField.shared.createTextField(
                                  context: context,
                                  focusNode: _controller.passwordNode,
                                  labelText: S.of(context).password,
                                  controller: _controller.passwordController,
                                  showPasswordEye: true,
                                  textDirection: TextDirection.ltr,
                                  inputAction: TextInputAction.next,
                                  keyboardType: TextInputType.visiblePassword,
                                  onSubmitted: (c) {
                                    _controller.confirmPasswordNode
                                        .requestFocus();
                                  },
                                  errorText: _controller.passwordError.value,
                                  prefixIcon: SvgPicture.asset(
                                      'assets/password_icon.svg'),
                                  obscureText: true),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Obx(
                              () => AppTextField.shared.createTextField(
                                  context: context,
                                  focusNode: _controller.confirmPasswordNode,
                                  textDirection: TextDirection.ltr,
                                  labelText: S.of(context).confirmPassword,
                                  controller:
                                      _controller.confirmPasswordController,
                                  errorText:
                                      _controller.confirmPasswordError.value,
                                  showPasswordEye: true,
                                  inputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  onSubmitted: (c) {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  prefixIcon: SvgPicture.asset(
                                      'assets/password_icon.svg'),
                                  obscureText: true),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            CustomButton(
                                context: context,
                                width: 100.w,
                                title: S.of(context).submit,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                onPressed: () {
                                  _controller.forgetPasswordRequest(token);
                                }),
                            SizedBox(
                              height: 33,
                            ),
                             Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                        text: S
                            .of(context)
                            .copyRight(getCurrentYear()),
                        fontSize: 12,
                        color: AppColors().greyTextColor),
                  ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String getCurrentYear() {
    return DateTime.now().year.toString();
  }
}
