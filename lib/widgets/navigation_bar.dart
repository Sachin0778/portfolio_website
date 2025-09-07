import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge.w,
        vertical: AppConstants.paddingSmall.h,
      ),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: AppConstants.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          

          // Desktop Navigation
          if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint)
            Row(
              children: [
                _NavItem(
                  title: 'Home',
                  onTap: () => controller.navigateToSection('home'),
                ),
                SizedBox(width: 16.w),
                _NavItem(
                  title: 'About',
                  onTap: () => controller.navigateToSection('about'),
                ),
                SizedBox(width: 16.w),
                _NavItem(
                  title: 'Skills',
                  onTap: () => controller.navigateToSection('skills'),
                ),
                SizedBox(width: 16.w),
                _NavItem(
                  title: 'Projects',
                  onTap: () => controller.navigateToSection('projects'),
                ),
                SizedBox(width: 16.w),
                _NavItem(
                  title: 'Experience',
                  onTap: () => controller.navigateToSection('experience'),
                ),
                SizedBox(width: 16.w),
                _NavItem(
                  title: 'Contact',
                  onTap: () => controller.navigateToSection('contact'),
                ),
              ],
            ),

          // Mobile Menu Button
          if (MediaQuery.of(context).size.width <= AppConstants.tabletBreakpoint)
            IconButton(
              onPressed: () => _showMobileMenu(context, controller),
              icon: const Icon(
                Icons.menu,
                color: AppConstants.textPrimary,
              ),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context, PortfolioController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppConstants.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusLarge),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(AppConstants.paddingLarge.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppConstants.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 24.h),
            _MobileNavItem(
              title: 'Home',
              onTap: () {
                controller.navigateToSection('home');
                Navigator.pop(context);
              },
            ),
            _MobileNavItem(
              title: 'About',
              onTap: () {
                controller.navigateToSection('about');
                Navigator.pop(context);
              },
            ),
            _MobileNavItem(
              title: 'Skills',
              onTap: () {
                controller.navigateToSection('skills');
                Navigator.pop(context);
              },
            ),
            _MobileNavItem(
              title: 'Projects',
              onTap: () {
                controller.navigateToSection('projects');
                Navigator.pop(context);
              },
            ),
            _MobileNavItem(
              title: 'Experience',
              onTap: () {
                controller.navigateToSection('experience');
                Navigator.pop(context);
              },
            ),
            _MobileNavItem(
              title: 'Contact',
              onTap: () {
                controller.navigateToSection('contact');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 6.sp,
          fontWeight: FontWeight.w500,
          color: AppConstants.textPrimary,
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY();
  }
}

class _MobileNavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppConstants.paddingMedium.h),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppConstants.textPrimary,
          ),
        ),
      ),
    );
  }
}
