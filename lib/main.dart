import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';

import 'generated/l10n.dart';
import 'l10n/app_locale.dart';
import 'view_controllers/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterViewController.setFlutterPlatformViewRenderingBackend(FlutterPlatformViewRenderingBackend.skia);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ScopedModel<AppLocale>(
        model: AppLocale.shared,
        child: ScopedModelDescendant<AppLocale>(
          builder: (context, child, model) => Sizer(
            builder: (context, orientation, deviceType) {
              return OKToast(
                child: GetMaterialApp(
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                      boldText: false,
                    ),
                    child: child!,
                  ),
                  locale: AppLocale.shared.appLocal,
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    Locale.fromSubtags(languageCode: 'en'),
                    Locale.fromSubtags(languageCode: 'ar'),
                  ],
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    primaryColor: AppColors.primaryColor,
                    scaffoldBackgroundColor: Colors.white,
                    textTheme: GoogleFonts.openSansTextTheme(
                      Theme.of(context).textTheme.apply(
                          bodyColor: Colors.black, displayColor: Colors.black),
                    ),
                    appBarTheme: AppBarTheme(
                      toolbarTextStyle: GoogleFonts.openSansTextTheme(
                        Theme.of(context).textTheme.apply(
                              bodyColor: Colors.black, // AppBar text color
                              displayColor:
                                  Colors.black, // AppBar display text color
                            ),
                      ).bodyMedium,
                      titleTextStyle: GoogleFonts.openSansTextTheme(
                        Theme.of(context).textTheme.apply(
                              bodyColor: Colors.black, // AppBar text color
                              displayColor:
                                  Colors.black, // AppBar display text color
                            ),
                      ).titleLarge,
                    ),
                    iconTheme: Theme.of(context)
                        .iconTheme
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  home: SplashScreen(),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
