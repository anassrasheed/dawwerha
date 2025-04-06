import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/configuration/cache_keys.dart';
import 'package:raff/configuration/configuration_keys.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/config_manager/config_manager.dart';
import 'package:raff/utils/helpers/secure_storage_helper.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/about_us/about_us_screen.dart';
import 'package:raff/view_controllers/auth/auth_screen.dart';
import 'package:raff/view_controllers/change_password/change_password_screen.dart';
import 'package:raff/view_controllers/contactus/contactus_screen.dart';
import 'package:raff/view_controllers/home/controller/home_tab_controller.dart';
import 'package:raff/view_controllers/profile/profile_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  HomeTabController controller = Get.find();
  bool _showDeleteAccount = false;

  @override
  void initState() {
    String showDeleteAccount =
        SysConfigManager().getValueFromKey(ConfigKeys.showDeleteAccount);
    _showDeleteAccount = showDeleteAccount.toLowerCase() == 'true';

    super.initState();
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: CustomText(
            text: S.of(context).menu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic-profile.svg",
                      ),
                      title: S.of(context).profile,
                      onTap: () {
                        Get.to(() => ProfileScreen());
                      }),
                  Divider(
                    height: 0,
                  ),
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic -contact us.svg",
                      ),
                      title: S.of(context).contactUs,
                      onTap: () {
                        Get.to(() => ContactUsScreen());
                      }),
                  Divider(
                    height: 0,
                  ), // responsive design
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic-change_pass.svg",
                      ),
                      title: S.of(context).changePassword,
                      onTap: () {
                        Get.to(() => ChangePasswordScreen());
                      }),
                  Divider(
                    height: 0,
                  ),
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic-about us.svg",
                      ),
                      title: S.of(context).aboutUs,
                      onTap: () {
                        Get.to(() => AboutUsScreen());
                      },
                      isExternal: true),
                  Divider(
                    height: 0,
                  ),
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic-terms_7_conditions.svg",
                      ),
                      title: S.of(context).termsConditions,
                      onTap: () async {
                        String url = SysConfigManager()
                            .getValueFromKey(ConfigKeys.termsAndConditionsUrl);
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          await launchUrl(Uri.parse(url));
                        }
                      },
                      isExternal: true),
                  Divider(
                    height: 0,
                  ),
                  MenuTile(
                      icon: SvgPicture.asset(
                        "assets/ic-privacy.svg",
                      ),
                      title: S.of(context).privacyPolicy,
                      onTap: () async {
                        String url = SysConfigManager()
                            .getValueFromKey(ConfigKeys.privacyPolicyUrl);
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          await launchUrl(Uri.parse(url));
                        }
                      },
                      isExternal: true),
                  if (_showDeleteAccount)
                    Divider(
                      height: 0,
                    ),
                  if (_showDeleteAccount)
                    MenuTile(
                        icon: SvgPicture.asset(
                          "assets/ic-deactivate.svg",
                        ),
                        title: S.of(context).deleteAccount,
                        onTap: () {
                          DialogUtils.showDialogWithButtons(
                              title: S.of(context).warning,
                              message: S.of(context).deleteMessage,
                              context: context,
                              positiveButtonTitle: S.of(context).confirm,
                              negativeButtonTitle: S.of(context).cancel,
                              onTap: () {
                                controller.deleteAccount();
                              });
                        }),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                  context: context,
                  title: S.of(context).logout,
                  width: 100.w,
                  rawAlignment: MainAxisAlignment.center,
                  backgroundColor: Colors.white,
                  borderColor: AppColors().logOutButtonColor,
                  textColor: AppColors().logOutButtonColor,
                  fontWeight: FontWeight.bold,
                  size: 20,
                  icon: SvgPicture.asset(
                    "assets/ic-logout.svg",
                  ),
                  onPressed: () async {
                    try {
                      CurrentSession().userModel = null;
                      await SecureStorageHelper()
                          .delete(key: CacheKeys.password);
                      controller.resetHistory();
                    } catch (e) {
                      print(e);
                    }
                    Get.offAll(() => AuthScreen());
                  }),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;
  final bool isExternal;

  const MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isExternal = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: CustomText(
        text: title,
        fontSize: 16,
        textAlign: TextAlign.start,
        // color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      trailing: isExternal
          ? SvgPicture.asset(
              "assets/ic-link.svg",
            )
          : SvgPicture.asset(
              "assets/ic-arrow.svg",
            ),
      onTap: onTap,
    );
  }
}
