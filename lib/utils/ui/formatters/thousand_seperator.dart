import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }
    TextEditingValue temp = newValue;

    newValue = TextEditingValue(
        text: newValue.text.replaceAll(RegExp('[^0-9]'), ''),
        selection: newValue.selection,
        composing: newValue.composing);
    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != temp.text) {
      int selectionIndex = temp.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String rafftring = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          rafftring = separator + rafftring;
        rafftring = chars[i] + rafftring;
      }

      return TextEditingValue(
        text: rafftring.toString(),
        selection: TextSelection.collapsed(
          offset: rafftring.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
