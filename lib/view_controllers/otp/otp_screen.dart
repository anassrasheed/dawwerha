import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/view_controllers/otp/repository/otp_repository.dart';
import 'package:raff/view_controllers/splash/splash_controller.dart';
import 'package:sizer/sizer.dart';

import 'controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final String title;
  final OTPType type;
  final ValueChanged<String> onSuccess; // callback  VoidCallback ()   ValueChanged<String>
  final String email;

  OtpScreen(
      {super.key,
      required this.title,
      required this.type,
      required this.email,
      required this.onSuccess});

  final OtpController _controller = Get.put(OtpController());
  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomContainer(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 7.h,
              ),
              InkWell(
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
                  text: S.of(context).enterOtp,
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
                  text: title,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/ic-pass.svg'),
                                SizedBox(
                                  width: 2.w,
                                ),
                                CustomText(
                                  text: S.of(context).otpCode,
                                  color: AppColors().labelTextFieldColor,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => Directionality(
                                textDirection: TextDirection.ltr,
                                child: OTPTextField(
                                    controller: _controller.otpController.value,
                                    length: 5,
                                    keyboardType: TextInputType.number,
                                    width: MediaQuery.of(context).size.width,
                                    fieldWidth: 12.w,
                                    fieldStyle: FieldStyle.box,
                                    otpFieldStyle: OtpFieldStyle(
                                        backgroundColor: AppColors().borderColor,
                                        borderColor: AppColors().borderColor,
                                        disabledBorderColor:
                                            AppColors().borderColor,
                                        enabledBorderColor:
                                            AppColors().borderColor,
                                        errorBorderColor: AppColors().borderColor,
                                        focusBorderColor:
                                            AppColors().borderColor),
                                    style: TextStyle(fontSize: 15),
                                    onChanged: (pin) {
                                      _controller.changeOtpValue(pin);
                                    },
                                    onCompleted: (pin) {
                                      _controller.changeOtpValue(pin);
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            TimerView(
                              email: email,
                              otpType: type,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            CustomButton(
                                context: context,
                                textColor:Colors.white,
                                onPressed: () {
                                  _controller.verifyOtp(onSuccess, email, type);
                                },
                                title: S.of(context).submit,

                                width: 100.w),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                                text: S.of(context).copyRight(
                                    splashController.getCurrentYear()),
                                fontSize: 12,
                                color: AppColors().greyTextColor),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  final String email;
  final OTPType otpType;

  TimerView({required this.email, required this.otpType});

  final OtpController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              if (_controller.remainingTime.value > 0) return;
              _controller.resendOtp(email, otpType);
            },
            child: CustomText(
              text: S.of(context).resendCode,
              color: _controller.remainingTime.value > 0
                  ? AppColors().greyTextColor
                  : AppColors().highlightColor,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          if (_controller.remainingTime.value > 0) {
            final minutes = _controller.remainingTime.value ~/ 60;
            final seconds = _controller.remainingTime.value % 60;
            final formattedTime =
                '(${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')})';
            return CustomText(
              text: formattedTime,
              color: AppColors().highlightColor,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            );
          } else {
            return SizedBox.shrink(); // Hide the timer when it reaches 0
          }
        }),
      ],
    );
  }
}
