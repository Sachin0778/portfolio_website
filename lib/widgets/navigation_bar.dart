import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../utils/size_extensions.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > AppConstants.tabletBreakpoint;

    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
              border: Border.all(color: AppConstants.secondaryColor.withOpacity(0.12)),
              gradient: LinearGradient(
                colors: [
                  AppConstants.surfaceColor.withOpacity(0.72),
                  AppConstants.cardColor.withOpacity(0.48),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withOpacity(0.07),
                  blurRadius: 40,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 0,
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => controller.navigateToSection('home'),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppConstants.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppConstants.secondaryColor.withOpacity(0.45),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppConstants.heroTitleGradient.createShader(bounds),
                          blendMode: BlendMode.srcIn,
                          child: Text(
                            AppConstants.appName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isWide ? 17.sp : 15.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isWide)
                  Expanded(
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _NavItem(
                                title: 'Home',
                                onTap: () => controller.navigateToSection('home'),
                              ),
                              SizedBox(width: 8.w),
                              _NavItem(
                                title: 'About',
                                onTap: () => controller.navigateToSection('about'),
                              ),
                              SizedBox(width: 8.w),
                              _NavItem(
                                title: 'Skills',
                                onTap: () => controller.navigateToSection('skills'),
                              ),
                              SizedBox(width: 8.w),
                              _NavItem(
                                title: 'Projects',
                                onTap: () => controller.navigateToSection('projects'),
                              ),
                              SizedBox(width: 8.w),
                              _NavItem(
                                title: 'Experience',
                                onTap: () => controller.navigateToSection('experience'),
                              ),
                              SizedBox(width: 8.w),
                              _NavItem(
                                title: 'Contact',
                                onTap: () => controller.navigateToSection('contact'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: () => _showMobileMenu(context, controller),
                    icon: Icon(
                      Icons.menu_rounded,
                      color: AppConstants.textPrimary,
                      size: 26.sp,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.06, curve: Curves.easeOutCubic);
  }

  void _showMobileMenu(BuildContext context, PortfolioController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
          border: Border.all(color: AppConstants.secondaryColor.withOpacity(0.15)),
          gradient: LinearGradient(
            colors: [
              AppConstants.surfaceColor.withOpacity(0.98),
              AppConstants.cardColor.withOpacity(0.96),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppConstants.textTertiary.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
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
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animationDuration,
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: _hover ? AppConstants.secondaryColor.withOpacity(0.12) : Colors.transparent,
            border: Border.all(
              color: _hover ? AppConstants.secondaryColor.withOpacity(0.35) : Colors.transparent,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
              color: _hover ? AppConstants.secondaryColor : AppConstants.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: AppConstants.textPrimary,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
