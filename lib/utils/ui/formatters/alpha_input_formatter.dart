import 'package:flutter/services.dart';
import 'package:raff/utils/helpers/string_helper.dart';
class NoDigitsOrSpecialCharsInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String nV =
        StringHelper.shared.replaceArabicNumbers(arabic: newValue.text);
    if (_regExp.hasMatch(nV)) {
      return newValue;
    } else {
      if (nV.isEmpty) return TextEditingValue.empty;
      return oldValue;
    }
  }
}
