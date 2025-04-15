import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/l10n/app_locale.dart';
import 'package:raff/utils/helpers/string_helper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';

class AppTextField {
  static final AppTextField shared = AppTextField();

  Widget createTextField({
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    String? errorText = '',
    Key? errorTextKey,
    String hintText = '',
    String prefixText = '',
    bool isReplaceArabic = true,
    bool useLabelInsideField = false,
    void Function(String)? onChanged,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String s)? onSubmitted,
    FocusNode? focusNode,
    bool obscureText = false,
    bool enabled = true,
    bool isCopyEnabled = true,
    List<FocusNode>? allFocusNode,
    Widget? suffixIcon,
    bool showPasswordEye = false,
    String? labelText,
    List<TextInputFormatter>? inputFormatters,
    InputBorder? enableBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    void Function()? onGradientPressed,
    TextInputAction inputAction = TextInputAction.done,
    required BuildContext context,
    String? hint,
    bool enableSuggestions = false,
    double strokeWidth = 1,
    bool autocorrect = false,
    bool isCapitalAll = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    EdgeInsetsGeometry? contentPadding,
    FormFieldValidator<String>? validator,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.auto,
    double? height,
    TextStyle? customErrorTextStyle,
    int maxLines = 1,
    bool filledColor = false,
    bool readOnly = false,
    TextStyle labelStyle = const TextStyle(),
    TextStyle? hintStyle,
    TextStyle? textStyle,
    TextStyle? textFieldHeaderStyle,
    TextStyle? textFieldHeaderStyleHint,
    Widget? prefixIcon,
    ImageIcon? prefixIconData,
    bool enableInteractiveSelection = true,
    double fontSize = 5,
    BorderRadius? borderRadius,
    Key? key,
    InputDecoration? customInputDecoration,
    double? textFieldHeight,
    String textFieldHeader = '',
    String textFieldHeaderHint = '',
    ValueChanged<bool>? onSuffixChanged,
    int? maxLength,
    TextDirection? textDirection,
  }) {
    inputFormatters ??= [];

    errorBorder = OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.red));

    var myBorder = OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(50),
        borderSide: BorderSide(color: AppColors().borderColor));

    return ScopedModel<TextArabicController>(
      model: TextArabicController(controller),
      child: ScopedModelDescendant<TextArabicController>(
          builder: (_, widget, myController) {
        return StatefulBuilder(builder: (_, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (labelText != '' && !useLabelInsideField)
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 0.5.h, end: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (prefixIcon != null) prefixIcon,
                      if (prefixIcon != null)
                        SizedBox(
                          width: 10,
                        ),
                      Text(
                        labelText ?? '',
                        style: textFieldHeaderStyle ??
                            TextStyle(
                                fontSize: 15,
                                color: AppColors().labelTextFieldColor,
                                fontWeight: FontWeight.w400),
                      ),
                      Text(
                        textFieldHeaderHint,
                        style: textFieldHeaderStyleHint ??
                            TextStyle(
                                fontSize: 14,
                                color: AppColors().blackTextColor,
                                fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection:textDirection?? (AppLocale.shared.isArabic()
                          ? TextDirection.rtl
                          : TextDirection.ltr),
                      child: TextFormField(

                        enableInteractiveSelection: enableInteractiveSelection,
                        textDirection: textDirection?? TextDirection.rtl,
                        textCapitalization: textCapitalization,
                        autocorrect: autocorrect,
                        key: key,
                        maxLines: maxLines,
                        selectionControls: isCopyEnabled
                            ? null
                            : NoCopyCutTextSelectionControls(),
                        enableSuggestions: enableSuggestions,
                        cursorColor: Colors.black,
                        keyboardType: keyboardType,
                        textInputAction: inputAction,
                        validator: validator,
                        controller: controller,
                        maxLength: maxLength,
                        obscuringCharacter: '*',
                        focusNode: focusNode ?? FocusNode(),
                        onChanged: (text) {
                          if (myController.nController != null &&
                              isReplaceArabic) {
                            myController.updateValue(
                                StringHelper().replaceArabicNumbers(
                                    arabic: myController.nController!.text),
                                myController.nController?.selection);
                          }
                          setState(() {
                            determineTextDirection(text);
                          });

                          if (onChanged != null) {
                            onChanged.call(text);
                          }
                        },
                        onFieldSubmitted: (String val) {
                          if (onSubmitted != null) {
                            Timer(Duration(milliseconds: 100), () {
                              onSubmitted(val);
                            });
                          }
                        },
                        enabled: enabled,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: customInputDecoration ??
                            InputDecoration(
                              errorStyle: const TextStyle(height: 1.5),
                              focusedBorder: (errorText != null &&
                                      errorText.isNotEmpty)
                                  ? errorBorder
                                  : focusedBorder ??
                                      OutlineInputBorder(
                                          borderRadius: borderRadius ??
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: AppColors().borderColor)),
                              border: myBorder,
                              labelText: useLabelInsideField ? labelText : null,
                              enabledBorder: myBorder,
                              disabledBorder: myBorder,
                              contentPadding: contentPadding ??
                                  EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                              floatingLabelBehavior: floatingLabelBehavior,
                              suffixIcon: showPasswordEye
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                        if (onSuffixChanged != null) {
                                          onSuffixChanged.call(obscureText);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: 6.w,
                                            top: 5,
                                            bottom: 5),
                                        child: obscureText
                                            ? SvgPicture.asset(
                                                'assets/ic-hide.svg',
                                              )
                                            : SvgPicture.asset(
                                                'assets/ic-unhide.svg',
                                              ),
                                      ),
                                    )
                                  : suffixIcon,
                              labelStyle: labelStyle,
                              prefixIcon:
                                  useLabelInsideField ? prefixIcon : null,
                              hintText: hintText,
                              hintStyle: hintStyle ??
                                  TextStyle(
                                      color: AppColors().labelTextFieldColor),
                              errorMaxLines: 3,
                              fillColor: enabled
                                  ? AppColors().textFieldBackgroundColor
                                  : Color(0xffd8e2e6),
                              filled: true,
                            ),
                        obscureText: obscureText,
                        readOnly: readOnly,
                        style: textStyle ?? getTextStyle(),
                        inputFormatters: inputFormatters,
                        onTap: () {
                          if (onTap != null) {
                            onTap();
                          }
                        },
                        onEditingComplete: () {
                          if (onEditingComplete != null) {
                            onEditingComplete();
                          }
                        },

                      ),
                    ),
                  ),
                ],
              ),
              if (errorText != null && errorText.isNotEmpty)
                Align(
                  alignment: AppLocale.shared.isArabic()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      key: errorTextKey,
                      errorText,
                      style: customErrorTextStyle ??
                          const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
            ],
          );
        });
      }),
    );
  }

  TextDirection determineTextDirection(String text) {
    TextDirection textDirection = TextDirection.ltr;
    if (text.isNotEmpty) {
      final int firstCharacter = text.codeUnitAt(0);
      if ((firstCharacter >= 0x0600 && firstCharacter <= 0x06FF) ||
          (firstCharacter >= 0x0750 && firstCharacter <= 0x077F) ||
          (firstCharacter >= 0x0590 && firstCharacter <= 0x05FF)) {
        textDirection = TextDirection.rtl;
      }
    }
    return textDirection;
  }

  TextStyle getTextStyle(
          {double height = 1,
          double fontSize = 14,
          Color color = Colors.black,
          bool isEnable = true,
          FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          color: isEnable ? Colors.black : AppColors().greyTextColor,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight);
}

class TextArabicController extends Model {
  TextArabicController(TextEditingController? initController) {
    _nController = initController;
  }

  TextEditingController? _nController;

  TextEditingController? get nController => _nController;

  void updateValue(String nValue, TextSelection? textSelection) {
    _nController!.text = nValue;
    _nController!.selection = textSelection ??
        TextSelection.fromPosition(
          TextPosition(offset: _nController!.text.length),
        );
    notifyListeners();
  }
}

class NoCopyCutTextSelectionControls extends MaterialTextSelectionControls {
  @override
  bool canCopy(TextSelectionDelegate delegate) {
    return false;
  }

  @override
  bool canCut(TextSelectionDelegate delegate) {
    return false;
  }
}
