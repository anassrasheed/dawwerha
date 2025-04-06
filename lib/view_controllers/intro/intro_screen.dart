import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/intro/intro_response.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_button.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/view_controllers/auth/auth_screen.dart';
import 'package:sizer/sizer.dart';

import 'intro_item.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<IntroModel> intros = [];
  late final PageController _pageController;
  int _selectedIndex = 0;
  final Duration duration = Duration(milliseconds: 350);

  @override
  void initState() {
    _pageController = PageController();
    intros = CurrentSession().intro;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Status bar color
      statusBarIconBrightness: Brightness.dark, // Status bar icons color
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
        width: 100.w,
        color: Colors.transparent,
        child:
            _selectedIndex == 0 ? _buildNextButton() : _buildRemainingButtons(),
      ),
      body: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.offAll(AuthScreen(),
                        duration: duration, curve: Curves.bounceIn);
                  },
                  child: CustomText(
                    text: S.of(context).skip,
                    color: AppColors().greyTextColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView.builder(
                  itemBuilder: (_, index) {
                    return IntroItem(
                      model: intros[index],
                      controller: _pageController,
                      length: intros.length,
                    );
                  },
                  itemCount: intros.length,
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                ),
              )
            ],
          )),
    ));
  }

  Widget _buildNextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
      width: 100.w,
      child: CustomButton(
        context: context,
        width: 100.w,
        height: 48,
        title: S.of(context).next,
        textColor: Colors.white,
        borderColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            _pageController.animateToPage(++_selectedIndex,
                duration: duration, curve: Curves.linear);
          });
        },
      ),
    );
  }

  Widget _buildRemainingButtons() {
    return Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
        child: Row(
          children: [
            CustomButton(
              context: context,
              width: 32.w,
              height: 48,
              title: S.of(context).back,
              backgroundColor: Colors.white,
              borderColor: AppColors.primaryColor,
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              onPressed: () {
                setState(() {
                  _pageController.animateToPage(--_selectedIndex,
                      duration: duration, curve: Curves.linear);
                });
              },
            ),
            Spacer(),
            CustomButton(
              context: context,
              width: 32.w,
              height: 48,
              borderColor: AppColors.primaryColor,
              title: _selectedIndex == intros.length - 1
                  ? S.of(context).getStarted
                  : S.of(context).next,
              textColor: Colors.white,
              onPressed: () {
                if (_selectedIndex == intros.length - 1) {
                  Get.offAll(AuthScreen(),
                      duration: duration, curve: Curves.bounceIn);
                  return;
                }
                setState(() {
                  _pageController.animateToPage(++_selectedIndex,
                      duration: duration, curve: Curves.linear);
                });
              },
            ),
          ],
        ));
  }
}
