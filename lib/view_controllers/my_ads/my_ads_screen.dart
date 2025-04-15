import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/ads/list_ads_response.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/my_ads/my_ads_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../generated/l10n.dart';
import '../../l10n/app_locale.dart';
import '../../utils/ui/custom_container.dart';
import '../../utils/ui/custom_text.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  MyAdsController controller = Get.put(MyAdsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: Align(
          alignment: Alignment.topCenter,
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
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
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
                  text: S.of(context).myAds,
                  fontSize: 22,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
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
                  child: Obx(
                    () {
                      if (controller.isLoading.value)
                        return Center(
                            child: ProgressHud.shared.createLoadingView());
                      if (controller.items.isEmpty) {
                        return buildEmptyView(context);
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: controller.items.length,
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return _getCard(
                                        model: controller.items[index]);
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCard({required AdItem model}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors().borderColor, width: 2)),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: model.imageUrl ?? '',
                    httpHeaders: {
                      'Authorization':
                          '${CurrentSession().getUser()!.tokenType?.trim() ?? 'Bearer'} ${CurrentSession().getUser()!.accessToken!}'
                    },
                    placeholder: (context, url) =>
                        ProgressHud.shared.createLoadingView(),
                    errorWidget: (context, url, error) {
                      return Container(
                        width: 100.w,
                        height: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade300,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: AppColors.primaryColor,
                            size: 25,
                          ),
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.w,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: S.of(context).adTitle,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                                text: model.title ?? '',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryColor),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: S.of(context).adDescription,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                                text: model.description ?? '',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryColor),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: S.of(context).adAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                                text: model.address ?? '',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryColor),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 2,
                          color: AppColors.primaryColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSwitch(model),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: CustomText(
                                  text: model.active!
                                      ? S.of(context).active
                                      : S.of(context).inactive,
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.normal,
                                  color: model.active!
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    DialogUtils.showDialogWithButtons(
                        title: S.of(context).warning,
                        message: S.of(context).areYouSureYouWantToDeleteThisAd,
                        onTap: () {
                          controller.deleteMyAds(model.id ?? 0);
                        },
                        positiveButtonTitle: S.of(context).confirm,
                        negativeButtonTitle: S.of(context).cancel,
                        context: context);
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
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

  Widget buildSwitch(AdItem item) => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            activeColor: Colors.green,
            value: item.active ?? true,
            onChanged: (value) {
              setState(() {
                item.active = value;
              });
              controller.changeAdStatus(item.id ?? 0);
            }),
      );
}
