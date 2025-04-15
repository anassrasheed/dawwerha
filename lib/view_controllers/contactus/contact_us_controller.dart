import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/contact_info/contact_info_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsController extends GetxController {
  late Rx<ContactInfoModel?> contactInfo = Rx<ContactInfoModel?>(null);
  RxBool isFailed = false.obs;

  @override
  void onInit() {
    contactInfo.value = CurrentSession().contactInfo;
    if (contactInfo.value == null) {
      _getContactusInfo();
    }
    super.onInit();
  }

  void _getContactusInfo() async {
    var response = await HttpWrapper(
      context: Get.context,
      showLoading: false,
      url: Apis.contact_info,
    ).get();
    if (response != null && response.body != null) {
      debugPrint(utf8.decode(response.body!));

      if (response.statusCode == 200) {
        ContactInfoResponse model =
            ContactInfoResponse.fromRawJson(utf8.decode(response.body!));
        CurrentSession().contactInfo = model.result;
        contactInfo.value = model.result;
      } else {
        isFailed.value = true;
      }
    }
  }

  void launchDialer() async {
    final Uri phoneUri =
        Uri(scheme: 'tel', path: contactInfo.value!.phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      launchUrlString('tel://${contactInfo.value!.phoneNumber}');
    }
  }

  void launchWhatsapp() async {
    String username = contactInfo.value!.whatsapp.split("phone=").last;
    String url = 'whatsapp://send?phone=$username';
    if (Platform.isIOS) url = 'https://wa.me/$username';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      try {
        await launchUrl(Uri.parse(url));
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  void launchWebsite() async {
    if (await canLaunchUrl(Uri.parse(contactInfo.value!.websiteUrl))) {
      await launchUrl(Uri.parse(contactInfo.value!.websiteUrl));
    } else {
      try {
        await launchUrl(Uri.parse(contactInfo.value!.websiteUrl));
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: contactInfo.value!.email,
      queryParameters: {
        'subject': 'مرحبا دورها',
        'body': "",
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      launchUrlString('mailto://${contactInfo.value!.email}');
    }
  }

  void launchFacebook() async {
    if (await canLaunchUrl(
        Uri.parse(contactInfo.value!.facebook.split("id=")[1]))) {
      await launchUrl(Uri.parse(contactInfo.value!.facebook.split("id=")[1]),
          mode: LaunchMode.externalApplication);
    } else {
      try {
        await launchUrl(Uri.parse(contactInfo.value!.facebook),
            mode: LaunchMode.externalApplication);
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  Future<void> launchYoutubeChannel() async {
    final url = contactInfo.value!.youtube;

    // Try to launch the YouTube app first (using a generic scheme)
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      try {
        await launchUrl(Uri.parse(contactInfo.value!.facebook),
            mode: LaunchMode.externalApplication);
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  void launchInstagram() async {
    String username = contactInfo.value!.instagram.split("/").last;
    if (await canLaunchUrl(Uri.parse('instagram://user?username=$username'))) {
      await launchUrl(Uri.parse('instagram://user?username=$username'));
    } else {
      try {
        await launchUrl(Uri.parse(contactInfo.value!.instagram));
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  void launchTikTok() async {
    if (await canLaunchUrl(Uri.parse(contactInfo.value!.tiktok))) {
      await launchUrl(Uri.parse(contactInfo.value!.tiktok));
    } else {
      try {
        await launchUrl(Uri.parse(contactInfo.value!.tiktok));
      } catch (e) {
        DialogUtils.showToastView(Get.context!, S.of(Get.context!).generalError,
            type: DialogType.warning);
      }
    }
  }

  void launchTwitter() async {
    String url = contactInfo.value!.twitter;
    final Uri twitterAppUri = Uri.parse('twitter://user?screen_name=$url');
    final Uri twitterWebUri = Uri.parse('https://twitter.com/$url');

    if (await canLaunchUrl(twitterAppUri)) {
      await launchUrl(twitterAppUri);
    } else {
      if (await canLaunchUrl(twitterWebUri)) {
        await launchUrl(twitterWebUri);
      } else {
        try {
          await launchUrl(Uri.parse(url));
        } catch (_) {
          DialogUtils.showToastView(
              Get.context!, S.of(Get.context!).generalError,
              type: DialogType.warning);
        }
      }
    }
  }
}
