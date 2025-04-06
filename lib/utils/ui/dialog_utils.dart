import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';
import 'package:raff/l10n/app_locale.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../configuration/app_colors.dart';
import '../../generated/l10n.dart';

class DialogUtils {
  static showErrorDialog(
      {required String title,
      required String message,
      required BuildContext context,
      VoidCallback? callBack,
      String? buttonText}) {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        title: Align(
          alignment: AppLocale.shared.isArabic()
              ? Alignment.topLeft
              : Alignment.topRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffEBF5FA)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/ic-close.svg',
                  color: AppColors.primaryColor,
                  width: 12,
                  height: 12,
                ),
              ),
            ),
          ),
        ),
        content: Container(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset('assets/warning_image.svg'),
              SizedBox(
                height: 30,
              ),
              CustomText(
                text: title,
                color: AppColors().dialogButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              SizedBox(
                height: 12,
              ),
              CustomText(
                text: message,
                color: AppColors().labelTextFieldColor,
                fontSize: 14,
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                context: context,
                title: S.of(context).done,
                width: 100.w,
                backgroundColor: AppColors().dialogButtonColor,
                borderColor: AppColors().dialogButtonColor,
                textColor: Colors.white,
                onPressed: () {
                  if (callBack != null) {
                    Get.back();
                    callBack.call();
                  } else {
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showToastView(BuildContext context, String message,
      {bool isShort = true,
      DialogType type = DialogType.info,
      ToastPosition gravity = ToastPosition.center}) {
    Color backgroundColor = AppColors.primaryColor;

    switch (type) {
      case DialogType.success:
        backgroundColor = Colors.green;
        break;
      case DialogType.info:
        backgroundColor = AppColors.primaryColor;
        break;
      case DialogType.warning:
        backgroundColor = Colors.orangeAccent;
        break;
      case DialogType.error:
        backgroundColor = Colors.red;
        break;
      default:
        {
          backgroundColor = AppColors.primaryColor;
        }
    }

    showToast(
      message,
      position: gravity,
      backgroundColor: backgroundColor,
      radius: 13.0,
      duration: const Duration(seconds: 5),
      textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
      // animationBuilder: const Miui10AnimBuilder(),
    );
  }

  static showSuccessDialog({
    required String title,
    required String message,
    GestureTapCallback? onTap,
    int seconds = 3,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        title: Align(
          alignment: AppLocale.shared.isArabic()
              ? Alignment.topLeft
              : Alignment.topRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffEBF5FA)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/ic-close.svg',
                  color: AppColors.primaryColor,
                  width: 12,
                  height: 12,
                ),
              ),
            ),
          ),
        ),
        content: Container(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Transform.scale(
                child: Lottie.asset(
                  'assets/success_loading.json',
                  height: 70,
                ),
                scale: 4.4,
              ),
              SizedBox(
                height: 30,
              ),
              CustomText(
                text: title,
                color: AppColors().dialogSuccessColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              SizedBox(
                height: 12,
              ),
              CustomText(
                text: message,
                color: AppColors().labelTextFieldColor,
                fontSize: 14,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
    Timer(Duration(seconds: seconds), () {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    });
  }

  static showWarningDialog({
    required String title,
    required String message,
    String? buttonTitle,
    required BuildContext context,
    GestureTapCallback? onTap,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      title: Align(
        alignment: AppLocale.shared.isArabic()
            ? Alignment.topLeft
            : Alignment.topRight,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xffEBF5FA)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/ic-close.svg',
                color: AppColors.primaryColor,
                width: 12,
                height: 12,
              ),
            ),
          ),
        ),
      ),
      content: Container(
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            SvgPicture.asset('assets/warning_image.svg'),
            SizedBox(
              height: 30,
            ),
            CustomText(
              text: title,
              color: AppColors().dialogButtonColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            SizedBox(
              height: 12,
            ),
            CustomText(
              text: message,
              color: AppColors().labelTextFieldColor,
              fontSize: 14,
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              context: context,
              title: buttonTitle ?? S.of(context).done,
              width: 100.w,
              backgroundColor: AppColors().dialogButtonColor,
              borderColor: AppColors().dialogButtonColor,
              textColor: Colors.white,
              onPressed: () {
                if (onTap != null) {
                  Get.back();
                  onTap.call();
                } else {
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  static showDialogWithButtons({
    required String title,
    required String message,
    String? positiveButtonTitle,
    String? negativeButtonTitle = 'Cancel',
    required BuildContext context,
    GestureTapCallback? onTap,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
        title: Align(
          alignment: AppLocale.shared.isArabic()
              ? Alignment.topLeft
              : Alignment.topRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffEBF5FA)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/ic-close.svg',
                  color: AppColors.primaryColor,
                  width: 12,
                  height: 12,
                ),
              ),
            ),
          ),
        ),
        content: Container(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset('assets/warning_image.svg'),
              SizedBox(
                height: 30,
              ),
              CustomText(
                text: title,
                color: AppColors().dialogButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              SizedBox(
                height: 12,
              ),
              CustomText(
                text: message,
                color: AppColors().blackTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    context: context,
                    title: negativeButtonTitle ?? 'Cancel',
                    width: 26.w,
                    backgroundColor: AppColors().dialogButtonColor,
                    borderColor: AppColors().dialogButtonColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    context: context,
                    title: positiveButtonTitle ?? S.of(context).done,
                    width: 26.w,
                    backgroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (onTap != null) {
                        Get.back();
                        onTap.call();
                      } else {
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
