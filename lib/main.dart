import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_constants.dart';
import 'controllers/portfolio_controller.dart';
import 'utils/size_extensions.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseText = Theme.of(context).textTheme;
    final jakarta = GoogleFonts.plusJakartaSansTextTheme(baseText).apply(
      bodyColor: AppConstants.textPrimary,
      displayColor: AppConstants.textPrimary,
    );

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppConstants.primaryColor,
          secondary: AppConstants.secondaryColor,
          surface: AppConstants.surfaceColor,
          error: AppConstants.accentColor,
          onPrimary: AppConstants.textPrimary,
          onSecondary: AppConstants.backgroundColor,
          onSurface: AppConstants.textPrimary,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: jakarta,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
              vertical: AppConstants.paddingMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: AppConstants.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
              vertical: AppConstants.paddingMedium,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppConstants.secondaryColor,
            side: BorderSide(color: AppConstants.secondaryColor.withOpacity(0.55)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
              vertical: AppConstants.paddingMedium,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppConstants.cardColor.withOpacity(0.85),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: BorderSide(color: AppConstants.primaryColor.withOpacity(0.12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: BorderSide(color: AppConstants.cardBorderColor.withOpacity(0.9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: const BorderSide(color: AppConstants.secondaryColor, width: 2),
          ),
          labelStyle: TextStyle(color: AppConstants.textSecondary.withOpacity(0.95)),
          hintStyle: TextStyle(color: AppConstants.textTertiary.withOpacity(0.85)),
        ),
        cardTheme: CardThemeData(
          color: AppConstants.cardColor.withOpacity(0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppConstants.primaryColor.withOpacity(0.08),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppConstants.cardColor,
          contentTextStyle: GoogleFonts.plusJakartaSans(color: AppConstants.textPrimary),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(PortfolioController());
      }),
      home: Builder(
        builder: (context) {
          SizeConfig.init(context);
          return const HomeView();
        },
      ),
    );
  }
}
