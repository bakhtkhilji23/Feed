import 'package:flutter/material.dart';

class AppDefaults {
  static const double radius = 16;
  static const double margin = 16;
  static const double padding = 16;

  /// Used For Border Radius
  static BorderRadius borderRadius = BorderRadius.circular(radius);

  /// Used For Bottom Sheet
  static BorderRadius bottomSheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );

  /// Used For Top Sheet
  static BorderRadius topSheetRadius = const BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  /// Default Box Shadow used for containers
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 2),
      color: Colors.black.withOpacity(0.04),
    ),
  ];

  static Duration duration = const Duration(milliseconds: 300);

  static double aspectRatio = 16 / 10;
}
