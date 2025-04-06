import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configuration/app_colors.dart';

class CustomButton extends StatefulWidget {
  final BuildContext context;
  final double width;
  final double height;
  final double padding;
  final Widget? icon;
  final Color? textColor;
  final Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final double size;
  final double radius;
  final MainAxisAlignment rawAlignment;
  final FontWeight fontWeight;
  final Color borderColor;

  const CustomButton(
      {super.key,
      required this.context,
      this.width = 200,
      this.height = 48,
      this.padding = 8,
      this.icon,
      this.textColor,
      this.onPressed,
      this.title = "Click Me!",
      this.backgroundColor,
      this.size = 15.0,
      this.radius = 35,
      this.rawAlignment = MainAxisAlignment.spaceBetween,
      this.fontWeight = FontWeight.w600,
      this.borderColor = Colors.black});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.backgroundColor ?? AppColors.primaryColor,
        ),
        shadowColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        overlayColor: MaterialStateProperty.all(
          widget.backgroundColor ?? AppColors.primaryColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              side: BorderSide(color: widget.borderColor)),
        ),
      ),
      child: Container(
        width: widget.width,
        alignment: Alignment.center,
        height: widget.height,
        child: widget.icon == null
            ? Container(
                // margin: EdgeInsets.only(top: 1.2.h),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.size,
                      fontWeight: widget.fontWeight,
                      fontFamily: GoogleFonts.openSans().fontFamily),
                  textAlign: TextAlign.center,
                ),
              )
            : Row(
                mainAxisAlignment: widget.rawAlignment,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    widget.icon!,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: widget.textColor,
                          fontSize: widget.size,
                          fontWeight: widget.fontWeight,
                          fontFamily: GoogleFonts.openSans().fontFamily),
                    ),
                  ]),
      ),
    );
  }
}
