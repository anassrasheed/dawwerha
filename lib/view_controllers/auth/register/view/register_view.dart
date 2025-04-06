import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/auth/common/auth_common_views.dart';
import 'package:raff/view_controllers/auth/register/controller/register_controller.dart';
import 'package:raff/view_controllers/splash/splash_controller.dart';
import 'package:sizer/sizer.dart';

class RegisterView extends StatelessWidget with AuthCommonViews {
  RegisterView({super.key, required this.authTypeView});

  final Widget authTypeView;
  final RegisterController controller = Get.put(RegisterController());
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
              focusNode: controller.nameNode,
            ),
            KeyboardActionsItem(
              focusNode: controller.emailNode,
            ),
            KeyboardActionsItem(
              focusNode: controller.passwordNode,
            ),
            KeyboardActionsItem(
              focusNode: controller.zipCodeNode,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CustomText(
              text: S.of(context).createYourAccount,
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
              text: S.of(context).pleaseFillYourInformationBelow,
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
                  Obx(() => AppTextField.shared.createTextField(
                      context: context,
                      focusNode: controller.nameNode,
                      labelText: S.of(context).name,
                      controller: controller.nameController,
                      errorText: controller.nameError.value,
                      keyboardType: TextInputType.name,
                      hintText: "e.g: John Doe",
                      inputAction: TextInputAction.next,
                      onSubmitted: (v) {
                        controller.emailNode.requestFocus();
                      },
                      prefixIcon: SvgPicture.asset('assets/ic-name.svg'))),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => AppTextField.shared.createTextField(
                        context: context,
                        focusNode: controller.emailNode,
                        labelText: S.of(context).email,
                        controller: controller.emailController,
                        errorText: controller.emailError.value,
                        keyboardType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          controller.passwordNode.requestFocus();
                        },
                        prefixIcon: SvgPicture.asset('assets/ic-mail.svg')),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => AppTextField.shared.createTextField(
                        context: context,
                        focusNode: controller.passwordNode,
                        labelText: S.of(context).password,
                        controller: controller.passwordController,
                        errorText: controller.passwordError.value,
                        inputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          controller.zipCodeNode.requestFocus();
                        },
                        showPasswordEye: true,
                        prefixIcon:
                            SvgPicture.asset('assets/password_icon.svg'),
                        obscureText: true),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => AppTextField.shared.createTextField(
                        context: context,
                        focusNode: controller.zipCodeNode,
                        labelText: S.of(context).zipCode,
                        controller: controller.zipCodeController,
                        errorText: controller.zipCodeError.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        prefixIcon: SvgPicture.asset('assets/ic-zip.svg'),
                        onSubmitted: (v) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                      context: context,
                      width: 100.w,
                      title: S.of(context).register,
                      size: 20,
                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        controller.onRegisterPressed();
                      },
                      textColor: Colors.white),
                  SizedBox(
                    height: 34,
                  ),
                  CustomText(
                      text: S
                          .of(context)
                          .copyRight(splashController.getCurrentYear()),
                      fontSize: 12,
                      color: AppColors().greyTextColor),
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
