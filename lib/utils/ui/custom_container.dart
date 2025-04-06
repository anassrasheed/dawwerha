import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/bg_image.png'),
        fit: BoxFit.fill,
      )
          //     gradient: LinearGradient(
          //   colors: [Color(0xFF0A2342), Color(0xFF728CAA)],
          //   // stops: [0.3, 0.9],
          //   begin: Alignment.topLeft,
          //   end: Alignment.centerRight,
          // )
          ),
      child: child,
    );
  }
}
