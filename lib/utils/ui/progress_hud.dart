import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:sizer/sizer.dart';

class ProgressHud {
  static ProgressHud shared = ProgressHud();
  BuildContext? context;

  Widget createLoadingView({
    Color? color,
    bool isLoadMore = false,
    bool useScanLoading = false,
    double size = 50.0,
  }) {
    return Stack(
      children: <Widget>[
        getCircularProgressIndicator(
            color: color ?? AppColors.primaryColor,
            size: size,
            useScanLoading: useScanLoading,
            isLoadMore: isLoadMore),
      ],
    );
  }

  Widget spinKitThreeInOut({double size = 50.0}) {
    return SpinKitFadingCircle(
      size: size,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }

  Widget getCircularProgressIndicator({
    Color? color,
    bool isLoadMore = false,
    bool useScanLoading = false,
    double size = 50.0,
  }) =>
      Center(
          child: isLoadMore
              ? SpinKitRipple(color: color, size: size)
              : Container(
                  child: Lottie.asset(
                    'assets/plastic_loading.json',
                      repeat: true,
                      width:  25.w),
                ));

  void startLoading(BuildContext context, {bool useScanLoading = false}) {
    ProgressHud.shared.context = context;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return createLoadingView(size: 70, useScanLoading: useScanLoading);
      },
    );
  }

  void stopLoading() {
    if (ProgressHud.shared.context != null) {
      Navigator.of(ProgressHud.shared.context!, rootNavigator: true)
          .pop('Discard');
    }
  }
}
