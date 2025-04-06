import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/custom_text.dart';
import 'package:sizer/sizer.dart';

mixin AuthCommonViews {
  Widget getItem(
      {required String title,
      required VoidCallback onPressed,
      required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : AppColors().borderColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: CustomText(
            text: title,
            color: isSelected ? Colors.black : Color(0xff171616),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          )),
        ),
      ),
    );
  }

  Widget getAuthTypeView(ValueChanged<int> onTabChanged, int selectedIndex) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors().borderColor,
          borderRadius: BorderRadius.circular(50)),
      height: 65,
      width: 100.w,
      child: Row(children: [
        Expanded(
            child: getItem(
                title: S.of(Get.context!).signIn,
                isSelected: selectedIndex == 0,
                onPressed: () {
                  selectedIndex = 0;
                  onTabChanged.call(0);
                })),
        Expanded(
            child: getItem(
                title: S.of(Get.context!).register,
                isSelected: selectedIndex == 1,
                onPressed: () {
                  selectedIndex = 1;
                  onTabChanged.call(1);
                })),
      ]),
    );
  }
}
