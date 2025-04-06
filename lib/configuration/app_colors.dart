import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _shared = AppColors._private();

  factory AppColors() => _shared;

  AppColors._private();

  static const primaryColor = MaterialColor(0xFF1D416F, materialColorSwatch);
  static const accentColor = MaterialColor(0xffffffff, materialColorSwatch);
  Color greyTextColor = Color(0xff919191);
  Color blackTextColor = Colors.black;
  Color borderColor = Color(0xffF2F6F8);
  Color textFieldBackgroundColor = Color(0xffF2F6F8);
  Color labelTextFieldColor = Color(0xff959595);
  Color inActiveDotColor = Color(0xffA8C8DC);
  Color checkBoxColor = Color(0xff78A1BB);
  Color lightGreTextColor = Color(0xff9F9F9F);
  Color highlightColor = Color(0xff0093FF);
  Color purpleColor = Color(0xffBA68C8);
  Color logOutButtonColor = Color(0xffCE2829);
  Color dialogButtonColor = Color(0xffDB1845);
  Color dialogSuccessColor = Color(0xff3DC179);
  Color contactusBorderColor = Color(0xffEBF5FA);
  Color chipColor = Color(0xffEDF5FF);
  static const materialColorSwatch = {
    50: Color.fromRGBO(253, 231, 76, .1),
    100: Color.fromRGBO(253, 231, 76, .2),
    200: Color.fromRGBO(253, 231, 76, .3),
    300: Color.fromRGBO(253, 231, 76, .4),
    400: Color.fromRGBO(253, 231, 76, .5),
    500: Color.fromRGBO(253, 231, 76, .6),
    600: Color.fromRGBO(253, 231, 76, .7),
    700: Color.fromRGBO(253, 231, 76, .8),
    800: Color.fromRGBO(253, 231, 76, .9),
    900: Color.fromRGBO(253, 231, 76, 1),
  };
}
