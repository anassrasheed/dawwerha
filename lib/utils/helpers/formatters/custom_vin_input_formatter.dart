import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove all non-alphanumeric characters for processing
    String cleanedText = newText.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    String formattedText = '';
    int index = 0;

    // Preserve the cursor position to keep track of where the cursor should be
    int selectionIndex = newValue.selection.end;

    // Segment 1: "4XL"
    if (cleanedText.length >= 3) {
      formattedText += cleanedText.substring(index, index + 3);
      index += 3;
    } else if (cleanedText.isNotEmpty) {
      formattedText += cleanedText;
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 2: "SL658"
    if (cleanedText.length >= index + 5) {
      formattedText += ' - ' + cleanedText.substring(index, index + 5);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 5;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 3: "4"
    if (cleanedText.length >= index + 1) {
      formattedText += ' - ' + cleanedText.substring(index, index + 1);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 1;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 4: "8"
    if (cleanedText.length >= index + 1) {
      formattedText += ' - ' + cleanedText.substring(index, index + 1);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 1;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 5: "Z"
    if (cleanedText.length >= index + 1) {
      formattedText += ' - ' + cleanedText.substring(index, index + 1);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 1;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 6: "41"
    if (cleanedText.length >= index + 2) {
      formattedText += ' - ' + cleanedText.substring(index, index + 2);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 2;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Segment 7: "1439"
    if (cleanedText.length >= index + 4) {
      formattedText += ' - ' + cleanedText.substring(index, index + 4);
      if (selectionIndex > index) selectionIndex += 3; // Account for ' - '
      index += 4;
    } else if (cleanedText.length > index) {
      formattedText += ' - ' + cleanedText.substring(index);
    }

    // Ensure cursor position is preserved after formatting
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: selectionIndex.clamp(0, formattedText.length),
      ),
    );
  }
}
