import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/portfolio_controller.dart';
import 'constants/app_constants.dart';
import 'views/home_view.dart';
import 'utils/size_extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark(
              primary: AppConstants.primaryColor,
              secondary: AppConstants.secondaryColor,
              surface: AppConstants.surfaceColor,
              background: AppConstants.backgroundColor,
              onPrimary: AppConstants.textPrimary,
              onSecondary: AppConstants.textPrimary,
              onSurface: AppConstants.textPrimary,
              onBackground: AppConstants.textPrimary,
            ),
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: AppConstants.textPrimary,
              displayColor: AppConstants.textPrimary,
            ),
            scaffoldBackgroundColor: AppConstants.backgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: AppConstants.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                foregroundColor: AppConstants.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                  vertical: AppConstants.paddingMedium,
                ),
              ),
            ),
            cardTheme: CardThemeData(
              color: AppConstants.cardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
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
