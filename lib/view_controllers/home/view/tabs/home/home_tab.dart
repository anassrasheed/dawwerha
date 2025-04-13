import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/extensions.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/custom_text_field.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/home/controller/home_tab_controller.dart';
import 'package:raff/view_controllers/home/model/vehicle_model.dart';
import 'package:raff/view_controllers/scan_vinnumber/controller/scan_vinnumber_conroller.dart';
import 'package:sizer/sizer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showOverlay.value)
        return Stack(
          children: [
            AbsorbPointer(
              child: _buildScaffold(context),
              absorbing: true,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.black
                      .withOpacity(0.80), // Adjust opacity to match screenshot
                ),
              ),
            ),
          ],
        );
      return _buildScaffold(context);
    });
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
            text: S.of(context).home,
            fontSize: 16,
            // color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true),
      backgroundColor: Colors.white,
      body: KeyboardActions(
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
                focusNode: controller.searchNode,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CustomText(
                          text: S.of(context).welcome,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: (CurrentSession()
                                      .getUser()
                                      ?.user
                                      ?.fullName
                                      ?.getFirstName() ??
                                  '') +
                              ",",
                          fontSize: 16,
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/plastic_header.svg",
                      width: 100.w,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      bottom: 24,
                      right: 7.w,
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              "${controller.carList.length}",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            S.of(context).totalAds,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                AppTextField.shared.createTextField(
                    context: context,
                    focusNode: controller.searchNode,
                    labelText: S.of(context).search,
                    labelStyle: TextStyle(
                        fontSize: 14, color: AppColors().labelTextFieldColor),
                    useLabelInsideField: true,
                    controller: controller.searchController,
                    keyboardType: TextInputType.text,
                    borderRadius: BorderRadius.circular(21),
                    onSubmitted: (v) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    onChanged: (v) {
                      controller.getHistoryByQuery(v);
                    },
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Transform.scale(
                        scale: 0.4,
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          'assets/ic-search.svg',
                        ),
                      ),
                    )),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: S.of(context).plasticAds,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () {
                    if (controller.isLoading.value)
                      return Center(
                          child: ProgressHud.shared.createLoadingView());
                    if (controller.carList.isEmpty) {
                      return buildEmptyView(context);
                    }
                    return ListView.builder(
                        itemCount: controller.carList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _getCard(model: controller.carList[index]);
                        });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/home_empty_img.svg',
            height: 150,
          ),
          SizedBox(
            height: 32,
          ),
          CustomText(
            text: S.of(context).noAdsYet,
            fontSize: 20,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 8,
          ),
          CustomText(
            text: S.of(context).theListIsCurrentlyEmpty,
            fontSize: 16,
            color: AppColors().labelTextFieldColor,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  Widget _getCard({required VehicleHistoryModel model}) {
    return InkWell(
      onTap: () {
        ScanVinNumberController controller = Get.put(ScanVinNumberController());
        controller.scanController.text = model.vehicleNumber;
      },
      child: Container(
        //,BorderSide(color: AppColors().borderColor)

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors().borderColor)),
        margin: EdgeInsets.symmetric(vertical: 7),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: model.vehicleMake +
                      ' ' +
                      model.vehicleModel +
                      ' - ' +
                      model.vehicleModelYear,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              SizedBox(
                height: 16,
              ),
              CustomText(
                  text: model.vehicleNumber,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
