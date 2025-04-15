import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:raff/business_managers/api_model/ads/list_ads_response.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/extensions.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/home/controller/home_tab_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                              "${controller.items.length}",
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
                    if (controller.items.isEmpty) {
                      return buildEmptyView(context);
                    }
                    return ListView.builder(
                        itemCount: controller.items.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _getCard(model: controller.items[index]);
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

  Widget _getCard({required AdItem model}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors().borderColor, width: 2)),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: Padding(
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
                        InkWell(
                          onTap: () {
                            launchDialer(model.user?.phoneNumber ?? '');
                          },
                          child: Icon(
                            Icons.phone,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        CustomText(
                            text: model.user?.fullName ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryColor),
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
      ),
    );
  }

  void launchDialer(String number) async {
    if (number.isEmpty) return;
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      launchUrlString('tel://${number}');
    }
  }
}
