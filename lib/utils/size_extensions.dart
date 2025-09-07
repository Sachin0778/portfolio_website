import 'dart:math';
import 'package:flutter/widgets.dart';
import '../constants/app_constants.dart';

/// Initializes and holds screen-based scaling factors derived from MediaQuery.
class SizeConfig {
  static const double baseWidth = 375.0;
  static const double baseHeight = 812.0;

  static double _scaleWidth = 1.0;
  static double _scaleHeight = 1.0;
  static double _textScale = 1.0;
  static double _fontBoostPx = 0.0;
  static bool _initialized = false;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    if (size.width <= 0 || size.height <= 0) {
      _initialized = true;
      _scaleWidth = 1.0;
      _scaleHeight = 1.0;
      _textScale = mediaQuery.textScaleFactor;
      _fontBoostPx = 0.0;
      return;
    }

    _scaleWidth = size.width / baseWidth;
    _scaleHeight = size.height / baseHeight;
    // Base scale uses the smaller dimension to avoid oversized text on very tall screens.
    final baseScale = min(_scaleWidth, _scaleHeight);

    // Apply breakpoint-aware minimum floors so desktop widths don't look tiny.
    double minFloor = 1.0;
    final width = size.width;
    if (width >= 1920) {
      minFloor = 1.5;
    } else if (width >= 1440) {
      minFloor = 1.3;
    } else if (width >= AppConstants.desktopBreakpoint) { // >= 1200
      minFloor = 1.15;
    } else if (width >= AppConstants.tabletBreakpoint) { // >= 900
      minFloor = 1.05;
    }

    _textScale = max(baseScale, minFloor) * mediaQuery.textScaleFactor;
    // Add pixel boost only for wider layouts to prevent overflow on small screens.
    if (width >= 1920) {
      _fontBoostPx = 6.0;
    } else if (width >= 1440) {
      _fontBoostPx = 5.0;
    } else if (width >= AppConstants.desktopBreakpoint) {
      _fontBoostPx = 4.0;
    } else if (width >= AppConstants.tabletBreakpoint) {
      _fontBoostPx = 2.0;
    } else {
      _fontBoostPx = 0.0;
    }
    _initialized = true;
  }

  static double get scaleWidth => _initialized ? _scaleWidth : 1.0;
  static double get scaleHeight => _initialized ? _scaleHeight : 1.0;
  static double get fontScale => _initialized ? _textScale : 1.0;
  static double get fontBoostPx => _initialized ? _fontBoostPx : 0.0;
}

extension SizeExtensions on num {
  double get w => this * SizeConfig.scaleWidth;
  double get h => this * SizeConfig.scaleHeight;
  double get sp => this * SizeConfig.fontScale + SizeConfig.fontBoostPx;
}


