import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/utils/helpers/formatters/custom_vin_input_formatter.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_container.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/view_controllers/scan_vinnumber/controller/scan_vinnumber_conroller.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';

class ScanVinNumberScreen extends StatefulWidget {
  final String? vin;
  final VoidCallback? onRescan;

  const ScanVinNumberScreen({super.key, this.vin, this.onRescan});

  @override
  State<ScanVinNumberScreen> createState() => _ScanVinNumberScreenState();
}

class _ScanVinNumberScreenState extends State<ScanVinNumberScreen> {
  ScanVinNumberController controller = Get.put(ScanVinNumberController());

  @override
  void initState() {
    if (widget.vin != null) {
      String vin = widget.vin!.replaceAll(' ', '');
      int lengthToTake = vin.length < 17 ? vin.length : 17;
      controller.scanController.text = CustomInputFormatter()
          .formatEditUpdate(TextEditingValue(text: ''),
              TextEditingValue(text: vin.substring(0, lengthToTake)))
          .text;
    } else {
      controller.scanController.clear();
    }
    super.initState();
  }

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
                    focusNode: controller.scanNode,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset('assets/ic-close.svg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomText(
                    text: S.of(context).scanVehicleVinNumber,
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
                    text:
                        S.of(context).scanYourVehicleVinNumberThroughTheCamera,
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
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            AppTextField.shared.createTextField(
                              context: context,
                              focusNode: controller.scanNode,
                              maxLength: 35,
                              onSubmitted: (v) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              textStyle: GoogleFonts.openSans(fontSize: 17),
                              inputFormatters: [CustomInputFormatter()],
                              borderRadius: BorderRadius.circular(10),
                              labelText: S.of(context).scannedVinNumber,
                              controller: controller.scanController,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            if (widget.onRescan != null)
                              CustomButton(
                                  context: context,
                                  width: 100.w,
                                  title: S.of(context).rescan,
                                  size: 16,
                                  fontWeight: FontWeight.normal,
                                  textColor: AppColors().highlightColor,
                                  borderColor: AppColors.primaryColor,
                                  backgroundColor: Colors.white,
                                  rawAlignment: MainAxisAlignment.center,
                                  icon: SvgPicture.asset('assets/ic-scan.svg'),
                                  onPressed: () {
                                    widget.onRescan!.call();
                                  }),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomButton(
                                context: context,
                                width: 100.w,
                                title: S.of(context).search,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                onPressed: () {
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset('assets/copy_rights.svg'),
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
