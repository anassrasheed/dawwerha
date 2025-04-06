// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';

class CustomCheckbox extends StatefulWidget {
  final double? size;
  final double? iconSize;
  final Function onChange;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final IconData? icon;
  final bool isChecked;

  CustomCheckbox({
    Key? key,
    this.size,
    this.iconSize,
    required this.onChange,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _Custom_CheckboxState();
}

class _Custom_CheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  bool firstValidation = true;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (value) {
        firstValidation = false;
        if (!isChecked) return S.current.thisFieldIsRequired;
        return null;
      },
      builder: (s) {
        return GestureDetector(
          onTap: () {
            if (mounted)
              setState(() {
                isChecked = !isChecked;
                widget.onChange(isChecked);
              });
          },
          child: AnimatedContainer(
              height: widget.size ?? 28,
              width: widget.size ?? 28,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: isChecked
                    ? widget.backgroundColor ?? AppColors.primaryColor
                    : Colors.white,
                border: Border.all(
                    color: isChecked
                        ? Colors.white
                        : widget.borderColor ??
                            (!s.hasError || firstValidation
                                ? Color(0xFFDDDDDD)
                                : Colors.red)),
              ),
              child: isChecked
                  ? Icon(
                      widget.icon ?? Icons.check,
                      color: widget.iconColor ?? Colors.white,
                      size: widget.iconSize ?? 20,
                    )
                  : null),
        );
      },
    );
  }
}
