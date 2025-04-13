import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/l10n/app_locale.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/profile/controller/profile_controller.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    focusNode: controller.nameNode,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.mobileNode,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.zipCodeNode,
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
                    text: S.of(context).profile,
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
                    text: S.of(context).youCanOnlyEditYourNameAndZipCode,
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
                            Obx(() => AppTextField.shared.createTextField(
                                context: context,
                                focusNode: controller.nameNode,
                                labelText: S.of(context).name,
                                controller: controller.nameController,
                                errorText: controller.nameError.value,
                                keyboardType: TextInputType.name,
                                inputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  controller.zipCodeNode.requestFocus();
                                },
                                prefixIcon:
                                    SvgPicture.asset('assets/ic-name.svg'))),
                            SizedBox(
                              height: 24,
                            ),
                            AppTextField.shared.createTextField(
                              context: context,
                              focusNode: controller.mobileNode,
                              labelText: S.of(context).mobileNumber,
                              controller: controller.mobileController,
                              errorText: controller.mobileError.value,
                              enabled: false,
                              hintText: '079XXXXXXX',
                              keyboardType: TextInputType.phone,
                              inputAction: TextInputAction.next,
                              onSubmitted: (c) {},
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            SizedBox(
                              height: 240,
                            ),
                            CustomButton(
                                context: context,
                                width: 100.w,
                                title: S.of(context).save,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                onPressed: () {
                                  controller.onSvePressed();
                                }),
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
}
