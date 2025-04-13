import 'dart:convert';
import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/l10n/app_locale.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/ads/controller/ads_controller.dart';
import 'package:sizer/sizer.dart';

class AddAdsScreen extends StatefulWidget {
  const AddAdsScreen({super.key});

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  final AdsController controller = Get.put(AdsController());
  final ImagePicker _picker = ImagePicker();

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
                    focusNode: controller.titleFocus,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.descFocus,
                  ),
                  KeyboardActionsItem(
                    focusNode: controller.addressFocus,
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
                    text: S.of(context).addItem,
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
                    text: S.of(context).addYourPlasticItemToBePublished,
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
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            _buildImageView(),
                            SizedBox(
                              height: 32,
                            ),
                            Obx(() => AppTextField.shared.createTextField(
                                  context: context,
                                  focusNode: controller.titleFocus,
                                  labelText: S.of(context).adTitle,
                                  controller: controller.titleController,
                                  errorText: controller.titleError.value,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    controller.descFocus.requestFocus();
                                  },
                                )),
                            SizedBox(
                              height: 32,
                            ),
                            Obx(() => AppTextField.shared.createTextField(
                                  context: context,
                                  focusNode: controller.descFocus,
                                  labelText: S.of(context).adDescription,
                                  controller: controller.descController,
                                  errorText: controller.descError.value,
                                  maxLines: 8,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    controller.addressFocus.requestFocus();
                                  },
                                )),
                            SizedBox(
                              height: 24,
                            ),
                            AppTextField.shared.createTextField(
                              context: context,
                              focusNode: controller.addressFocus,
                              labelText: S.of(context).address,
                              controller: controller.addressController,
                              errorText: controller.addressError.value,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              onSubmitted: (c) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            CustomButton(
                                context: context,
                                width: 100.w,
                                title: S.of(context).save,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                onPressed: () {
                                  controller.saveAds();
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

  Widget _buildImageView() {
    return InkWell(
      onTap: () {
        _pickImage();
      },
      child: Obx(() {
        final image = controller.image.value; // Still using observable
        if (image == null) {
          return Container(
            width: 100.w,
            height: 100,
            decoration: BoxDecoration(
                color: AppColors().borderColor,
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 30,
                  ),
                  CustomText(
                    text: S.of(context).pickImage,
                  ),
                ],
              ),
            ),
          ); // or a placeholder widget
        } else {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(image.path),
                  width: 100.w,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors().lightGreTextColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    )),
                top: 10,
                right: 10,
              )
            ],
          );
        }
      }),
    );
  }

  Future<void> _pickImage() async {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            S.of(context).camera,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: (_) async {
            Navigator.of(context, rootNavigator: true).maybePop();
            var status = await Permission.camera.status;
            if (status.isDenied) {
              await Permission.camera.request();
              _pickImage();
            } else {
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);

              if (photo != null) {
                controller.setPickedImage(photo);
              }
            }
          },
        ),
        BottomSheetAction(
          title: Text(
            S.of(context).gallery,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: (_) async {
            Navigator.of(context, rootNavigator: true).maybePop();
            var status = await Permission.camera.status;
            if (status.isDenied) {
              await Permission.camera.request();
              _pickImage();
            } else {
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                controller.setPickedImage(photo);
              }
            }
          },
        ),
      ],
      cancelAction: CancelAction(
          title: Text(
        S.of(context).cancelAction,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
      )),
    );
  }
}
