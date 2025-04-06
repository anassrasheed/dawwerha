import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/text_recognetion/vin_reader_manager.dart';
import 'package:raff/utils/text_recognetion/vin_reader_model.dart';
import 'package:raff/utils/ui/bottom_nav_bar/persistent-tab-view.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/utils/ui/floating_action_bubble/floating_action_bubble.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/home/controller/home_tab_controller.dart';
import 'package:raff/view_controllers/home/model/camera_manager.dart';
import 'package:raff/view_controllers/home/view/tabs/home/home_tab.dart';
import 'package:raff/view_controllers/home/view/tabs/menu_tab.dart';
import 'package:raff/view_controllers/scan_vinnumber/controller/scan_vinnumber_conroller.dart';
import 'package:raff/view_controllers/scan_vinnumber/scan_vin_number_screen.dart';

import 'live_vin_scanner.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  PersistentTabController _controller = PersistentTabController();
  int _selectedIndex = 0;
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool _showBottomNavBar = true;
  ImagePicker _picker = ImagePicker();
  HomeTabController controller = Get.put(HomeTabController(), permanent: true);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
    try {
      CameraManager().initalizeController();
    }catch(_){}
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    _controller = PersistentTabController(initialIndex: 0);
    controller.getHistoryVehicle();
    controller.checkForForceUpdate();
  }

  List<Widget> _buildScreens() {
    return [HomeTab(), MenuTab()];
  }

  void changeOverlay({bool isForward = true}) {
    setState(() {
      _showBottomNavBar = !_showBottomNavBar;
      if (isForward)
        _animationController.forward();
      else {
        _animationController.reverse();
      }

      controller.changeOverLay();
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Transform.scale(
          scale: 1.1,
          child: SvgPicture.asset(
            _selectedIndex == 0
                ? "assets/ic_home_imge.svg"
                : 'assets/ic_home_unselected.svg',
            height: 25,
            // fit: BoxFit.fill,
          ),
        ),
        title: S.of(context).home,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
        textStyle: TextStyle(fontSize: 11.5, color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Transform.translate(
          offset: Offset(0, -5),
          child: Transform.scale(
            scale: 2.5,
            child: SvgPicture.asset(
              _selectedIndex == 1
                  ? "assets/ic-menu.svg"
                  : 'assets/ic_menu_unselected.svg',
              height: 28,
            ),
          ),
        ),
        title: S.of(context).menu,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white54,
        textStyle: TextStyle(
          fontSize: 11.5,
          color: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Color(0xFF0A2748),
          navBarHeight: Platform.isAndroid ? 85 : 85,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            gradient: LinearGradient(colors: [
              Color(0xff0F2138),
              Color(0xff1D416F),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            colorBehindNavBar: Colors.transparent,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          onWillPop: (v) {
            if (!_showBottomNavBar) changeOverlay();
            return Future.value(false);
          },
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          onItemSelected: (index) {
            if (index == 0) {
              controller.getHistoryVehicle();
            }
            setState(() {
              _selectedIndex = index;
            });
          },
          hideNavigationBar: !_showBottomNavBar,
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style8,
        ),
        Positioned(
          bottom: Platform.isAndroid
              ? _showBottomNavBar
                  ? -15
                  : 0
              : _showBottomNavBar
                  ? 10
                  : 20,
          right: 0,
          left: 0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: Material(
                  color: Colors.transparent,
                  child: _showBottomNavBar
                      ? Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                changeOverlay();
                              },
                              child: Image.asset(
                                'assets/floating_main_bubtton.png',
                                scale: 2.2,
                              ),
                            ),
                          ],
                        )
                      : _getBubbleView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getBubbleView() {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: S.of(context).upload,
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Transform.scale(
              child: Image.asset('assets/upload.png'), scale: 1),
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            changeOverlay(isForward: false);
            _pickImageFromGallery();
          },
        ),
        // Floating action menu item
        Bubble(
          title: S.of(context).scan,
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon:
              Transform.scale(child: Image.asset('assets/scan.png'), scale: 1),
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () async {
            changeOverlay(isForward: false);
            await _liveScan();
          },
        ),
        //Floating action menu item
        Bubble(
          title: S.of(context).enter,
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon:
              Transform.scale(child: Image.asset('assets/enter.png'), scale: 1),
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () async {
            changeOverlay(isForward: false);
            await pushNewScreen(context, screen: ScanVinNumberScreen());
            controller.getHistoryVehicle();
          },
        ),
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () {
        changeOverlay(isForward: false);
      },

      // Floating Action button Icon color
      iconColor: Colors.blue,

      // Flaoting Action button Icon
      iconData: Icons.ac_unit,
      backGroundColor: Colors.white,
    );
  }

  Future<void> _liveScan() async {
    var detectedVins = await Get.to(() => LiveVinScanner());
    if (detectedVins != null && detectedVins is List<String>) {
      try {
        await Future.delayed(Duration(milliseconds: 500));
        if (detectedVins.length == 1) {
          pushNewScreen(context,
              screen: ScanVinNumberScreen(
                vin: detectedVins.first,
                onRescan: () {
                  Get.back();
                  _liveScan();
                },
              )).then((value) {
            controller.getHistoryVehicle();
          });
        } else if (detectedVins.length > 1) {
          showMultiVinBottomSheet(detectedVins);
        }
      } catch (_) {
        DialogUtils.showToastView(context, S.of(context).generalError,
            type: DialogType.error);
      }
    }
   await Future.delayed(Duration(milliseconds: 700));
    CameraManager().initalizeController();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      _processImageForVin(image);
    }
  }

  Future<void> _processImageForVin(File? image) async {
    if (image == null) return;
    try {
      ProgressHud.shared.startLoading(context);
      final inputImage = InputImage.fromFile(image);
      final RecognizedText recognisedText =
          await TextRecognizer().processImage(inputImage);

      List<VinReaderModel> detectedVins =
          VinReaderManager().detectVins(recognisedText, isLiveScan: false);

      ProgressHud.shared.stopLoading();
      if (detectedVins
              .where((element) => element.isBackup == false)
              .toList()
              .length ==
          1) {
        pushNewScreen(context,
            screen: ScanVinNumberScreen(
              vin: detectedVins
                  .where((element) => element.isBackup == false)
                  .toList()
                  .first
                  .vin,
              onRescan: () {
                Get.back();
                _pickImageFromGallery();
              },
            )).then((value) {
          controller.getHistoryVehicle();
        });
      } else if (detectedVins
              .where((element) => element.isBackup == false)
              .toList()
              .length >
          1) {
        showMultiVinBottomSheet(detectedVins
            .where((element) => element.isBackup == false)
            .map((e) => e.vin)
            .toList());
      } else {
        if (detectedVins.where((element) => element.isBackup).isEmpty) {
          DialogUtils.showToastView(
              context, S.of(context).noVinDetectedFromTheImage,
              type: DialogType.warning);
          return;
        }
        DialogUtils.showDialogWithButtons(
            title: S.of(context).warning,
            message: S.of(context).weDetectedTextButNoneMatchTheVinFormatWould,
            context: context,
            positiveButtonTitle: S.of(context).view,
            negativeButtonTitle: S.of(context).cancel,
            onTap: () {
              showViewBottomSheet(detectedVins
                  .where((element) => element.isBackup)
                  .map((e) => e.vin)
                  .toList());
            });
      }
    } catch (_) {
      ProgressHud.shared.stopLoading();
      DialogUtils.showToastView(context, S.of(context).generalError,
          type: DialogType.error);
    }
  }

  void showViewBottomSheet(List<String> blocks) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffEBF5FA)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/ic-close.svg',
                          color: AppColors.primaryColor,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).detectedTexts,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors().dialogButtonColor,
                    ),
                  ),
                  SizedBox(width: 48), // Placeholder to center title
                ],
              ),
              SizedBox(height: 12),
              CustomText(
                text: S.of(context).pleaseSelectTheMostRelevantTextToEdit,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: blocks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Get.back();
                        await pushNewScreen(context,
                            screen: ScanVinNumberScreen(
                              vin: blocks[index],
                            )).then((value) {
                          controller.getHistoryVehicle();
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            blocks[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        color: Color(0xffF2F6F8), // Card background color
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showMultiVinBottomSheet(List<String> vins) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffEBF5FA)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/ic-close.svg',
                          color: AppColors.primaryColor,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).detectedVins,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors().dialogButtonColor,
                    ),
                  ),
                  SizedBox(width: 48), // Placeholder to center title
                ],
              ),
              SizedBox(height: 12),
              CustomText(
                text: S
                    .of(context)
                    .multipleVinsDetectedPleaseSelectOneToPreviewVehicleData,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: vins.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Get.back();
                        ScanVinNumberController controller =
                            Get.put(ScanVinNumberController());
                        controller.getVinNumber(nVin: vins[index]);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            vins[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        color: Color(0xffF2F6F8), // Card background color
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String convertToEnglish(String input) {
    return removeDiacritics(
        input); // Removes accents, converts characters to base form
  }

  bool isEnglish(String input) {
    final RegExp englishRegex = RegExp(r'^[a-zA-Z0-9\s.,!?"@#%^&*()_+\-=]*$');
    return englishRegex.hasMatch(input);
  }
}
