import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  final int? maxLines;
  final TextDirection? textDirection;
  final TextDecoration? textDecoration;
  final double? height;
  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection,
    this.textDecoration,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.openSans(
        color: color,
        height: height,
        decoration: textDecoration,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 3,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
