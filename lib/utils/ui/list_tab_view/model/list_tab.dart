import 'package:flutter/material.dart';

class ListTab {
  /// Create a new [ListTab]
  const ListTab(
      {Key? key,
      this.icon,
      required this.label,
      this.borderRadius = const BorderRadius.all(const Radius.circular(5.0)),
      this.activeBackgroundColor = Colors.blue,
      this.activeLabelColor = Colors.white,
      this.inactiveLabelColor = Colors.black,
      this.inactiveBackgroundColor = Colors.transparent,
      this.showIconOnList = false,
      this.innerTabIcon,
      this.borderColor = Colors.grey});

  /// Trailing widget for a tab, typically an [Icon].
  final Widget? icon;

  final Widget? innerTabIcon;

  /// Label to be shown in the tab, must be non-null.
  final String label;

  /// [BorderRadius] for the a tab at the bottom tab view.
  /// This won't affect the tab in the scrollable list.
  final BorderRadiusGeometry borderRadius;

  /// Color to be used when the tab is selected.
  final Color activeBackgroundColor;

  final Color activeLabelColor;
  final Color inactiveLabelColor;

  /// Color to be used when tab is not selected
  final Color inactiveBackgroundColor;

  /// If true, the [icon] will also be shown to the user in the scrollable list.
  final bool showIconOnList;

  /// Color of the [Border] property of the inner tab [Container].
  final Color borderColor;
}
