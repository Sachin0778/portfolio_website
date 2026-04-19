import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Portfolio';
  static const String appVersion = '1.0.0';

  // Colors — deep slate base + vivid accents (2024+ portfolio aesthetic)
  static const Color primaryColor = Color(0xFF8B5CF6);
  static const Color secondaryColor = Color(0xFF22D3EE);
  static const Color accentColor = Color(0xFFF472B6);
  static const Color backgroundColor = Color(0xFF030712);
  static const Color surfaceColor = Color(0xFF0B1220);
  static const Color cardColor = Color(0xFF111827);
  static const Color cardBorderColor = Color(0xFF1F2937);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textTertiary = Color(0xFF64748B);

  /// Soft orbs for ambient background animation
  static const Color glowPrimary = Color(0xFF7C3AED);
  static const Color glowSecondary = Color(0xFF0891B2);
  static const Color glowAccent = Color(0xFFDB2777);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA78BFA), Color(0xFF22D3EE)],
  );

  static const LinearGradient heroTitleGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE9D5FF), Color(0xFF67E8F9), Color(0xFFFBCFE8)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, primaryColor],
  );

  /// Same shell as “Where I spend depth” / focus orbs: soft border + diagonal wash.
  static BoxDecoration depthPanelDecoration({
    required List<Color> accentColors,
    double borderRadius = radiusXLarge,
    List<BoxShadow>? boxShadow,
  }) {
    assert(accentColors.isNotEmpty);
    final a = accentColors.first;
    final b = accentColors.length > 1 ? accentColors.last : accentColors.first;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: a.withOpacity(0.28)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cardColor.withOpacity(0.88),
          a.withOpacity(0.08),
          b.withOpacity(0.06),
        ],
      ),
      boxShadow: boxShadow,
    );
  }

  /// Glass-style card: subtle border + dark fill
  static BoxDecoration glassCardDecoration({
    double borderRadius = radiusLarge,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: cardColor.withOpacity(0.72),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? primaryColor.withOpacity(0.18),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(0.06),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.1,
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.2,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.4,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textTertiary,
    height: 1.3,
  );

  // Spacing — comfortable for web (was ultra-compact)
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 40.0;
  static const double paddingXXLarge = 64.0;

  static const double contentMaxWidth = 1200.0;

  // Border Radius
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 14.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 28.0;

  // Animation Durations
  static const Duration animationDuration = Duration(milliseconds: 320);
  static const Duration longAnimationDuration = Duration(milliseconds: 700);

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}
