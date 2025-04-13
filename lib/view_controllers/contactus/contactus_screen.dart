import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raff/view_controllers/contactus/contact_us_controller.dart';
import 'package:sizer/sizer.dart';

import '../../configuration/app_colors.dart';
import '../../generated/l10n.dart';
import '../../l10n/app_locale.dart';
import '../../utils/ui/custom_button.dart';
import '../../utils/ui/custom_container.dart';
import '../../utils/ui/custom_text.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  ContactUsController controller = Get.put(ContactUsController());

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
                  text: S.of(context).contactUs,
                  fontSize: 22,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomText(
                  text: S.of(context).pleaseSelectTheSuitableWayForYouToReachUs,
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
                  child: controller.isFailed.value ||
                          controller.contactInfo.value == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              if (controller
                                  .contactInfo.value!.phoneNumber.isNotEmpty)
                                CustomButton(
                                    context: context,
                                    title: S.of(context).callUs,
                                    width: 100.w,
                                    rawAlignment: MainAxisAlignment.start,
                                    backgroundColor: Colors.white,
                                    borderColor:
                                        AppColors().contactusBorderColor,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    size: 12,
                                    radius: 10,
                                    icon: SvgPicture.asset(
                                      "assets/ic -contact us.svg",
                                    ),
                                    onPressed: () async {
                                      controller.launchDialer();
                                    }),
                              if (controller.contactInfo.value!.whatsapp
                                  .isNotEmpty)
                              SizedBox(
                                height: 12,
                              ),
                              if (controller.contactInfo.value!.whatsapp
                                  .isNotEmpty)
                                CustomButton(
                                    context: context,
                                    title: S.of(context).whatsapp,
                                    width: 100.w,
                                    rawAlignment: MainAxisAlignment.start,
                                    backgroundColor: Colors.white,
                                    borderColor:
                                        AppColors().contactusBorderColor,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    size: 12,
                                    radius: 10,
                                    icon: SvgPicture.asset(
                                      "assets/whatsapp_icon.svg",
                                    ),
                                    onPressed: () {
                                      controller.launchWhatsapp();
                                    }),
                              SizedBox(
                                height: 12,
                              ),
                              if (controller
                                  .contactInfo.value!.email.isNotEmpty)
                                CustomButton(
                                    context: context,
                                    title: S.of(context).email,
                                    width: 100.w,
                                    rawAlignment: MainAxisAlignment.start,
                                    backgroundColor: Colors.white,
                                    borderColor:
                                        AppColors().contactusBorderColor,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    size: 12,
                                    radius: 10,
                                    icon: SvgPicture.asset(
                                      "assets/email_icon.svg",
                                    ),
                                    onPressed: () {
                                      controller.launchEmail();
                                    }),
                              SizedBox(
                                height: 12,
                              ),
                              if (controller
                                  .contactInfo.value!.websiteUrl.isNotEmpty)
                                CustomButton(
                                    context: context,
                                    title: "Website",
                                    width: 100.w,
                                    rawAlignment: MainAxisAlignment.start,
                                    backgroundColor: Colors.white,
                                    borderColor:
                                        AppColors().contactusBorderColor,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    size: 12,
                                    radius: 10,
                                    icon: SvgPicture.asset(
                                      "assets/ic_website.svg",
                                    ),
                                    onPressed: () {
                                      controller.launchWebsite();
                                    }),
                              SizedBox(
                                height: 64,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (controller
                                      .contactInfo.value!.instagram.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        controller.launchInstagram();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/ic_Instagram.svg",
                                      ),
                                    ),
                                  if (controller
                                      .contactInfo.value!.tiktok.isNotEmpty)
                                    SizedBox(
                                      width: 24,
                                    ),
                                  if (controller
                                      .contactInfo.value!.tiktok.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        controller.launchTikTok();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/ic_tiktok.svg",
                                      ),
                                    ),
                                  if (controller
                                      .contactInfo.value!.twitter.isNotEmpty)
                                    SizedBox(
                                      width: 24,
                                    ),
                                  if (controller
                                      .contactInfo.value!.twitter.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        controller.launchTwitter();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/ic_x.svg",
                                      ),
                                    ),
                                  if (controller
                                      .contactInfo.value!.facebook.isNotEmpty)
                                    SizedBox(
                                      width: 24,
                                    ),
                                  if (controller
                                      .contactInfo.value!.facebook.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        controller.launchFacebook();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/ic_facebook.svg",
                                      ),
                                    ),
                                  if (controller
                                      .contactInfo.value!.youtube.isNotEmpty)
                                    SizedBox(
                                      width: 24,
                                    ),
                                  if (controller
                                      .contactInfo.value!.youtube.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        controller.launchYoutubeChannel();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/youtube.svg",
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
