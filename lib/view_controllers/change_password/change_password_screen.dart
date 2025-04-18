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
import '../../l10n/app_locale.dart';
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
                    child: RotatedBox(
                      child: SvgPicture.asset('assets/ic-back.svg'),
                      quarterTurns: AppLocale.shared.isArabic() ? 2 : 0,
                    ),
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
                                  textDirection: TextDirection.ltr,
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
                                  textDirection: TextDirection.ltr,
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
                                  textDirection: TextDirection.ltr,
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
                              height: 140,
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

                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: CustomText(
                                  text:
                                      S.of(context).copyRight(getCurrentYear()),
                                  fontSize: 12,
                                  color: AppColors().greyTextColor),
                            ),
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

  String getCurrentYear() {
    return DateTime.now().year.toString();
  }
}
