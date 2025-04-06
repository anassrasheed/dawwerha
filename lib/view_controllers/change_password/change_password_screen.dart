import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/change_password/controller/change_password_controller.dart';
import 'package:sizer/sizer.dart';

import '../../configuration/app_colors.dart';
import '../../generated/l10n.dart';
import '../../utils/ui/custom_container.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController controller = Get.put(ChangePasswordController());

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
                    focusNode: controller.currentPasswordNode,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.newPasswordNode,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.confirmNewPasswordNode,
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
                  child: Container(
                    width: 20.w,
                    color: Colors.transparent,
                    alignment: Alignment.topLeft,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                    child: SvgPicture.asset('assets/ic-back.svg'),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomText(
                    text: S.of(context).changePassword,
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
                    color: Colors.white,
                    textAlign: TextAlign.start,
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
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                                  focusNode: controller.currentPasswordNode,
                                  labelText: S.of(context).currentPassword,
                                  errorText: controller.oldPasswordError.value,
                                  controller:
                                      controller.currentPasswordController,
                                  showPasswordEye: true,
                                  onSubmitted: (v) {
                                    controller.newPasswordNode.requestFocus();
                                  },
                                  inputAction: TextInputAction.next,
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
                                  focusNode: controller.newPasswordNode,
                                  labelText: S.of(context).newPassword,
                                  errorText: controller.newPasswordError.value,
                                  controller: controller.newPasswordController,
                                  showPasswordEye: true,
                                  onSubmitted: (v) {
                                    controller.confirmNewPasswordNode
                                        .requestFocus();
                                  },
                                  inputAction: TextInputAction.next,
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
                                  focusNode: controller.confirmNewPasswordNode,
                                  labelText: S.of(context).retypeNewPassword,
                                  errorText:
                                      controller.confirmNewPasswordError.value,
                                  controller:
                                      controller.confirmNewPasswordController,
                                  showPasswordEye: true,
                                  onSubmitted: (v) {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  inputAction: TextInputAction.done,
                                  prefixIcon: SvgPicture.asset(
                                      'assets/password_icon.svg'),
                                  obscureText: true),
                            ),
                            SizedBox(
                              height: 220,
                            ),
                            CustomButton(
                                context: context,
                                width: 100.w,
                                title: S.of(context).change,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                onPressed: () {
                                  controller.changePassword();
                                }),
                            SizedBox(
                              height: 34,
                            ),
                            // SvgPicture.asset('assets/copy_rights.svg'),
                            // SizedBox(
                            //   height: 1,
                            // ),
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
      // Stack(
      //   children: [
      //     Container(
      //       width: 100.w,
      //       height: 50.h,
      //       child: SvgPicture.asset(
      //         "assets/login_img.svg",
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.topCenter,
      //       child: SingleChildScrollView(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SizedBox(
      //               height: 5.h,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 5.w),
      //               child: SvgPicture.asset('assets/ic-close.svg'),
      //             ),
      //             // Padding(
      //             //     padding: EdgeInsets.only(top: 5.h
      //             //         //    MediaQuery.of(context).viewInsets.bottom / 2
      //             //         )),
      //             SizedBox(
      //               height: 5.h,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 5.w),
      //               child: CustomText(
      //                 text: S.of(context).changePassword,
      //                 fontSize: 22,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             SizedBox(
      //               height: 11,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 5.w),
      //               child: CustomText(
      //                 text: S
      //                     .of(context)
      //                     .pleaseFillInYourInformationBelowToResetYourPassword,
      //                 fontSize: 16,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.normal,
      //               ),
      //             ),
      //             SizedBox(
      //               height: 24,
      //             ),
      //             Container(
      //               width: 100.w,
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(50),
      //                     topRight: Radius.circular(50)),
      //               ),
      //               child: Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   // mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     SizedBox(
      //                       height: 32,
      //                     ),
      //                     AppTextField.shared.createTextField(
      //                         context: context,
      //                         focusNode: _passwordNode,
      //                         labelText: S.of(context).password,
      //                         controller: _passwordController,
      //                         showPasswordEye: true,
      //                         prefixIcon:
      //                             SvgPicture.asset('assets/password_icon.svg'),
      //                         obscureText: true),
      //                     SizedBox(
      //                       height: 24,
      //                     ),
      //                     AppTextField.shared.createTextField(
      //                         context: context,
      //                         focusNode: _confirmPasswordNode,
      //                         labelText: S.of(context).confirmPassword,
      //                         controller: _confirmPasswordController,
      //                         showPasswordEye: true,
      //                         prefixIcon:
      //                             SvgPicture.asset('assets/password_icon.svg'),
      //                         obscureText: true),
      //                     SizedBox(
      //                       height: 40.h,
      //                     ),
      //                     CustomButton(
      //                         context: context,
      //                         width: 100.w,
      //                         title: S.of(context).submit,
      //                         size: 20,
      //                         fontWeight: FontWeight.bold,
      //                         textColor: Colors.white,
      //                         onPressed: () {
      //                           // Get.to(OtpScreen());
      //                         }),
      //                     SizedBox(
      //                       height: 33,
      //                     ),
      //                     SvgPicture.asset('assets/copy_rights.svg'),
      //                     SizedBox(
      //                       height: 2,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
