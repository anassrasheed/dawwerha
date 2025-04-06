import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomRadioButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Widget child;
  final double? width;
  final double? height;

  final Alignment? alignment;

  CustomRadioButton(
      {super.key,
      required this.onTap,
      required this.isSelected,
      required this.child,
      this.width,
      this.height,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: isSelected ? Color(0x26FDE74C) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: isSelected ? Color(0xFFFDE74C) : Color(0xFFC6C6C6)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        height: height ?? 26.w,
        width: width ?? 26.w,
        alignment: alignment ?? Alignment.center,
        child: child,
      ),
    );
  }
}
