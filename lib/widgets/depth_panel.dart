import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Content block using the same “depth” shell as focus orbs (border + gradient wash).
class DepthPanel extends StatelessWidget {
  const DepthPanel({
    super.key,
    required this.child,
    this.accentColors,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
  });

  final Widget child;
  final List<Color>? accentColors;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final accents = accentColors ?? [AppConstants.primaryColor, AppConstants.secondaryColor];
    return Container(
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: AppConstants.depthPanelDecoration(
        accentColors: accents,
        borderRadius: borderRadius ?? AppConstants.radiusXLarge,
        boxShadow: boxShadow,
      ),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}
