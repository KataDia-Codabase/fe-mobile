import 'package:flutter/material.dart';

/// Extension methods for widgets
extension WidgetExtension on Widget {
  
  /// Add padding with predefined sizes
  Widget paddingAll(double padding) => Padding(
    padding: EdgeInsets.all(padding),
    child: this,
  );
  
  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    ),
    child: this,
  );
  
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );
  
  Widget expanded() => Expanded(
    child: this,
  );
  
  Widget flexible({
    int flex = 1,
  }) => Flexible(
    flex: flex,
    child: this,
  );
  
  Widget center() => Center(
    child: this,
  );
  
  Widget align({
    Alignment alignment = Alignment.center,
  }) => Align(
    alignment: alignment,
    child: this,
  );
  
  Widget wrap({
    WrapCrossAlignment wrap = WrapCrossAlignment.start,
    WrapAlignment alignment = WrapAlignment.center,
  }) => Wrap(
    alignment: alignment,
    crossAxisAlignment: wrap,
    children: [this],
  );
  
  Widget onTap(VoidCallback? onTap) => GestureDetector(
    onTap: onTap,
    child: this,
  );
}
